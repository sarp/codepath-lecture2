//
//  PhotosViewController.m
//  InstagramClone
//
//  Created by Sarp Centel on 2/5/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "PhotoDetailsViewController.h"

@interface PhotosViewController ()
@property (nonatomic,strong) NSArray *photos;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.photoTableView.dataSource = self;
    self.photoTableView.delegate = self;
    self.photoTableView.rowHeight = 320;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.photoTableView insertSubview:self.refreshControl atIndex:0];
    
    
    UINib *cell = [UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil];
    [self.photoTableView registerNib:cell forCellReuseIdentifier:@"PhotoTableViewCell"];
    
    
    
    [self loadData];
    
}

-(void)loadData {
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=eb53a9c745b5457e86d20aa5afb5022b"];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.photos = responseDictionary[@"data"];
        NSLog(@"Response: %@", responseDictionary);
        [self.photoTableView reloadData];
    }];
}

-(void) onRefresh {
    NSLog(@"OnRefresh");
    [self loadData];
    [self.refreshControl endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell" forIndexPath:indexPath];

    NSDictionary *photo = self.photos[indexPath.row];
    NSURL *imgURL = [NSURL URLWithString:[photo valueForKeyPath:@"images.standard_resolution.url"]];
    NSLog(@"%@", [photo valueForKeyPath:@"images.standard_resolution.url"]);
    [cell.photoView setImageWithURL:imgURL];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoDetailsViewController *controller = [[PhotoDetailsViewController alloc] init];
    controller.photoDetails = self.photos[indexPath.row];

    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

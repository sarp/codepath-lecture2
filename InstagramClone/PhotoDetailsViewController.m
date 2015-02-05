//
//  PhotoDetailsViewController.m
//  InstagramClone
//
//  Created by Sarp Centel on 2/5/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "PhotoTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *detailsTable;

@end

@implementation PhotoDetailsViewController

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell" forIndexPath:indexPath];

    NSURL *imgURL = [NSURL URLWithString:[self.photoDetails valueForKeyPath:@"images.standard_resolution.url"]];

    [cell.photoView setImageWithURL:imgURL];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailsTable.dataSource = self;
    self.detailsTable.delegate = self;
    self.detailsTable.rowHeight = 320;
    
    UINib *cell = [UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil];
    [self.detailsTable registerNib:cell forCellReuseIdentifier:@"PhotoTableViewCell"];
    
    NSLog(@"Details: %@", self.photoDetails);
    // Do any additional setup after loading the view from its nib.
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

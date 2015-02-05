//
//  PhotoDetailsViewController.h
//  InstagramClone
//
//  Created by Sarp Centel on 2/5/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSDictionary *photoDetails;

@end

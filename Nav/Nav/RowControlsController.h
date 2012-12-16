//
//  RowControlsController.h
//  Nav
//
//  Created by liuwei on 12-12-16.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "SecondLevelViewController.h"

@interface RowControlsController : SecondLevelViewController
@property (strong, nonatomic) NSArray *list;

- (IBAction)buttonTapped:(id)sender;

@end

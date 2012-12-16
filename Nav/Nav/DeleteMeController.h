//
//  DeleteMeController.h
//  Nav
//
//  Created by liuwei on 12-12-16.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "SecondLevelViewController.h"

@interface DeleteMeController : SecondLevelViewController
@property (strong, nonatomic) NSMutableArray *list;
- (IBAction)toggleEdit:(id)sender;

@end

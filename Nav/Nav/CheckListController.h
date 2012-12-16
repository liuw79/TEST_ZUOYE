//
//  CheckListController.h
//  Nav
//
//  Created by liuwei on 12-12-16.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "SecondLevelViewController.h"

@interface CheckListController : SecondLevelViewController
@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) NSIndexPath *lastIndexPath;

@end

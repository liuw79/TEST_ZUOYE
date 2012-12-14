//
//  ViewController.h
//  TableTest2
//
//  Created by liuwei on 12-12-14.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCell.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView * tableView;
@property (retain, nonatomic) NSArray * dataArray;



@end

//
//  ViewController.m
//  JsonTest
//
//  Created by LIU WEI on 12-12-17.
//  Copyright (c) 2012年 LIU WEI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array = [NSArray arrayWithObjects:@"11", @"22", @"33", nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@", data);
    
    NSArray *array2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@", array2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

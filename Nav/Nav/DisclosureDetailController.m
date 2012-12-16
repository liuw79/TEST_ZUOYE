//
//  DisclosureDetailController.m
//  Nav
//
//  Created by liuwei on 12-12-16.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "DisclosureDetailController.h"

@interface DisclosureDetailController ()

@end

@implementation DisclosureDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.label.text = self.message;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

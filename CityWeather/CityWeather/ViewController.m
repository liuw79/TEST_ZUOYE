//
//  ViewController.m
//  CityWeather
//
//  Created by LIU WEI on 12-12-18.
//  Copyright (c) 2012年 LIU WEI. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+Json.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSDictionary *city = [NSDictionary dictionaryWithContentsOfURLString:@"http://www.weather.com.cn/data/cityinfo/101010100.html"];
    
    NSLog(@"city: %@", [[city valueForKey:@"weatherinfo"] valueForKey:@"city"]);
    
    NSDictionary *myInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"tony", @"apple", @"anny", @"ada", nil];
    
    NSData *json = [myInfo toJSON];
    
    NSLog(@"json: %@", [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  SlowWorkerGCD
//
//  Created by liuwei on 12-12-14.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSString *)fetchSomethingFromServer
{
    [NSThread sleepForTimeInterval:1];
    return @"Hi here";
}

- (NSString *)processData:(NSString *)data
{
    [NSThread sleepForTimeInterval:2];
    return [data uppercaseString];
}

- (NSString *)calculateFirstResult:(NSString *)data
{
    [NSThread sleepForTimeInterval:3];
    return [NSString stringWithFormat:@"Number of chars: %d", [data length]];
}

- (NSString *)calculateSecondResult:(NSString *)data
{
    [NSThread sleepForTimeInterval:4];
    return [data stringByReplacingOccurrencesOfString:@"E" withString:@"e"];
}

- (void)doWork:(id)sender
{
    self.startButton.enabled = NO;
    self.startButton.alpha = 0.5;
    [self.spinner startAnimating];
    
    NSDate *startTime = [NSDate date];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *fetchedData = [self fetchSomethingFromServer];
        NSString *processedData = [self processData:fetchedData];
        NSString *firstResult = [self calculateFirstResult:processedData];
        NSString *secondResult = [self calculateSecondResult:processedData];
        
        NSString *summaryResult = [NSString stringWithFormat:@"First result:[%@] \nSecond result:[%@] ", firstResult, secondResult];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.startButton.enabled = YES;
            self.startButton.alpha = 1.0;
            [self.spinner stopAnimating];
            [self.resultsTextView setText:summaryResult];
        });
        
        NSDate *endTime = [NSDate date];
        NSLog(@"Completed in %f second", [endTime timeIntervalSinceDate:startTime]);
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_startButton release];
    [_resultsTextView release];
    [super dealloc];
}
@end

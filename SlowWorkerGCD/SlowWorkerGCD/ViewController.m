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
    [NSThread sleepForTimeInterval:1.5];
    return [data uppercaseString];
}

- (NSString *)calculateFirstResult:(NSString *)data
{
    [NSThread sleepForTimeInterval:2];
    return [NSString stringWithFormat:@"Number of chars: %d", [data length]];
}

- (NSString *)calculateSecondResult:(NSString *)data
{
    [NSThread sleepForTimeInterval:3];
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
        
        //__block storage modifier. This ensures the values set inside the blocks are made available to the code that runs later
        __block NSString *firstResult;
        __block NSString *secondResult;
        
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            firstResult = [[self calculateFirstResult:processedData] retain];
        });
        
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            secondResult = [[self calculateSecondResult:processedData] retain];
        });
        
        //use dispatch_group_notify() to specify an additional block that will be executed when all the blocks in the group have been run to completion
        dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
            NSString *summaryResult = [NSString stringWithFormat:@"First result:[%@] \nSecond result:[%@] ", firstResult, secondResult];
            [firstResult release];
            [secondResult release];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.startButton.enabled = YES;
                self.startButton.alpha = 1.0;
                [self.spinner stopAnimating];
                [self.resultsTextView setText:summaryResult];
            });
            
            NSDate *endTime = [NSDate date];
            NSLog(@"Completed in %f second", [endTime timeIntervalSinceDate:startTime]);
        });
        
        dispatch_release(group);  //
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_startButton release];
    _startButton = nil;
    
    [_resultsTextView release];
    _resultsTextView = nil;
    [_spinner release];
    _spinner = nil;
    [super dealloc];
}
@end

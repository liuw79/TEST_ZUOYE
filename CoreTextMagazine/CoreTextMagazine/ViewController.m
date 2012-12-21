//
//  ViewController.m
//  CoreTextMagazine
//
//  Created by liuwei on 12-12-19.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "ViewController.h"
#import "CTView.h"
#import "MarkupParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"test3" ofType:@"txt"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    MarkupParser* p = [[MarkupParser alloc] init];
    NSAttributedString* attString = [p attrStringFromMarkup:text];
    [(CTView*)self.view setAttString: attString];
    
    [(CTView *)[self view] buildFrames];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

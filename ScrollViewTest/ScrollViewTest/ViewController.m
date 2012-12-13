//
//  ViewController.m
//  ScrollViewTest
//
//  Created by liuwei on 12-12-13.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (retain, nonatomic) UITextView *textView;
@property (retain, nonatomic) UILabel *label;

- (IBAction)countKeyword:(id)sender;
- (IBAction)disKeybd:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //搜索按钮
    CGRect btnFrame1 = CGRectMake(10, 15, 80, 30);
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setFrame:btnFrame1];
    [btn1 setTitle:@"搜索" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(countKeyword:) forControlEvents:UIControlEventTouchUpInside];
    
    //搞掂按钮
    CGRect btnFrame2 = CGRectMake(100, 15, 80, 30);
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setFrame:btnFrame2];
    [btn2 setTitle:@"搞掂" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(disKeybd:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //输出显示
    CGRect lblFrame = CGRectMake(200, 15, 100, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:lblFrame];
    [self setLabel:label];
    [self.label setBackgroundColor:[UIColor darkGrayColor]];
    [self.label setTextColor:[UIColor whiteColor]];
    [label release];
    
    //做一个键盘跟随的工具条
    UIView *accView = [[[UIView alloc] initWithFrame:CGRectMake(0, 200, 320, 50)] autorelease];
    [accView addSubview:btn1];
    [accView addSubview:btn2];
    [accView addSubview:self.label];
    
    //添加 textView
    CGRect tvFrame = CGRectMake(0, 0, 320, 200);
    UITextView *tv = [[UITextView alloc] initWithFrame:tvFrame];
    [tv setFont: [UIFont fontWithName:@"ArialUnicodeMS" size:18]];
    [tv setTextColor:[UIColor grayColor]];
    [tv setInputAccessoryView: accView];
    [self setTextView: tv];
    [self.textView setText: @"从前有座山，山上有座庙，庙里有一个老和尚和一个小和尚，有一天，老和尚给小和尚讲了一个故事：“从前有座山……”。"];
    [self.view addSubview:self.textView];
    [tv release];
}

//搜索事件
- (void)countKeyword:(id)sender
{
    [self countStr];
}

//搞掂事件
- (void)disKeybd:(id)sender
{
    [self.textView resignFirstResponder];
}

//检索数量
-(void) countStr
{
    @autoreleasepool
    {
        NSString *s1 = @"和尚";
        NSString *s2 = [NSString stringWithString:self.textView.text];
        
        NSRange subRange = NSMakeRange(0, 0);
        NSRange tmpRange = NSMakeRange(0, s2.length);
        NSInteger i = 0;
        
        do {
            subRange = [s2 rangeOfString:s1
                                 options:NSCaseInsensitiveSearch
                                   range:tmpRange];
            
            NSLog(@"第 %d 个\"%@\" 的位置是: %u", i+1 , s1, subRange.location);
            
            i = i + 1;
            
            tmpRange = NSMakeRange(subRange.location + subRange.length, s2.length - (subRange.location+ subRange.length));
        } while ( [s2 rangeOfString:s1 options:NSCaseInsensitiveSearch range:tmpRange].location != NSNotFound && tmpRange.length >= 4 );
        
        self.label.text = [NSString stringWithFormat:@" 有%d个%@。", i, s1];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_textView release];
    _textView = nil;
    
    [_label release];
    _label = nil;
    
    [super dealloc];
}

@end

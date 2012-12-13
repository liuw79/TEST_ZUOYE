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
@property (retain, nonatomic) UIView *toolView;
@property CGRect screenFrame;

- (IBAction)countKeyword:(id)sender;
- (IBAction)disKeybd:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //获取全屏 Frame
    self.screenFrame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 20) ;
    
    //搜索按钮
    CGRect btnFrame1 = CGRectMake(10, 5, 80, 30);
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setFrame:btnFrame1];
    [btn1 setTitle:@"搜索" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(countKeyword:) forControlEvents:UIControlEventTouchUpInside];
    
    //搞掂按钮
    CGRect btnFrame2 = CGRectMake(100, 5, 80, 30);
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setFrame:btnFrame2];
    [btn2 setTitle:@"搞掂" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(disKeybd:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //输出显示
    CGRect lblFrame = CGRectMake(200, 5, 100, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:lblFrame];
    [self setLabel:label];
    [self.label setBackgroundColor:[UIColor darkGrayColor]];
    [self.label setTextColor:[UIColor whiteColor]];
    [label release];
    
    //做一个键盘跟随的工具条
    UIView *toolView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];  //y 值任意，不影响此 View 动态跟随在键盘上方
    [self setToolView: toolView];
    [toolView release];
    [self.toolView addSubview:btn1];
    [self.toolView addSubview:btn2];
    [self.toolView addSubview:self.label];
    
    //添加 textView
    UITextView *tv = [[UITextView alloc] initWithFrame:self.screenFrame];
    [tv setFont: [UIFont fontWithName:@"ArialUnicodeMS" size:18]];
    [tv setTextColor:[UIColor grayColor]];
    [tv setInputAccessoryView: self.toolView];
    [self setTextView: tv];
    [self.textView setText: @"从前有座山，山上有座庙，庙里有一个老和尚和一个小和尚，有一天，老和尚给小和尚讲了一个故事：“从前有座山……”。"];
    [self.view addSubview:self.textView];
    [tv release];
    
    //添加键盘消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    NSLog(@"full textView: %@", NSStringFromCGRect(self.screenFrame));
}

//键盘弹出时候，调整 TextView的高度
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = self.screenFrame;
    bkgndRect.size.height -= kbSize.height;
    [self.textView setFrame:bkgndRect];
    NSLog(@"%f", kbSize.height);
    NSLog(@"small textView: %@", NSStringFromCGRect(bkgndRect));
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
    [self.textView setFrame:self.screenFrame];
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
        
        self.label.text = [NSString stringWithFormat:@" 有%d个%@", i, s1];
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
    
    [_toolView release];
    _toolView = nil;
    
    [super dealloc];
}

@end

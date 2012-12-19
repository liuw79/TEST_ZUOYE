//
//  CoreTextView.h
//  BookTest
//
//  Created by liuwei on 12-12-19.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CoreTextView : UIView

@property(nonatomic, retain) NSString *text;
@property(nonatomic, assign) NSInteger columnCount;
@property(nonatomic, assign) NSInteger fontSize;
@property(nonatomic, assign) CTTextAlignment textAlignment;

@end

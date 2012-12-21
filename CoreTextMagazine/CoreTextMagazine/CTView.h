//
//  CTView.h
//  CoreTextMagazine
//
//  Created by liuwei on 12-12-19.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//


#import "MarkupParser.h"
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import "CTColumnView.h"

@interface CTView : UIScrollView<UIScrollViewDelegate>

@property float frameXOffset;
@property float frameYOffset;

@property (retain, nonatomic) NSAttributedString* attString;
@property (retain, nonatomic) NSMutableArray* frames;

- (void)buildFrames;

@end

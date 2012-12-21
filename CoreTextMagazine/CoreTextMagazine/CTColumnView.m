//
//  CTColumnView.m
//  CoreTextMagazine
//
//  Created by liuwei on 12-12-21.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "CTColumnView.h"

@implementation CTColumnView

- (void)setCTFrame:(id)f
{
    ctFrame = f;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameDraw((__bridge CTFrameRef)ctFrame, context);
}

@end

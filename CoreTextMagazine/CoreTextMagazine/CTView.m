//
//  CTView.m
//  CoreTextMagazine
//
//  Created by liuwei on 12-12-19.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//  http://www.raywenderlich.com/4147/how-to-create-a-simple-magazine-app-with-core-text

#import "CTView.h"
#import <CoreText/CoreText.h>

@implementation CTView

- (void)buildFrames
{
    //here we do some setup - define the x & y offsets, enable paging and create an empty frames array
    self.frameXOffset = 20;  //1  
    self.frameYOffset = 20;
    self.pagingEnabled = YES;
    self.delegate = self;
    self.frames = [NSMutableArray array];
    
    //buildFrames continues by creating a path and a frame for the view's bounds (offset slightly so we have a margin).
    CGMutablePathRef path = CGPathCreateMutable();  //2
    CGRect textFrame = CGRectInset(self.bounds, self.frameXOffset, self.frameYOffset);
    CGPathAddRect(path, NULL, textFrame);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attString);
    
    //buildFrames continues by creating a path and a frame for the view's bounds (offset slightly so we have a margin).
    int textPos = 0;  //3
    int columnIndex = 0;
    
    //The while loop here runs until we've reached the end of the text. Inside the loop we create a column bounds: colRect is a CGRect which depending on columnIndex holds the origin and size of the current column. Note that we are building columns continuously to the right (not across and then down).
    while (textPos < [self.attString length])  //4
    {
        CGPoint colOffset = CGPointMake((columnIndex + 1)*self.frameXOffset + columnIndex*(textFrame.size.width/2), 20);
        CGRect colRect = CGRectMake(0, 0, textFrame.size.width/2 - 10, textFrame.size.height - 40);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, colRect);
        
        //use the column path
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
        CFRange frameRange = CTFrameGetVisibleStringRange(frame);
        
        //create an empty column view  5 This makes use of CTFrameGetVisibleStringRange function to figure out what portion of the string can fit in the frame (a text column in this case). textPos is incremented by the length of this range, and so the building of the next column can begin on the next loop (if there's more text remaining).
        CTColumnView* content = [[CTColumnView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
        content.backgroundColor = [UIColor clearColor];
        content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height);
        
        //set the column view contents and add it as subview
        [content setCTFrame:(__bridge id)frame];   //6
        [self.frames addObject:(__bridge id)frame];
        [self addSubview:content];
        
        //prepare for next frame
        textPos += frameRange.length;
        
        //release(frame)
        CFRelease(path);
        
        columnIndex ++;
    }
    //set the total width of the scroll view
    int totalPages = (columnIndex + 1)/2;   //7
    self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
}

- (void)dealloc
{
    _attString = nil;
    _frames = nil;
}

@end

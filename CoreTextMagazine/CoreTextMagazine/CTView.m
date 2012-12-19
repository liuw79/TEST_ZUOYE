//
//  CTView.m
//  CoreTextMagazine
//
//  Created by liuwei on 12-12-19.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//  http://www.raywenderlich.com/4147/how-to-create-a-simple-magazine-app-with-core-text

#import "CTView.h"

@implementation CTView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //把颠倒的文字纠正过来：
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //1 Here you need to create a path which bounds the area where you will be drawing text. Core Text on the Mac supports different shapes like rectangles and circles, but for the moment iOS supports only rectangular shape for drawing with Core Text. In this simple example, you’ll use the entire view bounds as the rectangle where you will be drawing by creating a CGPath reference from self.bounds
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    //2 In Core Text you won’t be using NSString, but rather NSAttributedString, as shown here. NSAttributedString is a very powerful NSString derivate class, which allows you apply formatting attributes to text. For the moment we won’t be using formatting – this just creates a string holding plain text.
    NSAttributedString* attString = [[NSAttributedString alloc] initWithString:@"Hello world core text!"];
    
    //3 create a CTFramesetter reference
    //CTFramesetter is the most important class to use when drawing with Core Text. It manages your font references and your text drawing frames. For the moment what you need to know is that CTFramesetterCreateWithAttributedString creates a CTFramesetter for you, retains it and initializes it with the supplied attributed string. In this section, after you have the framesetter you create a frame, you give the CTFramesetterCreateFrame a range of the string to render (we choose the entire string here) and the rectangle where the text will appear when drawn.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    
    //4 Here CTFrameDraw draws the supplied frame in the given context.
    CTFrameDraw(frame, context);
    
    //5 Finally, all the used objects are released.
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
}

@end

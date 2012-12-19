//
//  CoreTextView.m
//  BookTest
//
//  Created by liuwei on 12-12-19.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "CoreTextView.h"

@implementation CoreTextView
@synthesize text;
@synthesize columnCount;
@synthesize fontSize;
@synthesize textAlignment;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
		columnCount = 2;
		fontSize = 16;
		textAlignment = kCTJustifiedTextAlignment;
		
		text = @"《汤姆叔叔的小屋》是美国作家哈里特·比彻·斯托于1852年发表的一部反奴隶制小说。这部小说中关于非裔美国人与美国奴隶制度历史的观点曾产生过意义深远的影响，并在某种程度上激化了导致美国内战的地区局部冲突。全书围绕着一位久经苦难的黑奴汤姆叔叔的故事展开，并描述了他与他身边人（均为奴隶与奴隶主）的经历。这部感伤小说深刻地描绘出了奴隶制度残酷的本质；并认为基督徒的爱可以战胜由奴役人类同胞所带来的种种伤害。这部小说是19世纪最畅销的小说。《汤姆叔叔的小屋》以及受其启发而写作出的各种剧本，还促进了大量黑人刻板印象的产生，不少的这些形象在当今都为人们所熟知。";
    }
    return self;

}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
}

- (void)drawText:(CGContextRef)context
{
    CTFontRef font = CTFontCreateWithName((CFStringRef)@"Georgia", fontSize, NULL);
    NSDictionary *attribs = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font, kCTFontAttributeName, nil];
    NSMutableAttributedString *attribString = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
    CFRelease(font);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTParagraphStyleSetting settings[] = {{ kCTParagraphStyleSpecifierAlignment, sizeof(textAlignment), &textAlignment }};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attribString, CFRangeMake(0, [text length]), kCTParagraphStyleAttributeName, paragraphStyle);
    CFRelease(paragraphStyle);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attribString);
    
    CFIndex textRangeStart = 0;
    
    //未完成，From ParticleText
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	[self drawText:context];
}

@end





























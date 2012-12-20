//
//  MarkupParser.m
//  CoreTextMagazine
//
//  Created by liuwei on 12-12-19.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "MarkupParser.h"

@implementation MarkupParser
@synthesize font, color, strokeColor, strokeWidth;
@synthesize images;

-(id)init
{
    self = [super init];
    if (self) {
        self.font = @"ArialMT";
        self.color = [UIColor blackColor];
        self.strokeColor = [UIColor whiteColor];
        self.strokeWidth = 0.0;
        self.images = [NSMutableArray array];
    }
    return self;
}

-(NSAttributedString*)attrStringFromMarkup:(NSString*)markup
{
    NSMutableAttributedString* aString = [[NSMutableAttributedString alloc] initWithString:@""];
    //create a regex to match chunks of text and tags. This regex will basically match a string of text and a following tag. The regular expression basically says "Look for any number of characters, until you come across an opening bracket. Then match any number of characters until you hit a closing bracket. Or - stop processing when you hit the end of the string."
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:@"(.*?)(<[^>]+>|\\Z)" options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:nil];
    
    NSArray* chunks = [regex matchesInString:markup options:0 range:NSMakeRange(0, [markup length])];
    NSLog(@"chunks: %@", chunks);
    
    for (NSTextCheckingResult* b in chunks) {
        //You iterate over the chunks matched by the prior regular expression, and in this section you split the chunks by the "<" character (the tag opener). As a result, in parts[0] you have the text to add to the result and in parts[1] you have the content of the tag that changes the formatting for the text that follows.
        NSArray* parts = [[markup substringWithRange:b.range]
                          componentsSeparatedByString:@"<"]; //1
        NSLog(@"parts: %@", parts);
        
        CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)self.font,24.0f, NULL);
        
        //apply the current text style //2
        //Next you create a dictionary holding a number of formatting options - this is the way you can pass formatting attributes to a NSAttributedString. Have a look at the key names - they are Apple defined constants which are pretty self-explanatory (of you can check out Apple's Core Text String Attributes Reference for full details). By calling appendAttributedString: the new text chunk with applied formatting is added to the result string.
        NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               (id)self.color.CGColor, NSForegroundColorAttributeName,
                               (__bridge id)fontRef, NSFontAttributeName,
                               (id)self.strokeColor.CGColor, (NSString *)kCTStrokeColorAttributeName,
                               (id)[NSNumber numberWithFloat: self.strokeWidth], (NSString *)kCTStrokeWidthAttributeName,
                               nil];
        [aString appendAttributedString:[[NSAttributedString alloc] initWithString:[parts objectAtIndex:0] attributes:attrs]];
        //NSLog(@"aString: %@", aString);
        
        CFRelease(fontRef);
        
        //handle new formatting tag //3
        if ([parts count]>1) {
            NSString* tag = (NSString*)[parts objectAtIndex:1];
            if ([tag hasPrefix:@"font"]) {
                //stroke color
                NSRegularExpression* scolorRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=strokeColor=\")\\w+" options:0 error:NULL];
                [scolorRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
                    if ([[tag substringWithRange:match.range] isEqualToString:@"none"]) {
                        self.strokeWidth = 0.0;
                    } else {
                        self.strokeWidth = -3.0;
                        SEL colorSel = NSSelectorFromString([NSString stringWithFormat: @"%@Color", [tag substringWithRange:match.range]]);
                        self.strokeColor = [UIColor performSelector:colorSel];
                    }
                }];
                
                //color
                NSRegularExpression* colorRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=color=\")\\w+" options:0 error:NULL];
                [colorRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
                    SEL colorSel = NSSelectorFromString([NSString stringWithFormat: @"%@Color", [tag substringWithRange:match.range]]);
                    self.color = [UIColor performSelector:colorSel];
                }];
                
                //face
                NSRegularExpression* faceRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=face=\")[^\"]+" options:0 error:NULL];
                [faceRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
                    self.font = [tag substringWithRange:match.range];
                }];
            } //end of font parsing
        }
    }
    
    return (NSAttributedString*)aString;
}

@end

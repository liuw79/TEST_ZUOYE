//
//  MyImageView.m
//  CarMag
//
//  Created by LIU WEI on 12-12-22.
//  Copyright (c) 2012年 LIU WEI. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

- (id)initWithImageName:(NSString*)imageName ofType:(NSString*)imageType atLocation:(CGPoint)imagePoint
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:imageType];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    CGRect frame = CGRectMake(imagePoint.x, imagePoint.y, image.size.width, image.size.height);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.image = image;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

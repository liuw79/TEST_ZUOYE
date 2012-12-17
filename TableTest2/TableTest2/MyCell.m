//
//  MyCell.m
//  TableTest2
//
//  Created by liuwei on 12-12-14.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        lable.text = @"888";
        [self addSubview:lable];
        [lable release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_nameLabel release];
    [_ageLabel release];
    [super dealloc];
}
@end

//
//  BIDPresident.h
//  Nav
//
//  Created by liuwei on 12-12-16.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPresidentNumberKey @"President"
#define kPresidentNameKey @"Name"
#define kPresidentFromKey @"FromYear"
#define kPresidentToKey @"ToYear"
#define kPresidentPartyKey @"Party"

@interface BIDPresident : NSObject<NSCoding>

@property int number;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fromYear;
@property (nonatomic, copy) NSString *toYear;
@property (nonatomic, copy) NSString *party;

@end

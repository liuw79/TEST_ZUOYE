//
//  Magazine.h
//  CarMag
//
//  Created by LIU WEI on 12-12-22.
//  Copyright (c) 2012年 LIU WEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Magazine : NSObject

@property (strong, nonatomic) NSString *coverImagePath;
@property (strong, nonatomic) NSArray *index;
@property (strong, nonatomic) NSNumber *year;
@property (strong, nonatomic) NSNumber *month;
@property (strong, nonatomic) NSNumber *serialNumber;
@property (strong, nonatomic) NSString *firstTopic;

@end

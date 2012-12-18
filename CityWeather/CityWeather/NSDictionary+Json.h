//
//  NSDictionary+Json.h
//  CityWeather
//
//  Created by LIU WEI on 12-12-18.
//  Copyright (c) 2012年 LIU WEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)
+(NSDictionary *)dictionaryWithContentsOfURLString:(NSString *)urlAddress;

-(NSData *)toJSON;

@end

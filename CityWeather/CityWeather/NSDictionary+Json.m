//
//  NSDictionary+Json.m
//  CityWeather
//
//  Created by LIU WEI on 12-12-18.
//  Copyright (c) 2012年 LIU WEI. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)

//Remote Data of URL to Dic
+ (NSDictionary *)dictionaryWithContentsOfURLString:(NSString *)urlAddress
{
    //请求远程数据，存到NSData
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlAddress]];
    
    //定义一个错误信息对象
    __autoreleasing NSError *error = nil;
    
    //serialization string
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions
                                                  error:&error];
    
    if (error != nil) {
        return nil;
    }
    
    return result;
}

//DIC to JSON
- (NSData *)toJSON
{
    NSError *error = nil;
    
    //DIC to JSON
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    
    if (error != nil) {
        return nil;
    }
    
    return result;
}

@end

//
//  myDataViewController.h
//  CityWeather
//
//  Created by LIU WEI on 12-12-18.
//  Copyright (c) 2012年 LIU WEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+Json.h"

@interface myDataViewController : UITableViewController
{
    //current page
    int _index;
    
    //page size
    int _size;
}

//city Dic
@property NSDictionary *dictCity;
//all weather city
@property NSArray *listCity;
//to load city
@property NSMutableArray *pageingCity;

@end

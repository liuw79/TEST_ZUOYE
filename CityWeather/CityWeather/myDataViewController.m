//
//  myDataViewController.m
//  CityWeather
//
//  Created by LIU WEI on 12-12-18.
//  Copyright (c) 2012年 LIU WEI. All rights reserved.
//

#import "myDataViewController.h"

@interface myDataViewController ()

@end

@implementation myDataViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _index = 1;
    _size = 3;
    
    //get plist data
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"];
    self.dictCity = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.listCity = [[self.dictCity allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.pageingCity = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _size; i ++) {
        [self.pageingCity addObject:[self.listCity objectAtIndex:i]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pageingCity.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //last row : Display more... or Nothing
    if ([indexPath row] == self.pageingCity.count) {
        if (indexPath.row == self.listCity.count) {
            cell.textLabel.text = @"没有了";
            cell.detailTextLabel.text = @"";
        }
        else
        {
            cell.textLabel.text = @"加载更多...";
            cell.detailTextLabel.text = @"10 more city";
        }
        cell.accessoryType  = UITableViewCellAccessoryNone;
    }
    else
    {
        //get city name
        NSString *title = [self.listCity objectAtIndex:indexPath.row];
        //get city code
        NSString *code = [self.dictCity objectForKey:title];
        //set Cell
        cell.textLabel.text = title;
        cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"code: %@", code];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    return cell;
}

//to last row, automatic loading data
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.pageingCity count]) {
        NSLog(@"index path:%d", indexPath.row);
        
        //_size>20 to open this:
        //[self loadMoreEvent:tableView ofPath:indexPath];
    }
    return;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.pageingCity.count) {
         [self loadMoreEvent:tableView ofPath:indexPath];
    }
    else
    {
        NSString *title = [self.listCity objectAtIndex:indexPath.row];
        NSString *code = [self.dictCity objectForKey:title];
        NSString *url = [[NSString alloc] initWithFormat:@"http://m.weather.com.cn/data/%@.html", code];
        
        NSLog(@"%@", url);
        //remote data to Dic
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURLString:url];
        
        //get weather Details
        NSDictionary *weather = [dict objectForKey:@"weatherinfo"];
        NSString *date = [weather objectForKey:@"date_y"];
        NSString *week = [weather objectForKey:@"week"];
        NSString *wd = [weather objectForKey:@"temp1"];
        NSString *tq = [weather objectForKey:@"weather1"];
        NSString *city = [weather objectForKey:@"city"];
        NSString *jy = [weather objectForKey:@"index_d"];
        
        NSString *msg = [[NSString alloc] initWithFormat:@"city: %@ \r time: %@ %@ \r temp: %@  \r weather: %@  \r suggestion: %@", city, date, week, wd, tq, jy];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)loadMoreEvent:(UITableView *)tableView ofPath:(NSIndexPath *)indexPath
{
    int page = (int)(self.listCity.count/_size);
    if (self.listCity.count % _size > 0) {
        page ++;
    }
    if (_index) {
         UITableViewCell *loadMoreCell = [tableView cellForRowAtIndexPath:indexPath];
         _index ++;
         loadMoreCell.textLabel.text = @"正在加载中...";
         loadMoreCell.detailTextLabel.text = @"";
         [self performSelectorInBackground:@selector(loadMore) withObject:nil];
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    return;
}

- (void)loadMore
{
    NSMutableArray *more = [[NSMutableArray alloc] initWithCapacity:100];
    int begin = (_index - 1)*_size;
    int end = begin + _size;
    if (end > self.listCity.count) {
        end = self.listCity.count;
    }
    
    for (int i = begin; i <= end; i ++)
    {
        [more addObject:[self.listCity objectAtIndex:i]];
    }
    
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
}

 // 添加数据到当前TableView中去
 -(void) appendTableWith:(NSMutableArray *)data
 {
    // 添加到当前的数据源中
    for (int i=0; i<[data count]; i++) {
           [self.pageingCity addObject:[data objectAtIndex:i]];
    }
  
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:[data count]];
    for(int ind =0;ind<[data count];ind++)
   {
         NSIndexPath *newPath = [NSIndexPath indexPathForRow:[self.pageingCity indexOfObject:[data objectAtIndex:ind]] inSection:0];
         [insertIndexPaths addObject:newPath];
     }
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
 
    // 选到当前的行数
    int begin = (_index-1)*_size;
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:begin inSection:0];
      [self.tableView selectRowAtIndexPath:indexPath  animated:YES scrollPosition:UITableViewScrollPositionTop];
 }

@end




























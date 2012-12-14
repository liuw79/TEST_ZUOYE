//
//  ViewController.m
//  TableTest2
//
//  Created by liuwei on 12-12-14.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"小黄", @"Name", @"1", @"Age", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"小黑", @"Name", @"2", @"Age", nil];
    NSArray *array = [[NSArray alloc] initWithObjects:dic1, dic2, nil];
    
    self.dataArray = array;
    
    [array release];
}

#pragma -
#pragma TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataArray objectAtIndex:[indexPath row]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You choosed." message:[dic objectForKey:@"Name"]  delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    [alert show];
    [alert release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

#pragma TableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ident = @"simpleTableCell";
    
    //MyCell *cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (cell == nil)
    {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil];
//        cell = (MyCell *)[nib objectAtIndex:0];
        cell = [[MyCell alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    }
    
    NSDictionary *dic = [self.dataArray objectAtIndex:[indexPath row]];
    
    cell.nameLabel.text = [dic objectForKey:@"Name"];
    cell.ageLabel.text = [dic objectForKey:@"Age"];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_dataArray release];
    _dataArray = nil;
    
    [_tableView release];
    _tableView = nil;
    
    [super dealloc];
}

@end

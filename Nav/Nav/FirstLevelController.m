//
//  FirstLevelController.m
//  Nav
//
//  Created by liuwei on 12-12-16.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "FirstLevelController.h"
#import "SecondLevelViewController.h"
#import "DisclosureButtonController.h"
#import "CheckListController.h"
#import "RowControlsController.h"
#import "MoveMeController.h"
#import "DeleteMeController.h"

@interface FirstLevelController ()

@end

@implementation FirstLevelController

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

    self.title = @"First Level";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    DisclosureButtonController *dbtnController = [[DisclosureButtonController alloc] initWithStyle:UITableViewStylePlain];
    dbtnController.title = @"disclosure Buttons";
    dbtnController.rowImage = [UIImage imageNamed:@"disclosureButtonControllerIcon.png"];
    [array addObject:dbtnController];
    
    // Checklist
    CheckListController *checkListController = [[CheckListController alloc]
                                                   initWithStyle:UITableViewStylePlain];
    checkListController.title = @"Check One";
    checkListController.rowImage = [UIImage imageNamed:@"checkmarkControllerIcon.png"];
    [array addObject:checkListController];
    
    // Table Row Controls
    RowControlsController *rowControlsController =
    [[RowControlsController alloc]
     initWithStyle:UITableViewStylePlain];
    rowControlsController.title = @"Row Controls";
    rowControlsController.rowImage = [UIImage imageNamed:@"rowControlsIcon.png"];
    [array addObject:rowControlsController];
    
    // Move Me
    MoveMeController *moveMeController = [[MoveMeController alloc]
                                             initWithStyle:UITableViewStylePlain];
    moveMeController.title = @"Move Me";
    moveMeController.rowImage = [UIImage imageNamed:@"moveMeIcon.png"];
    [array addObject:moveMeController];
    
    // Delete Me
    DeleteMeController *deleteMeController = [[DeleteMeController alloc]
                                                 initWithStyle:UITableViewStylePlain];
    deleteMeController.title = @"Delete Me";
    deleteMeController.rowImage = [UIImage imageNamed:@"deleteMeIcon.png"];
    [array addObject:deleteMeController];
    
    self.controllers = array;
    [array release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.controllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    SecondLevelViewController *controller = [self.controllers objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.imageView.image = controller.rowImage;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    static NSString *FirstLevelCell = @"FirstLevelCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
//                             FirstLevelCell];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]
//                initWithStyle:UITableViewCellStyleDefault reuseIdentifier: FirstLevelCell];
//    }
//    // Configure the cell
//    NSUInteger row = [indexPath row]; SecondLevelViewController *controller =
//    [self.controllers objectAtIndex:row];
//    cell.textLabel.text = controller.title;
//    cell.imageView.image = controller.rowImage;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; return cell;
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    SecondLevelViewController *nextController = [self.controllers objectAtIndex:row];
    [self.navigationController pushViewController:nextController animated:YES];
}

@end

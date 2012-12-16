//
//  DisclosureButtonController.m
//  Nav
//
//  Created by liuwei on 12-12-16.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "DisclosureButtonController.h"
#import "AppDelegate.h"
#import "DisclosureDetailController.h"

@interface DisclosureButtonController ()

@property (strong, nonatomic) DisclosureDetailController *childController;

@end

@implementation DisclosureButtonController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSArray *array = [[NSArray alloc] initWithObjects:@"Toy Story",
                      @"A Bug's Life", @"Toy Story 2", @"Monsters, Inc.", @"Finding Nemo", @"The Incredibles", @"Cars", @"Ratatouille", @"WALL-E", @"Up", @"Toy Story 3", @"Cars 2", @"Brave", nil];
    self.list = array;
    [array release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * DisclosureButtonCellIdentifier = @"DisclosureButtonCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: DisclosureButtonCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier: DisclosureButtonCellIdentifier];
    }
    NSUInteger row = [indexPath row];
    NSString *rowString = [self.list objectAtIndex:row];
    cell.textLabel.text = rowString;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey, do you see the disclosure button?"
                                                    message:@"If you're trying to drill down, touch that instead" delegate:nil
                                          cancelButtonTitle:@"Won't happen again" otherButtonTitles:nil];
    [alert show];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (nil == self.childController) {
        self.childController = [[DisclosureDetailController alloc] initWithNibName:@"DisclosureDetailController" bundle:nil];
    }
    self.childController.title = @"Disclosure Button Pressed";
    NSUInteger row = [indexPath row];
    NSString *selectedMovie = [self.list objectAtIndex:row];
    NSString *detailMessage = [[NSString alloc]
                               initWithFormat:@"You pressed the disclosure button for %@.",
                               selectedMovie];
    self.childController.message = detailMessage;
    self.childController.title = selectedMovie;
    [self.navigationController pushViewController:self.childController animated:YES];
}
                                                                                     

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  RowControlsController.m
//  Nav
//
//  Created by liuwei on 12-12-16.
//  Copyright (c) 2012年 liuwei. All rights reserved.
//

#import "RowControlsController.h"

@interface RowControlsController ()

@end

@implementation RowControlsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)buttonTapped:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    UITableViewCell *btnCell = (UITableViewCell *)[btn superview];
    NSUInteger buttonRow = [[self.tableView indexPathForCell:btnCell] row];
    NSString *buttonTitle = [self.list objectAtIndex:buttonRow];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You tapped." message:[NSString stringWithFormat:@"You tapped: %@", buttonTitle]
                                                   delegate:self
                                          cancelButtonTitle:@"ok"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSArray *array = [[NSArray alloc] initWithObjects:@"R2-D2", @"C3PO", @"Tik-Tok", @"Robby", @"Rosie", @"Uniblab", @"Bender", @"Marvin", @"Lt. Commander Data", @"Evil Brother Lore", @"Optimus Prime", @"Tobor", @"HAL", nil];
    self.list = array;
    [array release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"ControlRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
        UIImage *buttonUpImage = [UIImage imageNamed:@"button_up.png"];
        UIImage *buttonDownImage = [UIImage imageNamed:@"button_down.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0, 0.0, buttonUpImage.size.width,buttonUpImage.size.height);
        [button setBackgroundImage:buttonUpImage forState:UIControlStateNormal];
        [button setBackgroundImage:buttonDownImage forState:UIControlStateHighlighted];
        [button setTitle:@"Tap" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:)
         forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
    }
    
    NSUInteger row = [indexPath row];
    NSString *rowTitle = [self.list objectAtIndex:row];
    cell.textLabel.text = rowTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *rowTitle = [self.list objectAtIndex:row];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"You tapped the row." message:[NSString stringWithFormat:@"You tapped %@.", rowTitle] delegate:nil
                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

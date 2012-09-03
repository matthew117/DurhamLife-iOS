//
//  DUEventDetailsViewController.m
//  Duchess
//
//  Created by Matthew Bates on 27/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUEventDetailsViewController.h"
#import "DUAppDelegate.h"
#import "DUDataSingleton.h"
#import "DUEvent.h"
#import <QuartzCore/QuartzCore.h>
#import "CSLinearLayoutView.h"
#import "CSLinearLayoutItem.h"
#import "DURoundedBorderLabel.h"

@implementation DUEventDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Event Details";
    // Do any additional setup after loading the view from its nib.
    
    DUAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    DUEvent *event = delegate.currentEvent;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case  0: return 2;
        case  1: return 2;
        case  2: return 2;
        case  3: return 3;
        case  4: return 1;
            
        default: return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case  0: return @"";
        case  1: return @"When";
        case  2: return @"Description";
        case  3: return @"Contact Information";
        case  4: return @"Accessibility";
            
        default: return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        NSLog(@"Init cell: %d, %d", indexPath.section, indexPath.row);
    }
    
    DUAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    DUEvent *event = delegate.currentEvent;
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.textLabel.text = @"Location";
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = @"Reviews";
                    break;
                }
                    
                default: break;
            }
            break;
        }
            
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"d MMMM"];
                    
                    NSString *eventStartDateStr = [formatter stringFromDate:event.startDate];
                    NSString *eventEndDateStr = [formatter stringFromDate:event.endDate];
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ until %@", eventStartDateStr, eventEndDateStr];

                    break;
                }
                
                case 1:
                {
                    cell.textLabel.text = @"View Times";
                    break;
                }
                    
                default: break;
            }
            break;
        }
            
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    
                    
                    break;
                }
                    
                case 1:
                {
                    
                    break;
                }
                    
                default: break;
            }
            break;
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSLog(@"Detail label: %@", cell.detailTextLabel.text);
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    
                }
                break;
                    
                default: break;
            }
        }
        break;
            
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {

                }
                break;
                    
                default: break;
            }
        }
        break;
            
        default: break;
    }
}

@end


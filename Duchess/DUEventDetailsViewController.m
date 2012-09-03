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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    DUEvent *event = delegate.currentEvent;
    
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            if (event.descriptionHeader == nil || [event.descriptionHeader length] < 1) return 44;
            return ([event.descriptionHeader sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, 9000) lineBreakMode:UILineBreakModeWordWrap].height) + 10;
        }
        else
        {
            if (event.descriptionBody == nil || [event.descriptionBody length] < 1) return 44;
            return ([event.descriptionBody sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, 9000) lineBreakMode:UILineBreakModeWordWrap].height) + 10;
        }
    }
    else if (indexPath.section == 4)
    {
        if (event.accessibilityInformation == nil || [event.accessibilityInformation length] < 1) return 44;
        return ([event.accessibilityInformation sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, 9000) lineBreakMode:UILineBreakModeWordWrap].height) + 10;
    }
    else return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    DUAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    DUEvent *event = delegate.currentEvent;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.section)
    {
        //Location/Reviews
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
        //When
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

                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                    break;
                }
                
                case 1:
                {
                    [cell setUserInteractionEnabled:(event.iCalURL != nil)];
                    cell.textLabel.text = @"View Times";

                    break;
                }
                    
                default: break;
            }
            break;
        }
        //Description
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                    if (event.descriptionHeader != nil && [event.descriptionHeader length] > 0)
                    {
                        cell.textLabel.text = event.descriptionHeader;
                    }
                    else cell.textLabel.text = event.name;
                    [cell.textLabel sizeToFit];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone; 
                    
                    break;
                }
                    
                case 1:
                {
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                    if (event.descriptionBody != nil && [event.descriptionBody length] > 0)
                    {
                        cell.textLabel.text = event.descriptionBody;
                    }
                    else cell.textLabel.text = @"No Description Available.";
                    [cell.textLabel sizeToFit];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone; 
                    
                    break;
                }
                    
                default: break;
            }
            break;
        }
        //Contact Information
        case 3:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    [cell setUserInteractionEnabled:(event.contactTelephoneNumber != nil)];
                    cell.textLabel.text = event.contactTelephoneNumber != nil ? event.contactTelephoneNumber : @"No Telephone Number Available";
                    break;
                }
                case 1:
                {
                    [cell setUserInteractionEnabled:(event.contactEmailAddress != nil)];
                    cell.textLabel.text = event.contactEmailAddress != nil ? event.contactEmailAddress : @"No Email Address Available";
                    break;
                }
                case 2:
                {
                    [cell setUserInteractionEnabled:(event.linkedWebsiteURL != nil)];
                    cell.textLabel.text = event.linkedWebsiteURL != nil ? event.linkedWebsiteURL : @"No Website Available";
                    break;
                }
                    
                default: break;
            }
            break;
        }
        //Accessibility
        case 4:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                    if (event.accessibilityInformation != nil && [event.accessibilityInformation length] > 0)
                    {
                        cell.textLabel.text = event.accessibilityInformation;
                    }
                    else cell.textLabel.text = @"No Accessibility Information Available.";
                    [cell.textLabel sizeToFit];
                    
                    cell.accessoryType = UITableViewCellAccessoryNone; 
                
                    break;
                }
                
                default: break;
            }
            break;
        }
    }
    
    if (indexPath.section == 2 || indexPath.section == 4 || (indexPath.section == 1 && indexPath.row == 0))
        [cell setUserInteractionEnabled:NO];
    
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


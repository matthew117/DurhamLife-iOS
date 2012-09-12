//
//  DUEventDetailsViewController.m
//  Durham Life
//
//  Created by Matthew Bates on 27/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUEventDetailsViewController.h"
#import "DUAppDelegate.h"
#import "DUDataSingleton.h"
#import "DUEvent.h"
#import <QuartzCore/QuartzCore.h>
#import "DURoundedBorderLabel.h"
#import "DUMapViewController.h"
#import "DUReviewsViewController.h"
#import "UIImage+crop.h"
#import "DUImageTableViewCell.h"
#import "CalendarUtils.h"

@implementation DUEventDetailsViewController

@synthesize event;

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
    self.title = event.name;
    
    [self performSelectorInBackground:@selector(downloadAndDisplayImage) withObject:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    event = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case  0: return 1;
        case  1: return 2;
        case  2: return 2;
        case  3: return 2;
        case  4: return 3;
        case  5: return 1;
            
        default: return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case  0: return @"";
        case  1: return @"";
        case  2: return @"When";
        case  3: return @"Description";
        case  4: return @"Contact Information";
        case  5: return @"Accessibility";
            
        default: return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 170;
    }
    else if (indexPath.section == 3)
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
    else if (indexPath.section == 5)
    {
        if (event.accessibilityInformation == nil || [event.accessibilityInformation length] < 1) return 44;
        return ([event.accessibilityInformation sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, 9000) lineBreakMode:UILineBreakModeWordWrap].height) + 10;
    }
    else return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *ImageIdentifier = @"ImageCell";
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) cell = [tableView dequeueReusableCellWithIdentifier:ImageIdentifier];
    else cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        if (indexPath.section == 0) cell = [[DUImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageIdentifier];
        else cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
    cell.textLabel.textColor = [UIColor blackColor];
    [cell setUserInteractionEnabled:YES];
    
    switch (indexPath.section)
    {
        //Image
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setUserInteractionEnabled:NO];
            if (event.imageURL == nil) cell.textLabel.text = @"No Image Available.";
            else cell.textLabel.text = @"Loading Image...";
            if (eventImage != nil)
            {
                cell.imageView.image = [eventImage crop:cell.imageView.bounds];
                cell.textLabel.text = @"";
            }
            break;
        }
        //Location/Reviews
        case 1:
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
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.textLabel.text = [CalendarUtils getEventDateString:event];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                    break;
                }
                
                case 1:
                {
                    cell.textLabel.text = @"View Times";
                    [cell setUserInteractionEnabled:(event.iCalURL != nil)];
                    if (event.iCalURL == nil) cell.textLabel.textColor = [UIColor lightGrayColor];
                    break;
                }
                    
                default: break;
            }
            break;
        }
        //Description
        case 3:
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
        case 4:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    if (event.contactTelephoneNumber == nil) cell.textLabel.textColor = [UIColor lightGrayColor];
                    [cell setUserInteractionEnabled:(event.contactTelephoneNumber != nil)];
                    cell.textLabel.text = event.contactTelephoneNumber != nil ? event.contactTelephoneNumber : @"No Telephone Number Available";
                    break;
                }
                case 1:
                {
                    if (event.contactEmailAddress == nil) cell.textLabel.textColor = [UIColor lightGrayColor];
                    [cell setUserInteractionEnabled:(event.contactEmailAddress != nil)];
                    cell.textLabel.text = event.contactEmailAddress != nil ? event.contactEmailAddress : @"No Email Address Available";
                    break;
                }
                case 2:
                {
                    if (event.linkedWebsiteURL == nil) cell.textLabel.textColor = [UIColor lightGrayColor];
                    [cell setUserInteractionEnabled:(event.linkedWebsiteURL != nil)];
                    cell.textLabel.text = event.linkedWebsiteURL != nil ? event.linkedWebsiteURL : @"No Website Available";
                    break;
                }
                    
                default: break;
            }
            break;
        }
        //Accessibility
        case 5:
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
    
    if (indexPath.section == 3 || indexPath.section == 5 || (indexPath.section == 2 && indexPath.row == 0))
        [cell setUserInteractionEnabled:NO];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    DUMapViewController *mapViewController = [[DUMapViewController alloc] initWithNibName:@"DUMapViewController" bundle:nil];
                    mapViewController.event = self.event;
                    [self.navigationController pushViewController:mapViewController animated:YES];

                }
                break;
                    
                case 1:
                {
                    DUReviewsViewController *reviewViewController = [[DUReviewsViewController alloc] initWithNibName:@"DUReviewsViewController" bundle:nil];
                    reviewViewController.event = self.event;
                    [self.navigationController pushViewController:reviewViewController animated:YES];
                }
                break;
                    
                default: break;
            }
        }
        break;
            
        case 2:
        {
            switch (indexPath.row)
            {
                case 1:
                {

                }
                break;
                    
                default: break;
            }
        }
        break;
            
        case 4:
        {
            switch (indexPath.row)
            {

                case 0: [self phoneAction]; break;
                case 1: [self emailAction]; break;
                case 2: [self websiteAction]; break;
                    
                default: break;
            }
        }
        break;
            
        default: break;
    }
}

- (void)phoneAction
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"tel:07794330580"]];
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"tel:%@", event.contactTelephoneNumber]];
    [[UIApplication sharedApplication] openURL: url];
}

- (void)emailAction
{    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setToRecipients:[NSArray arrayWithObject:event.contactEmailAddress]];
        [mailer setMessageBody:@"" isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Unsupported Action."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}

- (void)websiteAction
{    
    NSURL *url = [NSURL URLWithString:event.linkedWebsiteURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)downloadAndDisplayImage
{
    NSURL* url = [NSURL URLWithString:event.imageURL];
    eventImage = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]] crop:CGRectMake(0, 0, 280, 170)];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:NO];
}

@end


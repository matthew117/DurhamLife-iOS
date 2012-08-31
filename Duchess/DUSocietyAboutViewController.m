//
//  DUSocietyAboutViewController.m
//  Duchess
//
//  Created by Matthew Bates on 31/08/2012.
//
//

#import "DUSocietyAboutViewController.h"
#import "DURoundedBorderLabel.h"

@implementation DUSocietyAboutViewController

@synthesize society;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"About";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    society = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case  0: return 1;
        case  1: return 2;
            
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.textLabel.text = society.constitution;
                }
                break;
                default: break;
            }
        }
        break;
            
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row)
            {
                case 0: cell.textLabel.text = society.email; break;
                case 1: cell.textLabel.text = society.website; break;
                default: break;
            }
        }
        break;
    }
    
    // Has to be set after the label text so that it doesn't get greyed out
    if (indexPath.section == 0) [cell setUserInteractionEnabled:NO];
    
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
                // Do nothing
                default: break;
            }
        }
            break;
            
        case 1:
        {
            switch (indexPath.row)
            {
                case 0: [self websiteAction]; break;
                case 1: [self emailAction]; break;
                default: break;
            }
        }
            break;
    }
}


- (void)emailAction
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setToRecipients:[NSArray arrayWithObject:society.email]];
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
    NSURL *url = [NSURL URLWithString:society.website];
    [[UIApplication sharedApplication] openURL:url];
}
@end

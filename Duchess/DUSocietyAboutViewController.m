//
//  DUSocietyAboutViewController.m
//  Duchess
//
//  Created by Matthew Bates on 31/08/2012.
//
//

#import "DUSocietyAboutViewController.h"

@implementation DUSocietyAboutViewController

@synthesize society;
@synthesize societyNameLabel;
@synthesize societyConstitutionScrollView;
@synthesize emailButton;
@synthesize websiteButton;

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
    
    self.title = @"About";
    societyNameLabel.text = society.name;
    [emailButton setTitle:society.email forState:UIControlStateNormal];
    [websiteButton setTitle:society.website forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    [self setSocietyNameLabel:nil];
    [self setSocietyConstitutionScrollView:nil];
    [self setEmailButton:nil];
    [self setWebsiteButton:nil];
    [super viewDidUnload];
    
    society = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)emailAction:(UIButton *)sender
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

- (IBAction)websiteAction:(UIButton *)sender
{
    NSURL *url = [NSURL URLWithString:society.website];
    [[UIApplication sharedApplication] openURL:url];
}
@end

//
//  DUReviewEditor.m
//  Durham Life
//
//  Created by Matthew Bates on 11/09/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import "DUReviewEditor.h"
#import "Reachability.h"

@implementation DUReviewEditor
@synthesize reviewTextField;
@synthesize reviewEditorRatingBar;
@synthesize event;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    
    NSString *reviewXML = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><review userID=\"%d\" eventID=\"%d\"><rating>%d</rating><post>%@</post><timestamp>%.0f</timestamp></review>",
     -1,
     event.eventID,
     reviewEditorRatingBar.rating,
     textField.text,
     [[NSDate date] timeIntervalSince1970]];
    
    textField.text = @"";
    reviewEditorRatingBar.rating = 0;
    [reviewEditorRatingBar setNeedsDisplay];
    
    NSLog(@"%@", reviewXML);
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.dur.ac.uk"];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (status == NotReachable)
    {
        [[[UIAlertView alloc] initWithTitle:@"Network Problem" message:@"Could not connect to the Internet. Review was not submitted." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                 (unsigned long)NULL), ^(void)
        {
            NSMutableURLRequest *urlRequest =
            [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.dur.ac.uk/cs.seg01/duchess/api/v1/reviews.php/%d", event.eventID]]];
            [urlRequest setHTTPMethod:@"PUT"];
            [urlRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
            
            [urlRequest setHTTPBody:[reviewXML dataUsingEncoding:NSUTF8StringEncoding]];
            [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
             [[[UIAlertView alloc] initWithTitle:@"Review Submitted" message:@"Thank you for submitting a review. Note that reviews are moderated and may take a while to appear." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            });
        });
    }
    return YES;
}

@end

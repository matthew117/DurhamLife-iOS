//
//  DUReviewEditor.m
//  durhamlife
//
//  Created by Matthew Bates on 11/09/2012.
//
//

#import "DUReviewEditor.h"

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
    
    NSLog(@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><review userID=\"%d\" eventID=\"%d\"><rating>%d</rating><post>%@</post><timestamp>%f</timestamp></review>",
          -1, event.eventID, reviewEditorRatingBar.rating , textField.text,
          [[NSDate date] timeIntervalSince1970]);
    
    return YES;
}

@end

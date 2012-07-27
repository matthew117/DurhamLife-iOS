//
//  DUEventDetailsViewController.m
//  Duchess
//
//  Created by Matthew Bates on 27/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUEventDetailsViewController.h"
#import "DuchessAppDelegate.h"
#import "DUDataSingleton.h"
#import "DUEvent.h"

@implementation DUEventDetailsViewController
@synthesize eventNameLabel;
@synthesize eventDescriptionLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [eventNameLabel release];
    [eventDescriptionLabel release];
    [super dealloc];
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
    
    DuchessAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    DUDataSingleton *dataProvider = [DUDataSingleton instance];
    NSMutableArray *eventList = dataProvider.eventList;
    DUEvent *event = [eventList objectAtIndex:delegate.currentEvent];
    
    eventNameLabel.text = event.name;
    eventDescriptionLabel.text = event.descriptionHeader;
}

- (void)viewDidUnload
{
    [self setEventNameLabel:nil];
    [self setEventDescriptionLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

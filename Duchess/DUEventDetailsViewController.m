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
#import <QuartzCore/QuartzCore.h>
#import "CSLinearLayoutView.h"
#import "CSLinearLayoutItem.h"

@implementation DUEventDetailsViewController

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
    
    // create the linear layout view
    CSLinearLayoutView *linearLayoutView = [[[CSLinearLayoutView alloc] initWithFrame:self.view.bounds] autorelease];
    linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    [self.view addSubview:linearLayoutView];
    
    UILabel *eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, 20)];
    eventNameLabel.textAlignment = UITextAlignmentCenter;
    eventNameLabel.text = event.name;
    [eventNameLabel setBackgroundColor:[UIColor clearColor]];
    [eventNameLabel setTextColor:[UIColor whiteColor]];
    eventNameLabel.font = [UIFont boldSystemFontOfSize:18];
    
    UILabel *eventDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    eventDescriptionLabel.numberOfLines = 0;
    eventDescriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    [eventDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    [eventDescriptionLabel setTextColor:[UIColor blackColor]];
    eventDescriptionLabel.font = [UIFont systemFontOfSize:15];
    eventDescriptionLabel.adjustsFontSizeToFitWidth = NO;
    eventDescriptionLabel.text = event.descriptionHeader;
    [eventDescriptionLabel sizeToFit];
    
    
    
    CGRect frame = eventDescriptionLabel.bounds;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 305, frame.size.height + 10)];
    
    NSLog(@"Frame: {x: %f, y: %f, width: %f, height: %f}", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 10;
    [whiteView addSubview:eventDescriptionLabel];
    eventDescriptionLabel.center = whiteView.center;
    
    // create a layout item for the view you want to display
    CSLinearLayoutItem *nameItem = [CSLinearLayoutItem layoutItemForView:eventNameLabel];
    nameItem.padding = CSLinearLayoutMakePadding(5.0, 5.0, 5.0, 5.0);
    nameItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    nameItem.fillMode = CSLinearLayoutItemFillModeNormal;
    
    CSLinearLayoutItem *descriptionLabel = [CSLinearLayoutItem layoutItemForView:whiteView];
    descriptionLabel.padding = CSLinearLayoutMakePadding(0, 5.0, 0, 5.0);
    descriptionLabel.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    descriptionLabel.fillMode = CSLinearLayoutItemFillModeNormal;

    
    // add the layout item to the linear layout view
    [linearLayoutView addItem:nameItem];
    [linearLayoutView addItem:descriptionLabel];
    NSLog(@"Frame: {x: %f, y: %f, width: %f, height: %f}", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
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

@end

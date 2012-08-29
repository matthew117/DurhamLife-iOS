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
    
    // create the linear layout view
    CSLinearLayoutView *linearLayoutView = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    linearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    [self.view addSubview:linearLayoutView];
    
    UILabel *eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, 20)];
    eventNameLabel.textAlignment = UITextAlignmentCenter;
    eventNameLabel.text = event.name;
    [eventNameLabel setBackgroundColor:[UIColor clearColor]];
    [eventNameLabel setTextColor:[UIColor whiteColor]];
    eventNameLabel.font = [UIFont boldSystemFontOfSize:18];
    
    DURoundedBorderLabel *eventDescriptionLabel = [[DURoundedBorderLabel alloc] init];
    [eventDescriptionLabel setBackgroundColor:[UIColor whiteColor]];
    [eventDescriptionLabel setTextColor:[UIColor blackColor]];
    eventDescriptionLabel.text = event.descriptionHeader;
    eventDescriptionLabel.font = [UIFont systemFontOfSize:15];
    [eventDescriptionLabel sizeToFitFixedWidth:300.0];
    
    // create a layout item for the view you want to display
    CSLinearLayoutItem *nameItem = [CSLinearLayoutItem layoutItemForView:eventNameLabel];
    nameItem.padding = CSLinearLayoutMakePadding(5.0, 5.0, 5.0, 5.0);
    nameItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    nameItem.fillMode = CSLinearLayoutItemFillModeNormal;
    
    CSLinearLayoutItem *descriptionLabel = [CSLinearLayoutItem layoutItemForView:eventDescriptionLabel];
    descriptionLabel.padding = CSLinearLayoutMakePadding(5.0, 7.0, 5.0, 7.0);
    descriptionLabel.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    descriptionLabel.fillMode = CSLinearLayoutItemFillModeStretch;

    
    // add the layout item to the linear layout view
    [linearLayoutView addItem:nameItem];
    [linearLayoutView addItem:descriptionLabel];
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

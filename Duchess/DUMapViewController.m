//
//  DUMapViewController.m
//  Duchess
//
//  Created by Matthew Bates on 03/09/2012.
//
//

#import "DUMapViewController.h"

@implementation DUMapViewController
@synthesize mapView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Event Location";
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    event = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

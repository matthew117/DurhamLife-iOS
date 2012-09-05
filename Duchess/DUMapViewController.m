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
@synthesize addressLabel;

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
    self.addressLabel.text = [NSString stringWithFormat:@"%@, %@\n%@, %@",
                              event.location.address1,
                              event.location.address2,
                              event.location.city,
                              event.location.postcode];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([event.location.latitude floatValue], [event.location.longitude floatValue]);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 1000, 1000);
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    annotation.title = event.name;
    annotation.subtitle = [NSString stringWithFormat:@"%@, %@, %@, %@",
                           event.location.address1,
                           event.location.address2,
                           event.location.city,
                           event.location.postcode];
    [self.mapView addAnnotation:annotation];
    self.mapView.region = region; self.mapView.hidden = NO;
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setAddressLabel:nil];
    [super viewDidUnload];
    event = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

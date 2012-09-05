//
//  DUMapViewController.h
//  Duchess
//
//  Created by Matthew Bates on 03/09/2012.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DUEvent.h"
#import "DURoundedBorderLabel.h"

@interface DUMapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) DUEvent* event;
@property (strong, nonatomic) IBOutlet DURoundedBorderLabel *addressLabel;

@end

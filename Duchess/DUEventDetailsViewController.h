//
//  DUEventDetailsViewController.h
//  Duchess
//
//  Created by Matthew Bates on 27/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DUEventDetailsViewController : UIViewController {
    
    UILabel *eventNameLabel;
    UILabel *eventDescriptionLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *eventNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *eventDescriptionLabel;

@end

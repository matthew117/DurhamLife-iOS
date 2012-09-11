//
//  DUReviewEditor.h
//  durhamlife
//
//  Created by Matthew Bates on 11/09/2012.
//
//

#import <UIKit/UIKit.h>
#import "DURatingBar.h"

@interface DUReviewEditor : UIView

@property (strong, nonatomic) IBOutlet UITextField *reviewTextField;
@property (strong, nonatomic) IBOutlet DURatingBar *reviewEditorRatingBar;

@end

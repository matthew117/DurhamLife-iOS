//
//  DUReviewEditor.h
//  Durham Life
//
//  Created by Matthew Bates on 11/09/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "DURatingBar.h"
#import "DUEvent.h"

@interface DUReviewEditor : UIView <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *reviewTextField;
@property (strong, nonatomic) IBOutlet DURatingBar *reviewEditorRatingBar;
@property (strong, nonatomic) DUEvent *event;

@end

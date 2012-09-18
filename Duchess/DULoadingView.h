//
//  DULoadingView.h
//  Durham Life
//
//  Created by Matthew Bates on 17/09/2012.
//  Implementation inspired by Mal Curtis http://buildmobile.com/all-purpose-loading-view-for-ios/
//

#import <UIKit/UIKit.h>

@interface DULoadingView : UIView

+(DULoadingView *)loadSpinnerIntoView:(UIView *)superView;
-(void)removeSpinner;

@end

//
//  DUSocietyEventListViewController.h
//  Duchess
//
//  Created by Matthew Bates on 31/08/2012.
//
//

#import "DUEventListViewController.h"
#import "DUSociety.h"

@interface DUSocietyEventListViewController : DUEventListViewController

@property (nonatomic,strong) DUSociety* society;
- (IBAction)subcribeAction:(UIButton *)sender;
- (IBAction)aboutAction:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *subscribeButton;

@end

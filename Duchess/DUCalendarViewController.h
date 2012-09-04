//
//  DUCalendarViewController.h
//  Duchess
//
//  Created by Jamie Bates on 03/09/2012.
//
//

#import "DUEventListViewController.h"

@interface DUCalendarViewController : DUEventListViewController

- (void)setupCalendarView;
- (IBAction)filterByDate:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *calendarCell;

@end

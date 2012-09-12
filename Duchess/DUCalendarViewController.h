//
//  DUCalendarViewController.h
//  Durham Life
//
//  Created by Jamie Bates on 03/09/2012.
//
//

#import "DUEventListViewController.h"

@interface DUCalendarViewController : DUEventListViewController

- (void)setupCalendarView;
- (void)setMonthBounds;
- (void)setupCalendarCells;

- (IBAction)filterByDate:(UIButton *)sender;
- (IBAction)previousMonthAction:(UIButton *)sender;
- (IBAction)nextMonthAction:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

@end

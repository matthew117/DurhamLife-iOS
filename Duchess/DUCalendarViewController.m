//
//  DUCalendarViewController.m
//  Duchess
//
//  Created by Jamie Bates on 03/09/2012.
//
//

#import "DUCalendarViewController.h"

@interface DUCalendarViewController ()

@end

@implementation DUCalendarViewController

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
    
    self.title = @"Event Calendar";
    
    [self setupCalendarView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupCalendarView
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *today = [NSDate date];
    
    UILabel *header = (UILabel*)[self.view viewWithTag:43];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM yyyy"];
    header.text = [formatter stringFromDate:today];
    
    NSDateComponents *dateComps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    NSRange daysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit
                                         inUnit:NSMonthCalendarUnit
                                        forDate:today];
    
    NSInteger upperBound = daysInMonth.length;
    
    [dateComps setCalendar:calendar];
    [dateComps setDay:1];
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    NSDate *firstDayOfMonth = [dateComps date];
    
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    NSInteger lowerBound = [weekdayComponents weekday];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1];
    NSDate *firstDayOfLastMonth = [calendar dateByAddingComponents:comps toDate:firstDayOfMonth options:0];
    NSRange daysInLastMonth = [calendar rangeOfUnit:NSDayCalendarUnit
                                             inUnit:NSMonthCalendarUnit
                                            forDate:firstDayOfLastMonth];
    
    NSInteger lastBound = daysInLastMonth.length;
    
    NSLog(@"Days in month: %d", upperBound);
    NSLog(@"First day of month: %d", lowerBound);
    NSLog(@"Days in last month: %d", lastBound);
    
    int cellID = -((lowerBound + 5) % 7);
    
    NSLog(@"Cell ID: %d", cellID);
    
    for (int i = 1; i <= 42; i++)
    {
        UIButton *cell = (UIButton*)[self.view viewWithTag:i];
        
        int cellDate = cellID + 1;
        
        if (cellDate < 1)
        {
            cellDate += lastBound;
            [cell setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        else if(cellDate > upperBound)
        {
            cellDate %= upperBound;
            [cell setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        
        [cell setTitle: [NSString stringWithFormat:@"%d", cellDate] forState:UIControlStateNormal];
        [cell addTarget:self action:@selector(filterByDate:) forControlEvents:UIControlEventTouchUpInside];
        
        cellID++;
    }
}

- (IBAction)filterByDate:(UIButton *)sender
{
    NSLog(@"Pressed calendar cell: %d", sender.tag);
}

@end

//
//  DUCalendarViewController.m
//  Durham Life
//
//  Created by Jamie Bates on 03/09/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import "DUCalendarViewController.h"
#import "DUDataSingleton.h"
#import "SessionHandler.h"
#import "CalendarUtils.h"

@interface DUCalendarViewController ()

@end

@implementation DUCalendarViewController

NSInteger upperBound;
NSInteger lowerBound;
NSInteger lastBound;
NSMutableArray *calendarCells;
NSDate *firstDayOfMonth;
UIButton *selected;
BOOL calendarLoaded = NO;

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
    
    calendarCells = [NSMutableArray new];
    
    for (int i = 1; i <= 42; i++)
    {
        UIButton *cell = (UIButton*)[self.view viewWithTag:i];
        [calendarCells addObject:cell];
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *today = [NSDate date];
    
    NSDateComponents *dateComps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    
    [dateComps setCalendar:calendar];
    [dateComps setDay:1];
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    firstDayOfMonth = [dateComps date];
}

- (void)viewWillAppear:(BOOL)animated
{
    calendarLoaded = NO;
    [self setupCalendarView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)enableFilters
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupCalendarView
{
    [self setMonthBounds];
    [self setupCalendarCells];
}

- (void)setMonthBounds
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    UILabel *header = (UILabel*)[self.view viewWithTag:43];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM yyyy"];
    header.text = [formatter stringFromDate:firstDayOfMonth];
    
    NSRange daysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:firstDayOfMonth];
    
    upperBound = daysInMonth.length;
    
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    lowerBound = [weekdayComponents weekday];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1];
    NSDate *firstDayOfPrevMonth = [calendar dateByAddingComponents:comps toDate:firstDayOfMonth options:0];
    NSRange daysInPrevMonth = [calendar rangeOfUnit:NSDayCalendarUnit
                                        inUnit:NSMonthCalendarUnit
                                        forDate:firstDayOfPrevMonth];
    
    lastBound = daysInPrevMonth.length;
}

- (void)setupCalendarCells
{
    if(calendarLoaded)
    {
        backingArray = [NSArray new];
        [self dataHasLoaded];
    }
    
    [selected setBackgroundImage:[UIImage imageNamed:@"calendar_cell_normal.png"] forState:UIControlStateNormal];    
    selected = nil;
    
    int cellID = -((lowerBound + 5) % 7);
    
    for (int i = 1; i <= 42; i++)
    {
        UIButton *cell = [calendarCells objectAtIndex:(i - 1)];
        
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
        else
        {
            if ([CalendarUtils isDateToday:[DUCalendarViewController dateFromCellTag:cell.tag]])
            {
                [cell setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [cell setBackgroundImage:[UIImage imageNamed:@"calendar_cell_today_selected.png"] forState:UIControlStateHighlighted];
            
                if (!calendarLoaded)
                {
                    [cell setBackgroundImage:[UIImage imageNamed:@"calendar_cell_today_selected.png"] forState:UIControlStateNormal];
                    selected = cell;
                    calendarLoaded = YES;
                }
                else [cell setBackgroundImage:[UIImage imageNamed:@"calendar_cell_today_normal.png"] forState:UIControlStateNormal];

            }
            else
            {
                [cell setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [cell setBackgroundImage:[UIImage imageNamed:@"calendar_cell_normal.png"] forState:UIControlStateNormal];
                [cell setBackgroundImage:[UIImage imageNamed:@"calendar_cell_selected.png"] forState:UIControlStateHighlighted];

            }
        }
        
        [cell setTitle: [NSString stringWithFormat:@"%d", cellDate] forState:UIControlStateNormal];
        [cell addTarget:self action:@selector(filterByDate:) forControlEvents:UIControlEventTouchUpInside];
        
        cellID++;
    }
}

- (IBAction)filterByDate:(UIButton *)sender
{
    if (selected != nil)
    {
        if ([CalendarUtils isDateToday:[DUCalendarViewController dateFromCellTag:selected.tag]])
        {
            [selected setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [selected setBackgroundImage:[UIImage imageNamed:@"calendar_cell_today_normal.png"] forState:UIControlStateNormal];
        }
        else
        {
            [selected setBackgroundImage:[UIImage imageNamed:@"calendar_cell_normal.png"] forState:UIControlStateNormal];
            [selected setTitleColor:[DUCalendarViewController colorFromCellTag:selected.tag] forState:UIControlStateNormal];
        }
    }
    selected = sender;
    
    if ([CalendarUtils isDateToday:[DUCalendarViewController dateFromCellTag:selected.tag]])
         [selected setBackgroundImage:[UIImage imageNamed:@"calendar_cell_today_selected.png"] forState:UIControlStateNormal];
    else [selected setBackgroundImage:[UIImage imageNamed:@"calendar_cell_selected.png"] forState:UIControlStateNormal];

    
    [selected setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSDate *date = [DUCalendarViewController dateFromCellTag:sender.tag];
    
    @autoreleasepool
    {
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        backingArray = [dataProvider getEventsByDate:date];
        [self dataHasLoaded];
    }
}

- (void)loadDataSet
{
    @autoreleasepool
    {        
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        backingArray = [dataProvider getEventsByDate:[CalendarUtils getTodayAsDateOnly]];
                
        [self dataHasLoaded];
    }
}



+ (UIColor*)colorFromCellTag:(NSInteger)tag
{
    int cellID = -((lowerBound + 5) % 7);
    cellID += tag;
    
    if (cellID < 1)
    {
        return [UIColor lightGrayColor];
    }
    else if(cellID > upperBound)
    {
        return [UIColor lightGrayColor];
    }
    else
    {
        return [UIColor blackColor];
    }
}

+ (NSDate*)dateFromCellTag:(NSInteger)tag
{
    int cellID = -((lowerBound + 5) % 7);
    cellID += (tag - 1);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:cellID];
    return [calendar dateByAddingComponents:comps toDate:firstDayOfMonth options:0];
}

- (IBAction)previousMonthAction:(UIButton *)sender
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1];
    firstDayOfMonth = [calendar dateByAddingComponents:comps toDate:firstDayOfMonth options:0];
    
    [self setupCalendarView];
}

- (IBAction)nextMonthAction:(UIButton *)sender
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:+1];
    firstDayOfMonth = [calendar dateByAddingComponents:comps toDate:firstDayOfMonth options:0];
    
    [self setupCalendarView];
}


@end

//
//  DUCollegeEventsViewController.m
//  Durham Life
//
//  Created by Matthew Bates on 26/08/2012.
//
//

#import "DUCollegeEventsViewController.h"
#import "DUDataSingleton.h"
#import "DUUser.h"
#import "SessionHandler.h"
#import "DUAppDelegate.h"
#import "DUEvent.h"
#import "DUEventDetailsViewController.h"
#import "DUNetworkedDataProvider.h"
#import "Reachability.h"

@implementation DUCollegeEventsViewController

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
    self.title = @"College Events";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)enableFilters
{
    DUUser* user = [SessionHandler getUser];
    
    if ([user isStaff])
        self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(chooseFilter:)];

}

- (void)chooseFilter:(UIButton *)sender
{
    DUUser* user = [SessionHandler getUser];
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose College"
        delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
        otherButtonTitles: nil];
    
    for (NSString *college in user.colleges)
    {
        [actionSheet addButtonWithTitle:college];
    }
    
    [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.cancelButtonIndex = user.colleges.count;
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)sheet clickedButtonAtIndex:(NSInteger)index
{
    if (index == sheet.cancelButtonIndex) return;
    NSString* college = [sheet buttonTitleAtIndex:index];
    
    @autoreleasepool
    {        
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        backingArray = [dataProvider getEventsByCollege:college];
        [self dataHasLoaded];
    }
}

#pragma mark - Customize Data Set

- (NSArray*)getDataSet
{
    return backingArray;
}

#pragma mark - Background Thread

- (void)loadDataSet
{
    @autoreleasepool
    {
        DUUser* user = [SessionHandler getUser];
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        
        if ([user isStaff])
             backingArray = [dataProvider getEventsByColleges:user.colleges];
        else backingArray = [dataProvider getEventsByCollege:[user getPrimaryCollege]];
        [self dataHasLoaded];
    }
}

@end
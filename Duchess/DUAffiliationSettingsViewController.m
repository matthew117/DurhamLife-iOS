//
//  DUAffiliationSettingsViewController.m
//  Duchess
//
//  Created by Jamie Bates on 29/08/2012.
//
//

#import "DUAffiliationSettingsViewController.h"
#import "SessionHandler.h"

@interface DUAffiliationSettingsViewController ()

@end

@implementation DUAffiliationSettingsViewController

static NSArray *affiliation;

+ (void)initialize
{
    affiliation = [NSArray arrayWithObjects: @"Guest", @"Student", @"Staff", nil];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select an affiliation";
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [affiliation count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [affiliation objectAtIndex:indexPath.row];
    
    DUUser *user = [SessionHandler getUser];
    
    if ([DUUser affiliationToInteger:(user.userAffiliation)] == (indexPath.row + 1))
    {
        lastIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

NSIndexPath* lastIndexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUUser *user = [SessionHandler getUser];
    
    user.userAffiliation = [DUUser integerToAffiliation:(indexPath.row + 1)];
    
    [SessionHandler saveUser:user];
    
    UITableViewCell* newCell = [tableView cellForRowAtIndexPath:indexPath];
    int newRow = [indexPath row];
    int oldRow = (lastIndexPath != nil) ? [lastIndexPath row] : -1;
    
    if(newRow != oldRow)
    {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell* oldCell = [tableView cellForRowAtIndexPath:lastIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        lastIndexPath = indexPath;
    }
    
    [tableView deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:YES];
}

@end

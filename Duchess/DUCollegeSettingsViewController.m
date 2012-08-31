//
//  DUCollegeSettingsViewController.m
//  Duchess
//
//  Created by Jamie Bates on 29/08/2012.
//
//

#import "DUCollegeSettingsViewController.h"
#import "SessionHandler.h"

@interface DUCollegeSettingsViewController ()

@end

@implementation DUCollegeSettingsViewController


static NSArray *colleges;

+ (void)initialize
{
    colleges = [NSArray arrayWithObjects:
                @"Collingwood", @"Grey", @"Hatfield", @"Hild Bede",
                @"John Snow", @"Josephine Butler", @"St. Aidan's", @"St. Chad's",
                @"St. Cuthbert's", @"St. John's", @"St. Mary's", @"Stephenson",
                @"Trevelyan", @"University", @"Ustinov", @"Van Mildert", nil];
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

    self.title = @"Select a college";
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
    return [colleges count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [colleges objectAtIndex:indexPath.row];
    
    DUUser *user = [SessionHandler getUser];
    
    if ([[user getPrimaryCollege] isEqualToString:[colleges objectAtIndex:indexPath.row]])
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
    
    [user setPrimaryCollege:[colleges objectAtIndex:indexPath.row]];
    
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

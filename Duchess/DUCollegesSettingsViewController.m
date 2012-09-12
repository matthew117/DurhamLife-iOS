//
//  DUCollegesSettingsViewController.m
//  Durham Life
//
//  Created by Jamie Bates on 30/08/2012.
//
//

#import "SessionHandler.h"
#import "DUCollegesSettingsViewController.h"

@interface DUCollegesSettingsViewController ()

@end

@implementation DUCollegesSettingsViewController

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
    
    self.title = @"Colleges";
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DUUser *user = [SessionHandler getUser];
    
    UISwitch *collegeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(1.0, 1.0, 20.0, 20.0)];
    collegeSwitch.on = [user isSubscribedToCollege:[colleges objectAtIndex:indexPath.row]];
    [collegeSwitch addTarget:self action:@selector(toggleCategory:event:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.accessoryView = collegeSwitch;
    
    return cell;
}

- (void)toggleCategory:(UISwitch *)sender event:(id)event
{
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath != nil)
    {
        DUUser *user = [SessionHandler getUser];
        
        if ([(UISwitch *)sender isOn]) [user subcribeToCollege:[colleges objectAtIndex:indexPath.row]];
        else [user unsubcribeFromCollege:[colleges objectAtIndex:indexPath.row]];
        
        NSLog(@"%@", [colleges objectAtIndex:indexPath.row]);
        
        [SessionHandler saveUser:user];
    }
}

#pragma mark - Table view delegate

NSIndexPath* lastIndexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

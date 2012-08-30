//
//  DUCategorySettingsViewController.m
//  Duchess
//
//  Created by Jamie Bates on 30/08/2012.
//
//

#import "DUCategorySettingsViewController.h"
#import "SessionHandler.h"

@interface DUCategorySettingsViewController ()

@end

@implementation DUCategorySettingsViewController

static NSArray *categories;

+ (void)initialize
{
    categories = [NSArray arrayWithObjects:
                @"University", @"College", @"Music", @"Theatre",
                @"Exhibitions", @"Sport", @"Conferences", @"Community", nil];
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
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DUUser *user = [SessionHandler getUser];

    UISwitch *categorySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(1.0, 1.0, 20.0, 20.0)];
    categorySwitch.on = [user isSubscribedToCategory:[categories objectAtIndex:indexPath.row]];
    [categorySwitch addTarget:self action:@selector(toggleCategory:) forControlEvents:UIControlEventValueChanged];
    
    cell.accessoryView = categorySwitch;
    
    return cell;
}

- (void)toggleCategory:(id)sender
{
    [(UISwitch *)sender isOn];
}

#pragma mark - Table view delegate

NSIndexPath* lastIndexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUUser *user = [SessionHandler getUser];
    
    [SessionHandler saveUser:user];
}

@end

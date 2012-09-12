//
//  DUSettingsViewController.m
//  Duchess
//
//  Created by Jamie Bates on 28/08/2012.
//
//

#import "DUSettingsViewController.h"
#import "DUCollegeSettingsViewController.h"
#import "DUCollegesSettingsViewController.h"
#import "DUAffiliationSettingsViewController.h"
#import "DUCategorySettingsViewController.h"
#import "SessionHandler.h"

@interface DUSettingsViewController ()

@end

@implementation DUSettingsViewController

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
    
    self.title = @"Settings";
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:
        [NSIndexPath indexPathForRow:1 inSection:0],
        [NSIndexPath indexPathForRow:0 inSection:0], nil]
       withRowAnimation:UITableViewRowAnimationFade];
    }

- (void)deleteDurhamAffiliateRows
{
    NSArray *deleteIndexPaths = [NSArray arrayWithObjects:
                                 [NSIndexPath indexPathForRow:1 inSection:0], nil];
    
    UITableView *tableView = (UITableView *)self.view;
    
    [tableView beginUpdates];

    [tableView deleteRowsAtIndexPaths:deleteIndexPaths
              withRowAnimation:UITableViewRowAnimationFade];
    
    [tableView endUpdates];
}

- (void)insertDurhamAffiliateRows
{
    NSArray *deleteIndexPaths = [NSArray arrayWithObjects:
                                 [NSIndexPath indexPathForRow:1 inSection:0], nil];
    
    UITableView *tableView = (UITableView *)self.view;
    
    [tableView beginUpdates];
    
    [tableView deleteRowsAtIndexPaths:deleteIndexPaths
                     withRowAnimation:UITableViewRowAnimationFade];
    
    [tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case  0: return 2;
        case  1: return 1;
            
        default: return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case  0: return @"Profile";
        case  1: return @"Preferences";
            
        default: return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    DUUser *user = [SessionHandler getUser];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
    cell.textLabel.textColor = [UIColor blackColor];
    [cell setUserInteractionEnabled:YES];
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.textLabel.text = @"Affiliation";
                    cell.detailTextLabel.text = [DUUser affiliationToString:user.userAffiliation];
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = @"College";
                    if ([user isStudent] || [user isAlumni]) cell.detailTextLabel.text = [user getPrimaryCollege];
                    else cell.detailTextLabel.text = @"";
                    
                    if ([user isGuest])
                    {
                        [cell setUserInteractionEnabled:NO];
                        cell.textLabel.textColor = [UIColor lightGrayColor];
                    }

                    break;
                }
                    
                default: break;
            }
            break;
        }
            
        case 1:
        {
            switch (indexPath.row)
            {
                case 0: cell.textLabel.text = @"Categories"; break;
                    
                default: break;
            }
            break;
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSLog(@"Detail label: %@", cell.detailTextLabel.text);
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    DUAffiliationSettingsViewController *affiliationViewController = [[DUAffiliationSettingsViewController alloc] initWithNibName:@"DUAffiliationSettingsViewController" bundle:nil];
                    [self.navigationController pushViewController:affiliationViewController animated:YES];
                }
                break;
                    
                case 1:
                {
                    DUUser *user = [SessionHandler getUser];
                    
                    if ([user isStaff])
                    {
                        DUCollegesSettingsViewController *collegesViewController = [[DUCollegesSettingsViewController alloc] initWithNibName:@"DUCollegesSettingsViewController" bundle:nil];
                        [self.navigationController pushViewController:collegesViewController animated:YES];
                    }
                    else
                    {
                        DUCollegeSettingsViewController *collegeViewController = [[DUCollegeSettingsViewController alloc] initWithNibName:@"DUCollegeSettingsViewController" bundle:nil];
                        [self.navigationController pushViewController:collegeViewController animated:YES];
                    }
                }
                break;
                    
                default: break;
            }
            break;
        }
            
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    DUCategorySettingsViewController *categoryViewController = [[DUCategorySettingsViewController alloc] initWithNibName:@"DUCategorySettingsViewController" bundle:nil];
                    [self.navigationController pushViewController:categoryViewController animated:YES];
                }
                break;
                    
                default: break;
            }
            break;
        }
    }
}

@end

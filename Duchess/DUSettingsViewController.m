//
//  DUSettingsViewController.m
//  Duchess
//
//  Created by Jamie Bates on 28/08/2012.
//
//

#import "DUSettingsViewController.h"
#import "DUCollegeSettingsViewController.h"
#import "DUAffiliationSettingsViewController.h"

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0: cell.textLabel.text = @"Affiliation"; break;
                case 1: cell.textLabel.text = @"College"; break;
                    
                default: break;
            }
        }
            break;
            
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
                    DUCollegeSettingsViewController *collegeViewController = [[DUCollegeSettingsViewController alloc] initWithNibName:@"DUCollegeSettingsViewController" bundle:nil];
                    [self.navigationController pushViewController:collegeViewController animated:YES];
                }
                break;
                    
                default: break;
            }
        }
            break;
            
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    
                }
                break;
                    
                default: break;
            }
            break;
        }
    }

}

@end

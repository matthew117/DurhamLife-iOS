//
//  DUSocietyListViewController.m
//  Duchess
//
//  Created by Matthew Bates on 28/08/2012.
//
//

#import "DUSocietyListViewController.h"
#import "DUDataSingleton.h"
#import "DUSociety.h"

@interface DUSocietyListViewController ()

@end

@implementation DUSocietyListViewController

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

    self.title = @"Societies";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [[self getCustomList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    DUSociety* society = [[self getCustomList] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = society.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUSociety* society = [[self getCustomList] objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:society.name message:society.constitution
                          delegate:nil cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray*)getCustomList
{
    DUDataSingleton* data = [DUDataSingleton instance];
    return [data getSocieties];
}

/* A-Z Index Methods
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray* alpha = [NSArray arrayWithObjects:@"A", @"B", nil];
    if ([alpha objectAtIndex:section])
    {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}
 */

@end

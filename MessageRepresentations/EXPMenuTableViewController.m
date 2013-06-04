//
//  EXPMenuTableViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 30/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPMenuTableViewController.h"
#import "EXPLayerMethodTableViewController.h"
#import "EXPSpecialViewController.h"
#import "EXPAppDataSource.h"
#import "EXPLazyDrawnCachedTableViewController.h"


@interface EXPMenuTableViewController ()
@property (nonatomic, strong) NSMutableArray *tempArray;
@end

@implementation EXPMenuTableViewController

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MessageFile" ofType:@"plist"];
        _tempArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        
        // Custom initialization
    }
    return self;
    
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MessageFile" ofType:@"plist"];
        _tempArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"LayerMethodsegue"])
    {
        
        EXPLayerMethodTableViewController *tvc = (EXPLayerMethodTableViewController *)[segue destinationViewController];
        tvc.tempArray = self.tempArray;
        [tvc parseData];
    }
    if([[segue identifier] isEqualToString:@"ImageSegue"])
    {
        
        EXPSpecialViewController *tvc = (EXPSpecialViewController *)[segue destinationViewController];
        tvc.messages = [[EXPAppDataSource alloc] init];
    }
    if([[segue identifier] isEqualToString:@"LazyDrawnSegue"])
    {
        
        EXPLazyDrawnCachedTableViewController *tvc = (EXPLazyDrawnCachedTableViewController *)[segue destinationViewController];
        tvc.tempArray = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MessageFile" ofType:@"plist"]];
        [tvc parseData];
    }
    if([[segue identifier] isEqualToString:@"cutomEmoticonsSegue"])
    {
        
        EXPLayerMethodTableViewController *tvc = (EXPLayerMethodTableViewController *)[segue destinationViewController];
        
        tvc.tempArray = self.tempArray;
        [tvc parseData];
    }

    
}
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

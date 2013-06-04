//
//  EFTableViewController.m
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EFTableViewController.h"
#import "EFTableViewCell.h"
#import "EFCellData.h"
#import "Constants.h"
#import "PerformanceMeasurer.h"

@interface EFTableViewController ()
@property (nonatomic,strong) PerformanceMeasurer* pm;
@end

@implementation EFTableViewController
-(void) updateNavBar:(int)toDisplay
{
    self.navigationItem.title = [NSString stringWithFormat:@"%d",toDisplay];
}

- (void)parseData
{
     _pm = [[PerformanceMeasurer alloc] initWithObject:self];
    _dataArray = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MessageFile" ofType:@"plist"];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    UIImage *avatarImage1 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
    UIImage *avatarImage2 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
    for(NSArray *obj in tempArray)
    {
        if([obj[0] boolValue])
        {
            [_dataArray addObject:[[EFCellData alloc] initWithText:obj[1] withType:readSentWithAvatar withImage:avatarImage1]];
        }
        else
        {
            [_dataArray addObject:[[EFCellData alloc] initWithText:obj[1] withType:receivedWithAvatar withImage:avatarImage2]];
        }
        
    }
    //NSLog(@"%@",dataArray);
}
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self parseData];
        // Custom initialization
    }
    return self;

    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self parseData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EFCell";
    EFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    EFCellData *data = _dataArray[indexPath.row];

    if(self.interfaceOrientation != UIInterfaceOrientationPortrait && data.type == readSentWithAvatar)
        [data.customView shiftFrameForLandScape];
    else if(data.type == readSentWithAvatar)
        [data.customView shiftFrameForPortrait];
       
    cell.data = data;
       
    return cell;
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UITableViewCell *tempCell;
    for (NSIndexPath *path in [self.tableView indexPathsForVisibleRows]) {
        tempCell = [self.tableView cellForRowAtIndexPath:path];
            for(EFCustomView *obj in tempCell.contentView.subviews)
            {
                if(obj.type == readSentWithAvatar)
                {
                    if(toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown && toInterfaceOrientation != UIInterfaceOrientationPortrait)
                        [obj shiftFrameForLandScape];
                    else
                        [obj shiftFrameForPortrait];
                }
            }
        }
       

}



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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return !(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"%d %f",indexPath.row,MAX(AVATARPICHEIGHT,[[_dataArray[indexPath.row] sizeOfCell] CGSizeValue].height + YCELLBUFFER + YTEXTBUFFER));
    return MAX(AVATARPICHEIGHT,[[_dataArray[indexPath.row] sizeOfCell] CGSizeValue].height + YCELLBUFFER + YTEXTBUFFER);
}

@end

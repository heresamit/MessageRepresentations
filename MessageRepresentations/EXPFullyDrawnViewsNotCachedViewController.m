//
//  EXPFullyDrawnViewsNotCachedViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 04/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPFullyDrawnViewsNotCachedViewController.h"
#import "EFCellData.h"
#import "constants.h"
#import "PerformanceMeasurer.h"
@interface EXPFullyDrawnViewsNotCachedViewController ()

@property (nonatomic,strong) UIImage *avatarImage1;
@property (nonatomic,strong) UIImage *avatarImage2;
@property (nonatomic,strong) PerformanceMeasurer* pm;

@end

@implementation EXPFullyDrawnViewsNotCachedViewController

-(void) updateNavBar:(int)toDisplay
{
    self.navigationItem.title = [NSString stringWithFormat:@"%d",toDisplay];
}
- (void)parseData
{
    _pm = [[PerformanceMeasurer alloc] initWithObject:self];
    
    _avatarImage1 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
    _avatarImage2 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
    _dataDictionary = [[NSMutableDictionary alloc] initWithCapacity:_tempArray.count];
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
    NSLog(@"Memory Warning.");
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tempArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *tempNumber = [NSNumber numberWithInteger:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EFCell"];
    EFCellData *data = [_dataDictionary objectForKey:tempNumber];
    EFCustomView *view = [data getView];
    
    for(UIView *view1 in cell.contentView.subviews){
        [view1 removeFromSuperview];
    }
    
    if(self.interfaceOrientation != UIInterfaceOrientationPortrait && data.type == readSentWithAvatar)
        [data.customView shiftFrameForLandScape];
    else if(data.type == readSentWithAvatar)
        [data.customView shiftFrameForPortrait];
    
    [cell.contentView addSubview:view];
    // Configure the cell...
    
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return !(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
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
    
    NSNumber *tempNumber = [NSNumber numberWithInteger:indexPath.row];
    EFCellData *data = [_dataDictionary objectForKey:tempNumber];
    switch (data.customView.type) {
        case readSentWithAvatar:
            data.customView.type = selectedReadSentWithAvatar;
            break;
        case receivedWithAvatar:
            data.customView.type = selectedReceivedWithAvatar;
            break;
        case selectedReceivedWithAvatar:
            data.customView.type = receivedWithAvatar;
            break;
        case selectedReadSentWithAvatar:
            data.customView.type = readSentWithAvatar;
            break;
            
        default:
            break;
            
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *tempNumber = [NSNumber numberWithInteger:indexPath.row];
    EFCellData *data;
    if(!([_dataDictionary objectForKey:tempNumber]))
    {
        if([_tempArray[indexPath.row][0] boolValue])
        {
            data = [[EFCellData alloc] initWithTextWithoutViewCreation:_tempArray[indexPath.row][1] withType:readSentWithAvatar withImage:_avatarImage1];
        }
        else
        {
            data = [[EFCellData alloc] initWithTextWithoutViewCreation:_tempArray[indexPath.row][1] withType:receivedWithAvatar withImage:_avatarImage2];
        }
        [_dataDictionary setObject:data forKey:tempNumber];
    }
    else
        data = [_dataDictionary objectForKey:tempNumber];
    
    return MAX(AVATARPICHEIGHT,[[data sizeOfCell] CGSizeValue].height + YCELLBUFFER + YTEXTBUFFER);
    
}

@end

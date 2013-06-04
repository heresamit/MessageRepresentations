//
//  EXPLayerMethodTableViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 28/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPLayerMethodTableViewController.h"
#import "EXPLayerMethodCustomView.h"
#import "constants.h"
#import "CALayerMethodCellData.h"
#import "EXPLayerTypeCell.h"
#import "PerformanceMeasurer.h"
@interface EXPLayerMethodTableViewController ()

@property (nonatomic,strong) UIImage *avatarImage1;
@property (nonatomic,strong) UIImage *avatarImage2;
@property (nonatomic,strong) UIImage *bubbleImage1;
@property (nonatomic,strong) UIImage *bubbleImage2;
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;
@property (nonatomic,strong) PerformanceMeasurer* pm;
@end

@implementation EXPLayerMethodTableViewController

-(void) updateNavBar:(int)toDisplay
{
    self.navigationItem.title = [NSString stringWithFormat:@"%d",toDisplay];
}
- (void)parseData
{
    _pm = [[PerformanceMeasurer alloc] initWithObject:self];
    _dataDictionary = [[NSMutableDictionary alloc] init];
    _avatarImage1 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
    _avatarImage2 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
    _bubbleImage1 = [UIImage imageNamed:@"chat-bubble-incoming.png"];
    _bubbleImage2 = [UIImage imageNamed:@"chat-bubble-outgoing.png"];
    
    //NSLog(@"%@",dataArray);
}

/*
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
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return !(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
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
    //NSLog(@"%d",[_tempArray count]);
    return [_tempArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSNumber *tempNumber = [NSNumber numberWithInteger:indexPath.row];
//    EXPLayerTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LayerTypeCell"];
//    CALayerMethodCellData *data = [_dataDictionary objectForKey:tempNumber];
//    
//       
//    if(!data.viewHasBeenCreated)
//        [data drawView];
//
//    
//    
//
//    cell.data = data;
    
   
    NSNumber *tempNumber = [NSNumber numberWithInteger:indexPath.row];
    CALayerMethodCellData *data = [_dataDictionary objectForKey:tempNumber];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LayerTypeCell"];
    EXPLayerMethodCustomView *view = [data getDrawnView];
    
    for(UIView *view in cell.contentView.subviews){
        [view removeFromSuperview];
    }
    
    if(self.interfaceOrientation != UIInterfaceOrientationPortrait && data.type == readSentWithAvatar)
            [view shiftFrameForLandScape];
    else if(data.type == readSentWithAvatar)
            [view shiftFrameForPortrait];

    [cell.contentView addSubview:view];
    
    return cell;
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UITableViewCell *tempCell;
    for (NSIndexPath *path in [self.tableView indexPathsForVisibleRows]) {
        tempCell = [self.tableView cellForRowAtIndexPath:path];
        for(EXPLayerMethodCustomView *obj in tempCell.contentView.subviews)
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"%d %f",indexPath.row,MAX(AVATARPICHEIGHT,[[_dataArray[indexPath.row] sizeOfCell] CGSizeValue].height + YCELLBUFFER + YTEXTBUFFER));
    //

    
    NSNumber *tempNumber = [NSNumber numberWithInteger:indexPath.row];
    CALayerMethodCellData *data;
    if(!([_dataDictionary objectForKey:tempNumber]))
    {
        if([_tempArray[indexPath.row][0] boolValue])
        {
            data = [[CALayerMethodCellData alloc] initWithTextWithoutViewCreation:_tempArray[indexPath.row][1] withType:readSentWithAvatar withAvatarImage:_avatarImage1 withBubbleImage:_bubbleImage2];
        }
        else
        {
            data = [[CALayerMethodCellData alloc] initWithTextWithoutViewCreation:_tempArray[indexPath.row][1] withType:receivedWithAvatar withAvatarImage:_avatarImage2 withBubbleImage:_bubbleImage1];
        }
        [_dataDictionary setObject:data forKey:tempNumber];
    }
    else
        data = [_dataDictionary objectForKey:tempNumber];
    
    return MAX(AVATARPICHEIGHT,[[data sizeOfCell] CGSizeValue].height + YCELLBUFFER + YTEXTBUFFER);
}

@end

//
//  EXPFullyDrawnTableViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPFullyDrawnTableViewController.h"
#import "EXPAppDataSource.h"
#import "EXPSentMessageView.h"
#import "EXPReceivedMessageView.h"
#import "constants.h"

@interface EXPFullyDrawnTableViewController ()
@end

@implementation EXPFullyDrawnTableViewController
@synthesize messages;


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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        //NSLog(@"%d",messages.messageArray.count);
        return messages.messageArray.count;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *CellIdentifier;
    
        // Configure the cell...
        CGFloat textXBuffer;
    
        BOOL temp = [[[self.messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:0] boolValue];
        if(temp)
            {
                  //  _kXBuffer = cell.frame.size.width - _bubbleWidth - avatarWidth;
                    textXBuffer = 10.0f;
                     CellIdentifier = @"Responder";
            
            
                    EXPSentMessageView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell) {
                            cell = [[EXPSentMessageView alloc] init];
                            // or your custom initialization
                        }
                    cell.text = [[messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:1];
                                return cell;
            
                }
    
        else
            {
                    textXBuffer = 19.0f;
                    CellIdentifier = @"Host";
                    EXPReceivedMessageView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell) {
                            cell = [[EXPReceivedMessageView alloc] init];
                            // or your custom initialization
                        }
            //        cell.textLabel.opaque = YES;
            //        cell.textLabel.backgroundColor = [UIColor clearColor];
            //        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
            //        cell.textLabel.text = [[messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:1];
            //        NSLog(@"End");
            //        cell.opaque = YES;
            
            
                     cell.text = [[messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:1];
                    return cell;
            
                }
    
        //CGRect rect = CGRectMake(self.kXBuffer, kYBuffer, self.bubbleWidth, self.bubbleHeight);
    //    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //
    //    if (cell == nil) {
    //        cell = [[EXPSentMessageView alloc] init];
    //// or your custom initialization
    //    }
    
    //    EXPSentMessageView *nv = [[EXPSentMessageView alloc] initWithFrame:rect isHostBubble:temp];
    //    [nv setBackgroundColor:[UIColor clearColor]];
    //    [cell addSubview:nv];
    
        //CGRect textFrame = CGRectMake(textXBuffer, 1, rect.size.width - 3, rect.size.height -3);
        //self.textLabel = [[UILabel alloc] initWithFrame:textFrame];
    
    
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
        //CGRect frame = {CGPointMake(0,0),[[[messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:1] sizeWithFont:        [UIFont fontWithName:@"Helvetica Neue" size:15] forWidth:100 lineBreakMode:NSLineBreakByWordWrapping]};
      
        return [[[messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:1] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]  constrainedToSize: CGSizeMake(self.view.bounds.size.width - xLEFTBUFFERFORBUBBLE - xRIGHTBUFFERFORBUBBLE - xLEFTBUFFERFORTEXT - xRIGHTBUFFERFORTEXT - triangleHeight - xLEFTSHADOWMARGIN, 500)lineBreakMode:NSLineBreakByWordWrapping].height + netYBUFFERFORCELL;
    }
@end

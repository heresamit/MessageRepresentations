//
//  EXPSimpleDrawnViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPSimpleDrawnViewController.h"
#import "EXPSimpleReceiveView.h"
#import "EXPSimpleSendView.h"
#import "constants.h"

@interface EXPSimpleDrawnViewController ()

@end

@implementation EXPSimpleDrawnViewController

@synthesize messages;

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
        CellIdentifier = @"Host";
        
        
        EXPSimpleSendView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[EXPSimpleSendView alloc] init];
            // or your custom initialization
        }
        cell.size = [messages.heightArray objectAtIndex:indexPath.row];
        cell.text = [[messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:1];
      //  cell.layer.shouldRasterize = YES;
        return cell;
        
    }
    
    else
    {
        textXBuffer = 19.0f;
        CellIdentifier = @"Responder";
        EXPSimpleReceiveView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[EXPSimpleReceiveView alloc] init];
            // or your custom initialization
        }
        cell.size = [messages.heightArray objectAtIndex:indexPath.row];
        cell.text = [[messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:1];
        return cell;
        
    }
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
    //CGRect frame = {CGPointMake(0,0),[[[messages.messageArray objectAtIndex:indexPath.row] objectAtIndex:1] sizeWithFont:        [UIFont fontWithName:@"Helvetica Neue" size:15] forWidth:100 lineBreakMode:NSLineBreakByWordWrapping]};
    
    return [[messages.heightArray objectAtIndex:indexPath.row] CGSizeValue].height + netYBUFFERFORCELL;
}
@end

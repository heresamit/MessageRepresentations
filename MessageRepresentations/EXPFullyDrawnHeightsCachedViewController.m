//
//  EXPFullyDrawnHeightsCachedViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPFullyDrawnHeightsCachedViewController.h"
#import "EXPAppDataSource.h"
#import "EXPSentMessageView.h"
#import "EXPReceivedMessageView.h"
#import "constants.h"
#import  <QuartzCore/QuartzCore.h>
#define HOST @"Host"
#define RESPONDER @"Responder"

@interface EXPFullyDrawnHeightsCachedViewController ()

@end

@implementation EXPFullyDrawnHeightsCachedViewController
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messages.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL temp = [[self.messages.messageArray[indexPath.row] objectAtIndex:0] boolValue];
    NSString *abc;
    if(temp)
        abc = @"Host";
    else
        abc = @"Responder";
    
    EXPReceivedMessageView *cell = [tableView dequeueReusableCellWithIdentifier:abc];
    cell.layer.shouldRasterize = YES;
    cell.size = messages.heightArray[indexPath.row];
    cell.text = messages.messageArray[indexPath.row][1];
    [cell setNeedsDisplay];
    return cell;
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
    
    return [messages.heightArray[indexPath.row] CGSizeValue].height + netYBUFFERFORCELL;
}
@end

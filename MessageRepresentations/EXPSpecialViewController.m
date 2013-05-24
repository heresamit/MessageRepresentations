//
//  EXPSpecialViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPSpecialViewController.h"
#import "EXPSpecialTableView.h"

@interface EXPSpecialViewController ()

@property (nonatomic, strong) NSMutableArray *dataForBubbles;
@end

@implementation EXPSpecialViewController

@synthesize messages = _messages;
@synthesize dataForBubbles = _dataForBubbles;
@synthesize bubbleTableView = _bubbleTableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataForBubbles = [[NSMutableArray alloc] init];
    for(id obj in _messages.messageArray)
    {
        [_dataForBubbles addObject:[EXPBubbleData dataWithText:[obj objectAtIndex:1] date:[NSDate dateWithTimeIntervalSinceNow:0] type:!([[obj objectAtIndex:0] boolValue])]];
        
    }
    self.bubbleTableView.dataObjectForBubbles = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)rowsForBubbleTable:(EXPSpecialTableView *)tableView
{
    return [_dataForBubbles count];
}

- (EXPBubbleData *)bubbleTableView:(EXPSpecialTableView *)tableView dataForRow:(NSInteger)row
{
    return [_dataForBubbles objectAtIndex:row];
}

- (void)viewDidUnload {
    [self setBubbleTableView:nil];
    [super viewDidUnload];
}
@end

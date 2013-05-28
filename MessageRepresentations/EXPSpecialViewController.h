//
//  EXPSpecialViewController.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPAppDataSource.h"
#import "EXPBubbleData.h"
@class EXPSpecialTableView;

@interface EXPSpecialViewController : UITableViewController

@property (strong, nonatomic) IBOutlet EXPSpecialTableView *bubbleTableView;

@property (nonatomic, strong) EXPAppDataSource *messages;

- (NSInteger)rowsForBubbleTable:(EXPSpecialTableView *)tableView;
- (EXPBubbleData *)bubbleTableView:(EXPSpecialTableView *)tableView dataForRow:(NSInteger)row;

@end

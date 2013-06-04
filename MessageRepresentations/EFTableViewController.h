//
//  EFTableViewController.h
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFTableViewController : UITableViewController
@property (nonatomic,weak) NSMutableArray *tempArray;
- (void) updateNavBar:(int)toDisplay;
- (void)parseData;
@end

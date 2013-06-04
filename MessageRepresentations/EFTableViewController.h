//
//  EFTableViewController.h
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFTableViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *dataArray;
-(void) updateNavBar:(int)toDisplay;
@end

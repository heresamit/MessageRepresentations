//
//  EXPFullyDrawnViewsNotCachedViewController.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 04/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPFullyDrawnViewsNotCachedViewController : UITableViewController
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;
@property (nonatomic,strong) NSMutableArray *tempArray;
-(void) updateNavBar:(int)toDisplay;
-(void) parseData;
@end

//
//  EXPInsaneLabelCustomEmoticonsViewController.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 03/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXPInsaneLabelCustomEmoticonsViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *tempArray;
-(void) updateNavBar:(int)toDisplay;
- (void)parseData;
@end

//
//  EXPSpecialTableView.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPSpecialViewController.h"

@interface EXPSpecialTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) EXPSpecialViewController* dataObjectForBubbles;

@end

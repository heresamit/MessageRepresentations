//
//  EXPFullyDrawnTableViewController.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPAppDataSource.h"

@interface EXPFullyDrawnTableViewController : UITableViewController
@property (nonatomic,weak) EXPAppDataSource *messages;

@end
//
//  EXPSimpleDrawnViewController.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPAppDataSource.h"
@interface EXPSimpleDrawnViewController : UITableViewController
@property (nonatomic,weak) EXPAppDataSource *messages;
@end

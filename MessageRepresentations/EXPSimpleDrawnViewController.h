//
//  EXPSimpleDrawnViewController.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPAppDataSource.h"
#import  <QuartzCore/QuartzCore.h>

@interface EXPSimpleDrawnViewController : UITableViewController
@property (nonatomic,strong) EXPAppDataSource *messages;
-(void) updateNavBar:(int)toDisplay;
@end

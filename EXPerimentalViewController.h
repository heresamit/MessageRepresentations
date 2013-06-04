//
//  EXPerimentalViewController.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 30/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPInsaneLabel.h"
@interface EXPerimentalViewController : UIViewController <EXPInsaneLabeldelegate>
- (void) handleHyperLinkOrNumberTouches: (UIButton *) sender;
@end

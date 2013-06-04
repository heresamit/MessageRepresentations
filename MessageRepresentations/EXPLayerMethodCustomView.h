//
//  EXPLayerMethodCustomView.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 28/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constants.h"
@interface EXPLayerMethodCustomView : UIView
@property (nonatomic) typeOfBubble type;
@property (nonatomic, weak) NSString* text;
@property (nonatomic) CGSize size;
@property (nonatomic, weak) UIImage *avatarImage;
@property (nonatomic, weak) UIImage *bubbleImage;
- (id)initWithFrame:(CGRect)frame withType:(typeOfBubble) type withText:(NSString*) text withTextFrameSize:(CGSize)tempSize withAvatarImage:(UIImage *) img1 withBubbleImage:(UIImage *) img2;
- (void) shiftFrameForLandScape;
- (void) shiftFrameForPortrait;
@end

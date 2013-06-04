//
//  EXPLayerCustomEmoticons.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 03/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constants.h"
@interface EXPLayerCustomEmoticons : UIView
@property (nonatomic) typeOfBubble type;
@property (nonatomic, weak) NSString* text;
@property (nonatomic) CGSize size;
@property (nonatomic, weak) UIImage *avatarImage;
@property (nonatomic, weak) UIImage *bubbleImage;
@property (nonatomic, weak) NSDictionary *emoticonDictionary;

- (id)initWithFrame:(CGRect)frame withType:(typeOfBubble) type withText:(NSString*) text withTextFrameSize:(CGSize)tempSize withAvatarImage:(UIImage *) img1 withBubbleImage:(UIImage *) img2 withEmoticonDictionary:(NSDictionary*) emoticonDictionary;
- (void) shiftFrameForLandScape;
- (void) shiftFrameForPortrait;

@end

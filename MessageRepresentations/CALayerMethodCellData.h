//
//  CALayerMethodCellData.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 28/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXPLayerMethodCustomView.h"

@interface CALayerMethodCellData : NSObject
@property (nonatomic,strong) EXPLayerMethodCustomView *customView;
@property (readonly,nonatomic,strong) NSValue *sizeOfCell;
@property (nonatomic) typeOfBubble type;
@property (nonatomic,strong) NSString* text;
@property (nonatomic, weak) UIImage *avatarImage;
@property (nonatomic, weak) UIImage *bubbleImage;
@property (nonatomic) BOOL viewHasBeenCreated;
-(void) drawView;
//-(id) initWithText:(NSString *)text withType:(typeOfBubble)type withAvatarImage:(UIImage *)avatarImage withBubbleImage:(UIImage *)bubbleImage;
-(id) initWithTextWithoutViewCreation:(NSString *)text withType:(typeOfBubble)type withAvatarImage:(UIImage *)avatarImage withBubbleImage:(UIImage *)bubbleImage;
-(EXPLayerMethodCustomView *) getDrawnView;
@end

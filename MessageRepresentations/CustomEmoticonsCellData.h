//
//  CustomEmoticonsCellData.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 03/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXPLayerCustomEmoticons.h"
@interface CustomEmoticonsCellData : NSObject
@property (nonatomic,strong) EXPLayerCustomEmoticons *customView;
@property (readonly,nonatomic,strong) NSValue *sizeOfCell;
@property (nonatomic) typeOfBubble type;
@property (nonatomic,strong) NSString* text;
@property (nonatomic, weak) UIImage *avatarImage;
@property (nonatomic, weak) UIImage *bubbleImage;
@property (nonatomic) BOOL viewHasBeenCreated;
@property (nonatomic, weak) NSDictionary *emoticonDictionary;
-(id) initWithTextWithoutViewCreation:(NSString *)text withType:(typeOfBubble)type withAvatarImage:(UIImage *)avatarImage withBubbleImage:(UIImage *)bubbleImage withEmoticonDictionary:(NSDictionary *) emoticonDictionary;
-(EXPLayerCustomEmoticons *) getDrawnView;
@end

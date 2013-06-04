//
//  CustomEmoticonsCellData.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 03/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "CustomEmoticonsCellData.h"
#import "EXPInsaneLabel.h"

@implementation CustomEmoticonsCellData

-(id) initWithTextWithoutViewCreation:(NSString *)text withType:(typeOfBubble)type withAvatarImage:(UIImage *)avatarImage withBubbleImage:(UIImage *)bubbleImage withEmoticonDictionary:(NSDictionary *)emoticonDictionary
{
    
    self = [super init];
    if (self)
    {
                
        _text = text;
        _type = type;
        _avatarImage = avatarImage;
        _viewHasBeenCreated = NO;
        _bubbleImage = bubbleImage;
        _emoticonDictionary = emoticonDictionary;
        _sizeOfCell = [NSValue valueWithCGSize:[[[EXPInsaneLabel alloc] initWithEmoticonDictionary:emoticonDictionary withMaxTextWidth:MAXTEXTWIDTH] sizeOfViewForText:text]];
        //NSLog(@"%@",_sizeOfCell);
    }
    return self;
    
}

-(EXPLayerCustomEmoticons *) getDrawnView
{
    CGSize tempSize = [self.sizeOfCell CGSizeValue];
    CGFloat temp = tempSize.width + XBUBBLEBUFFER + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
    EXPLayerCustomEmoticons *view;
    switch (self.type) {
        case readSentWithAvatar:
            view = [[EXPLayerCustomEmoticons alloc] initWithFrame:CGRectMake( [[UIScreen mainScreen] bounds].size.width - temp, 0.0f,temp, MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:_type withText:_text withTextFrameSize:tempSize withAvatarImage:_avatarImage withBubbleImage:_bubbleImage withEmoticonDictionary:_emoticonDictionary];
            break;
            
        case receivedWithAvatar:
            
            view = [[EXPLayerCustomEmoticons alloc] initWithFrame:CGRectMake(0.0f,0.0f,temp,MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:_type withText:_text withTextFrameSize:tempSize withAvatarImage:_avatarImage withBubbleImage:_bubbleImage withEmoticonDictionary:_emoticonDictionary];
            break;
            
        default:
            break;
    }
    
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

@end

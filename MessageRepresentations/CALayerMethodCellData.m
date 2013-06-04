//
//  CALayerMethodCellData.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 28/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "CALayerMethodCellData.h"

@implementation CALayerMethodCellData

-(id) initWithTextWithoutViewCreation:(NSString *)text withType:(typeOfBubble)type withAvatarImage:(UIImage *)avatarImage withBubbleImage:(UIImage *)bubbleImage;{
    
    self = [super init];
    if (self)
    {
        CGSize tempSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(MAXTEXTWIDTH,INFINITY)  lineBreakMode:NSLineBreakByWordWrapping];// can font be reused?
        
        _sizeOfCell = [NSValue valueWithCGSize:tempSize];
        _text = text;
        _type = type;
        _avatarImage = avatarImage;
        _viewHasBeenCreated = NO;
        _bubbleImage = bubbleImage;
    }
    return self;
    
}

-(void) drawView
{
    CGSize tempSize = [self.sizeOfCell CGSizeValue];
    CGFloat temp = tempSize.width + XBUBBLEBUFFER + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
    
    switch (self.type) {
        case readSentWithAvatar:
            _customView = [[EXPLayerMethodCustomView alloc] initWithFrame:CGRectMake( [[UIScreen mainScreen] bounds].size.width - temp, 0.0f,temp, MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:_type withText:_text withTextFrameSize:tempSize withAvatarImage:_avatarImage withBubbleImage:_bubbleImage];
            break;
            
        case receivedWithAvatar:
            
            _customView = [[EXPLayerMethodCustomView alloc] initWithFrame:CGRectMake(0.0f,0.0f,temp,MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:_type withText:_text withTextFrameSize:tempSize withAvatarImage:_avatarImage withBubbleImage:_bubbleImage];
            break;
            
        default:
            break;
    }
    
    _customView.backgroundColor = [UIColor clearColor];
    self.viewHasBeenCreated = YES;

}

-(EXPLayerMethodCustomView *) getDrawnView
{
    CGSize tempSize = [self.sizeOfCell CGSizeValue];
    CGFloat temp = tempSize.width + XBUBBLEBUFFER + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
    EXPLayerMethodCustomView *view;
    switch (self.type) {
        case readSentWithAvatar:
            view = [[EXPLayerMethodCustomView alloc] initWithFrame:CGRectMake( [[UIScreen mainScreen] bounds].size.width - temp, 0.0f,temp, MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:_type withText:_text withTextFrameSize:tempSize withAvatarImage:_avatarImage withBubbleImage:_bubbleImage];
            break;
            
        case receivedWithAvatar:
            
            view = [[EXPLayerMethodCustomView alloc] initWithFrame:CGRectMake(0.0f,0.0f,temp,MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:_type withText:_text withTextFrameSize:tempSize withAvatarImage:_avatarImage withBubbleImage:_bubbleImage];
            break;
            
        default:
            break;
    }
    
    view.backgroundColor = [UIColor clearColor];
    return view;

}
/*
-(id) initWithText:(NSString *)text withType:(typeOfBubble)type withAvatarImage:(UIImage *)avatarImage withBubbleImage:(UIImage *)bubbleImage
{
    
    self = [super init];
    if (self)
    {
        CGSize tempSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(MAXTEXTWIDTH,INFINITY)  lineBreakMode:NSLineBreakByWordWrapping];// can font be reused?
        
        _sizeOfCell = [NSValue valueWithCGSize:tempSize];
        _text = text;
        _type = type;
        _avatarImage = avatarImage;
        if(type == receivedWithAvatar)
            _bubbleImage = [bubbleImage stretchableImageWithLeftCapWidth:11 topCapHeight:17];
        else if(type == readSentWithAvatar)
            _bubbleImage = [bubbleImage stretchableImageWithLeftCapWidth:15 topCapHeight:17];
        
        CGFloat temp = tempSize.width + XBUBBLEBUFFER + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
        
        switch (type) {
            case readSentWithAvatar:
                _customView = [[EXPLayerMethodCustomView alloc] initWithFrame:CGRectMake( [[UIScreen mainScreen] bounds].size.width - temp, 0.0f,temp, MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:type withText:text withTextFrameSize:tempSize withAvatarImage:_avatarImage withBubbleImage:_bubbleImage];
                break;
                
            case receivedWithAvatar:
                
                _customView = [[EXPLayerMethodCustomView alloc] initWithFrame:CGRectMake(0.0f,0.0f,temp,MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:type withText:text withTextFrameSize:tempSize withAvatarImage:_avatarImage withBubbleImage:_bubbleImage];
                break;
                
            default:
                break;
        }
        
        _customView.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}
*/
@end

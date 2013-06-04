//
//  EXPLayerCustomEmoticons.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 03/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPLayerCustomEmoticons.h"
#import <QuartzCore/QuartzCore.h>
#import "EXPInsaneLabel.h"

@implementation EXPLayerCustomEmoticons

- (void) shiftFrameForLandScape
{
    self.transform = CGAffineTransformMakeTranslation(160,0);
}
- (void) shiftFrameForPortrait
{
    self.transform = CGAffineTransformMakeTranslation(0,0);
}

- (id)initWithFrame:(CGRect)frame withType:(typeOfBubble) type withText:(NSString*) text withTextFrameSize:(CGSize)tempSize withAvatarImage:(UIImage *) img1 withBubbleImage:(UIImage *) img2 withEmoticonDictionary:(NSDictionary*) emoticonDictionary
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _type = type;
        _text = text;
        _size = tempSize;
        _avatarImage = img1;
        _bubbleImage = img2;
        _emoticonDictionary = emoticonDictionary;
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    switch (_type) {
        case readSentWithAvatar:
        {
            CALayer* gradientLayer = [[CALayer alloc] init];
            gradientLayer.contents = (__bridge id)(_bubbleImage.CGImage);
            gradientLayer.frame = CGRectMake(self.frame.size.width - AVATARPICWIDTH - AVATARXBUFFER - _size.width - 3.0f*XTEXTBUFFER/2.0f, YCELLBUFFER/2.0f, self.size.width + 3.0f*XTEXTBUFFER/2.0f, self.size.height + YTEXTBUFFER);
            gradientLayer.contentsScale = [UIScreen mainScreen].scale;
            gradientLayer.contentsCenter = CGRectMake(
                                                      11.0f/_bubbleImage.size.width,
                                                      17.0f/_bubbleImage.size.height,
                                                      //11,17,
                                                      (_bubbleImage.size.width - 24.0f)
                                                      /_bubbleImage.size.width
                                                      , (_bubbleImage.size.height - 28.0f)
                                                      /_bubbleImage.size.height
                                                      );
            
            [self.layer addSublayer:gradientLayer];
            
            CALayer* imageLayer = [[CALayer alloc] init];
            imageLayer.frame = CGRectMake(self.frame.size.width - AVATARXBUFFER/2.0f - AVATARPICWIDTH, YCELLBUFFER/2.0f, AVATARPICWIDTH,AVATARPICHEIGHT);
            imageLayer.contents = (__bridge id)_avatarImage.CGImage;
            [self.layer addSublayer:imageLayer];
            
            EXPInsaneLabel *tempIL = [[EXPInsaneLabel alloc] initWithEmoticonDictionary:self.emoticonDictionary withMaxTextWidth:MAXTEXTWIDTH];
            UIView *textView = [tempIL getViewForText:self.text];
            //textView.backgroundColor = [UIColor clearColor];
            textView.transform = CGAffineTransformMakeTranslation(self.frame.size.width - AVATARPICWIDTH - AVATARXBUFFER - _size.width - XTEXTBUFFER, YCELLBUFFER/2.0f + YTEXTBUFFER/2.0f);
            [self addSubview:textView];
            break;
            
        }
        case receivedWithAvatar:
        {
            
            CALayer* gradientLayer = [[CALayer alloc] init];
            gradientLayer.contents = (__bridge id)(_bubbleImage.CGImage);
            gradientLayer.frame = CGRectMake(AVATARPICWIDTH + AVATARXBUFFER, YCELLBUFFER/2.0f, self.size.width + 3.0f * XTEXTBUFFER/2.0f, self.size.height + YTEXTBUFFER);
            gradientLayer.contentsScale = [UIScreen mainScreen].scale;
            gradientLayer.contentsCenter = CGRectMake(
                                                      15.0f/_bubbleImage.size.width,
                                                      17.0f/_bubbleImage.size.height,
                                                      //11,17,
                                                      (_bubbleImage.size.width - 30.0f)
                                                      /_bubbleImage.size.width
                                                      , (_bubbleImage.size.height - 28.0f)
                                                      /_bubbleImage.size.height
                                                      );
            [self.layer addSublayer:gradientLayer];
            
            CALayer* imageLayer = [[CALayer alloc] init];
            imageLayer.frame = CGRectMake(AVATARXBUFFER/2 , YCELLBUFFER/2, AVATARPICWIDTH,AVATARPICHEIGHT);
            imageLayer.contents = (__bridge id)_avatarImage.CGImage;
            [self.layer addSublayer:imageLayer];
            
            EXPInsaneLabel *tempIL = [[EXPInsaneLabel alloc] initWithEmoticonDictionary:self.emoticonDictionary withMaxTextWidth:MAXTEXTWIDTH];
            UIView *textView = [tempIL getViewForText:self.text];
            textView.transform = CGAffineTransformMakeTranslation(XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER, YCELLBUFFER/2.0f + YTEXTBUFFER/2.0f);
            //textView.backgroundColor = [UIColor clearColor];
            [self addSubview:textView];
            
            break;
        }
        default:
            break;
    }
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end


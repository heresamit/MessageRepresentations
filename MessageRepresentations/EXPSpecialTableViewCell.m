//
//  EXPSpecialTableViewCell.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPSpecialTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "constants.h"
@interface EXPSpecialTableViewCell()
@property (nonatomic, retain) UIImageView *bubbleImage;
@property (nonatomic, retain) UIView *customView;
@property (nonatomic, retain) UIImageView *avatarImage;
@end

@implementation EXPSpecialTableViewCell

@synthesize data = _data;
@synthesize bubbleImage = _bubbleImage;
@synthesize customView = _customView;

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
	[self setupInternalData];
}

- (void)setDataInternal:(EXPBubbleData *)value
{
	self.data = value;
	[self setupInternalData];
}

- (void) setupInternalData
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!self.bubbleImage)
    {
        self.bubbleImage = [[UIImageView alloc] init];
        [self addSubview:self.bubbleImage];
    }
    
    NSBubbleType type = self.data.type;
    
    CGFloat width = self.data.view.frame.size.width;
    CGFloat height = self.data.view.frame.size.height;
    
    CGFloat x = (type == BubbleTypeSomeoneElse) ? 0 : self.frame.size.width - width - self.data.insets.left - self.data.insets.right;
    CGFloat y = 0;
   
        [self.avatarImage removeFromSuperview];
        //NSLog(@"aaaa%@",self.data.avatar);

        self.avatarImage = [[UIImageView alloc] initWithImage: self.data.avatar];
                            //initWithImage:self.data.avatar ];
        
       // self.avatarImage.layer.cornerRadius = 9.0;
       // self.avatarImage.layer.masksToBounds = YES;
       // self.avatarImage.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
       // self.avatarImage.layer.borderWidth = 1.0;
        
        CGFloat avatarX = (type == BubbleTypeSomeoneElse) ? 2 : self.frame.size.width - 32;
    CGFloat avatarY = 0;//YCELLBUFFER/2;
        
        self.avatarImage.frame = CGRectMake(avatarX, avatarY, 30, 30);
        [self addSubview:self.avatarImage];
    
        
        CGFloat delta = self.frame.size.height - (self.data.insets.top + self.data.insets.bottom + self.data.view.frame.size.height);
        if (delta > 0) y = delta;
        
        if (type == BubbleTypeSomeoneElse) x += 34;
        if (type == BubbleTypeMine) x -= 34;
    
    
    [self.customView removeFromSuperview];
    self.customView = self.data.view;
    self.customView.frame = CGRectMake(x + self.data.insets.left, y + self.data.insets.top, width, height);
    [self.contentView addSubview:self.customView];
    
    if (type == BubbleTypeSomeoneElse)
    {
        self.bubbleImage.image = [[UIImage imageNamed:@"chat-bubble-incoming.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:17];
    }
    else {
        self.bubbleImage.image = [[UIImage imageNamed:@"chat-bubble-outgoing.png"] stretchableImageWithLeftCapWidth:11 topCapHeight:17];
    }
    
    self.bubbleImage.frame = CGRectMake(x, y
                                        //+ YCELLBUFFER/2
                                        , width + self.data.insets.left + self.data.insets.right, height + self.data.insets.top + self.data.insets.bottom);
}

@end


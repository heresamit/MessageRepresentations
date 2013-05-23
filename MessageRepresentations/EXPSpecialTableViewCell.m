//
//  EXPSpecialTableViewCell.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPSpecialTableViewCell.h"

@interface EXPSpecialTableViewCell()
@property (nonatomic, retain) UIImageView *bubbleImage;
@property (nonatomic, retain) UIView *customView;
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
    
    self.bubbleImage.frame = CGRectMake(x, y, width + self.data.insets.left + self.data.insets.right, height + self.data.insets.top + self.data.insets.bottom);
}

@end


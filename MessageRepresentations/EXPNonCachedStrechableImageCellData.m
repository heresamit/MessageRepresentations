//
//  EXPNonCachedStrechableImageCellData.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 04/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPNonCachedStrechableImageCellData.h"

@implementation EXPNonCachedStrechableImageCellData

#pragma mark - Text bubble

const UIEdgeInsets textInsetsMine1 = {5, 10, 11, 17};
const UIEdgeInsets textInsetsSomeone1 = {5, 15, 11, 10};

+ (id)dataWithText:(NSString *)text type:(NSBubbleType)type withAvatar:(UIImage *)avatar
{
    return [[EXPNonCachedStrechableImageCellData alloc] initWithText:text type:type withAvatar:avatar];
}

- (EXPNonCachedStrechableImageCustomView *) getView
{
    return (EXPNonCachedStrechableImageCustomView *)[NSNull null];
}
- (id)initWithText:(NSString *)text type:(NSBubbleType)type withAvatar:(UIImage *) avatar
{
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize size = [(text ? text : @"") sizeWithFont:font constrainedToSize:CGSizeMake(220, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = (text ? text : @"");
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    UIEdgeInsets insets = (type == BubbleTypeMine ? textInsetsMine1 : textInsetsSomeone1);
    self.avatarImage = avatar;
    return [self initWithView:label  type:type insets:insets];
}

#pragma mark - Custom view bubble

+ (id)dataWithView:(UIView *)view type:(NSBubbleType)type insets:(UIEdgeInsets)insets
{
    return [[EXPNonCachedStrechableImageCellData alloc] initWithView:view type:type insets:insets];
}

- (id)initWithView:(UIView *)view type:(NSBubbleType)type insets:(UIEdgeInsets)insets
{
    self = [super init];
    if (self)
    {
        _view = view;
        _type = type;
        _insets = insets;
    }
    return self;
}


@end

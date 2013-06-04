//
//  EXPBubbleData.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//
#import "EXPBubbleData.h"
#import <QuartzCore/QuartzCore.h>

@implementation EXPBubbleData


#pragma mark - Text bubble

const UIEdgeInsets textInsetsMine = {5, 10, 11, 17};
const UIEdgeInsets textInsetsSomeone = {5, 15, 11, 10};

+ (id)dataWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type withAvatar:(UIImage *)avatar
{
    return [[EXPBubbleData alloc] initWithText:text date:date type:type withAvatar:avatar];
}

- (id)initWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type withAvatar:avatar
{
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize size = [(text ? text : @"") sizeWithFont:font constrainedToSize:CGSizeMake(220, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = (text ? text : @"");
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    UIEdgeInsets insets = (type == BubbleTypeMine ? textInsetsMine : textInsetsSomeone);
    self.avatar = avatar;
    return [self initWithView:label date:date type:type insets:insets];
}

#pragma mark - Image bubble

const UIEdgeInsets imageInsetsMine = {11, 13, 16, 22};
const UIEdgeInsets imageInsetsSomeone = {11, 18, 16, 14};

+ (id)dataWithImage:(UIImage *)image date:(NSDate *)date type:(NSBubbleType)type
{
    return [[EXPBubbleData alloc] initWithImage:image date:date type:type];
}

- (id)initWithImage:(UIImage *)image date:(NSDate *)date type:(NSBubbleType)type
{
    CGSize size = image.size;
    if (size.width > 220)
    {
        size.height /= (size.width / 220);
        size.width = 220;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image = image;
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    
    UIEdgeInsets insets = (type == BubbleTypeMine ? imageInsetsMine : imageInsetsSomeone);
    return [self initWithView:imageView date:date type:type insets:insets];
}

#pragma mark - Custom view bubble

+ (id)dataWithView:(UIView *)view date:(NSDate *)date type:(NSBubbleType)type insets:(UIEdgeInsets)insets
{
    return [[EXPBubbleData alloc] initWithView:view date:date type:type insets:insets];
}

- (id)initWithView:(UIView *)view date:(NSDate *)date type:(NSBubbleType)type insets:(UIEdgeInsets)insets
{
    self = [super init];
    if (self)
    {
        _view = view;
        _date = date;
        _type = type;
        _insets = insets;
    }
    return self;
}

@end

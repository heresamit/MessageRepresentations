//
//  EXPNonCachedStrechableImageCellData.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 04/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXPNonCachedStrechableImageCustomView.h"
#import "constants.h"

@interface EXPNonCachedStrechableImageCellData : NSObject


@property (readonly, nonatomic) NSBubbleType type;
@property (readonly, nonatomic, strong) UIView *view;
@property (readonly, nonatomic) UIEdgeInsets insets;
@property (nonatomic, weak) UIImage *avatarImage;
@property (nonatomic, weak) UIImage *bubbleImage;

- (EXPNonCachedStrechableImageCustomView *) getView;

- (id)initWithText:(NSString *)text type:(NSBubbleType)type withAvatar:(UIImage *)avatar;
+ (id)dataWithText:(NSString *)text type:(NSBubbleType)type withAvatar:(UIImage *)avatar;
- (id)initWithView:(UIView *)view type:(NSBubbleType)type insets:(UIEdgeInsets)insets;
+ (id)dataWithView:(UIView *)view type:(NSBubbleType)type insets:(UIEdgeInsets)insets;

@end

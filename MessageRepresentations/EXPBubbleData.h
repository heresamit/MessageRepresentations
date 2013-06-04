//
//  EXPBubbleData.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"


@interface EXPBubbleData : NSObject

@property (readonly, nonatomic, strong) NSDate *date;
@property (readonly, nonatomic) NSBubbleType type;
@property (readonly, nonatomic, strong) UIView *view;
@property (readonly, nonatomic) UIEdgeInsets insets;
@property (nonatomic, weak) UIImage *avatar;

- (id)initWithText:(NSString *)text type:(NSBubbleType)type withAvatar:avatar;
+ (id)dataWithText:(NSString *)text type:(NSBubbleType)type withAvatar:(UIImage *)avatar;
- (id)initWithView:(UIView *)view type:(NSBubbleType)type insets:(UIEdgeInsets)insets;
+ (id)dataWithView:(UIView *)view type:(NSBubbleType)type insets:(UIEdgeInsets)insets;

@end

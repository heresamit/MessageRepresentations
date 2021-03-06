//
//  EXPReceivedMessageView.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPReceivedMessageView.h"
#import "constants.h"
#import "pathMethods.h"
@implementation EXPReceivedMessageView
- (void)drawRect:(CGRect)rect {
    
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat colorsArray[12]={255.0f/255.0f,255.0f/255.0f,255.0f/255.0f,1.0f,220.0f/255.0f,220.0f/255.0f,220.0f/255.0f,1.0f,230.0f/255.0f,230.0f/255.0f,230.0f/255.0f,1.0f};

        CGContextSetRGBStrokeColor(context, 200.0f/255.0f, 200.0f/255.0f, 200.0f/255.0f, 1.0f);//
        CGContextSaveGState(context);
        CGSize tempSize = [_size CGSizeValue];
        CGPoint textStartPoint = CGPointMake(rect.origin.x + xLEFTSHADOWMARGIN + xLEFTBUFFERFORBUBBLE  + xLEFTBUFFERFORTEXT + triangleHeight, rect.origin.y + netYBUFFERFORCELL/2);
        CGMutablePathRef path = createPathForResponderSpeechBubble(rect, 8.0f,tempSize.width);
//        CGContextAddPath(context, path);
//        UIColor * shadowColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
//        CGContextSetShadowWithColor(context, CGSizeMake(-2.5, 2.5), 3.0, shadowColor.CGColor);
//        CGContextDrawPath(context, kCGPathFill);
//    
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[] = { 0.0f,
                //   0.15,
                0.7f,
            1.0f };
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorsArray, locations, 3);
        CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
        CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
        CGContextRestoreGState(context);
        CGContextSetLineWidth(context, 1.0f);
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathStroke);

        [self.text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,tempSize.width,tempSize.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
        CGPathRelease(path);
    }

@end

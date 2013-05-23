//
//  EXPSentMessageView.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//
#import "EXPSentMessageView.h"
#import "constants.h"
#import "pathMethods.h"

@implementation EXPSentMessageView
@synthesize text = _text;

- (void)drawRect:(CGRect)rect {
    
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat colorsArray[12] = {215.0f/255.0f,235.0f/255.0f,240.0f/255.0f,1.0f,170.0f/255.0f,220.0f/255.0f,240.0f/255.0f,1.0f,200.0f/255.0f,230.0f/255.0f,240.0f/255.0f,1.0f};
    
        CGSize tempSize = [_text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15] constrainedToSize:CGSizeMake(rect.size.width - xLEFTBUFFERFORBUBBLE - xRIGHTBUFFERFORBUBBLE - xLEFTBUFFERFORTEXT - xRIGHTBUFFERFORTEXT - triangleHeight - xLEFTSHADOWMARGIN, 500) lineBreakMode:NSLineBreakByWordWrapping];
    
        CGContextSetRGBStrokeColor(context, 142.0f/255.0f, 207.0f/255.0f, 235.0f/255.0f, 1.0f);
        CGContextSaveGState(context);
        CGMutablePathRef path = createPathForHostSpeechBubble(rect, 8.0f, tempSize.width);
    
    
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
        CGPathRelease(path);
    
         CGPoint textStartPoint = CGPointMake(rect.size.width - xRIGHTBUFFERFORBUBBLE - xRIGHTBUFFERFORTEXT - triangleHeight - tempSize.width, rect.origin.y + netYBUFFERFORCELL/2);
    
        [_text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,tempSize.width,tempSize.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
       // NSLog(@"%f %f",textStartPoint.x,textStartPoint.y);
    
    }
@end

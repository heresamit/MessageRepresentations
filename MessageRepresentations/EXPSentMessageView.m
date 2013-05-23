//
//  EXPSentMessageView.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//
#import "EXPSentMessageView.h"
#import "constants.h"


@implementation EXPSentMessageView
@synthesize text = _text;


CGMutablePathRef createPathForHostSpeechBubble(CGRect rect, CGFloat cornerRadius, CGFloat textWidth) {
        //rect = CGRectInset(rect, -10, -10);
    
        // create a mutable path
        CGMutablePathRef path = CGPathCreateMutable();
    
        CGPoint topRight = CGPointMake(rect.size.width - triangleHeight - xRIGHTBUFFERFORBUBBLE, yTOPBUBBLEBUFFER);
        CGPoint topLeft = CGPointMake(topRight.x - textWidth - xLEFTBUFFERFORTEXT - xRIGHTBUFFERFORTEXT, topRight.y);
    
        CGPoint bottomLeft = CGPointMake(topLeft.x, rect.origin.y + rect.size.height - yBOTTOMBUBBLEBUFFER - yBOTTOMSHADOWMARGIN);
        CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y);
    
        // move to top left
        CGPathMoveToPoint(path, NULL, topLeft.x + cornerRadius, topLeft.y);
    
        // add top line
        CGPathAddLineToPoint(path, NULL, topRight.x - cornerRadius, topRight.y);
    
        // add top right curve
        CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius);
    
        // add right line
    
    
        //add little triangle
        CGPathAddLineToPoint(path,NULL, bottomRight.x, bottomRight.y - rect.size.height/2 - triangleWidth/2 + triangleTopBuffer);
        CGPathAddLineToPoint(path,NULL, bottomRight.x + triangleHeight, bottomRight.y - rect.size.height/2 + triangleTopBuffer);
        CGPathAddLineToPoint(path,NULL, bottomRight.x , bottomRight.y - rect.size.height/2 + triangleWidth/2 + triangleTopBuffer);
        CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - cornerRadius);
    
    
    
        // add bottom right curve
        CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - cornerRadius, bottomRight.y);
    
        // add bottom line
        CGPathAddLineToPoint(path, NULL, bottomLeft.x + cornerRadius, bottomLeft.y);
    
        // add bottom left curve
        CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - cornerRadius);
    
        // add left line
        CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + cornerRadius);
    
        // add top left curve
        CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y);
    
        // return the path
        return path;
    }
- (void)drawRect:(CGRect)rect {
    
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat colorsArray[12] = {215.0f/255.0f,235.0f/255.0f,240.0f/255.0f,1.0f,170.0f/255.0f,220.0f/255.0f,240.0f/255.0f,1.0f,200.0f/255.0f,230.0f/255.0f,240.0f/255.0f,1.0f};
    
        CGSize tempSize = [_text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15] constrainedToSize:CGSizeMake(rect.size.width - xLEFTBUFFERFORBUBBLE - xRIGHTBUFFERFORBUBBLE - xLEFTBUFFERFORTEXT - xRIGHTBUFFERFORTEXT - triangleHeight - xLEFTSHADOWMARGIN, 500) lineBreakMode:NSLineBreakByWordWrapping];
    
        CGContextSetRGBStrokeColor(context, 142.0f/255.0f, 207.0f/255.0f, 235.0f/255.0f, 1.0f);
        CGContextSaveGState(context);
        CGMutablePathRef path = createPathForHostSpeechBubble(rect, 8.0f, tempSize.width);
    
    
        CGContextAddPath(context, path);
        UIColor * shadowColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        CGContextSetShadowWithColor(context, CGSizeMake(-2.5, 2.5), 3.0, shadowColor.CGColor);
        CGContextDrawPath(context, kCGPathFill);
    
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

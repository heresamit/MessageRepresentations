//
//  EXPReceivedMessageView.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPReceivedMessageView.h"
#import "constants.h"

@implementation EXPReceivedMessageView
@synthesize text = _text;
CGMutablePathRef createPathForResponderSpeechBubble(CGRect rect, CGFloat cornerRadius, CGFloat textWidth) {
        // create a mutable path
        CGMutablePathRef path = CGPathCreateMutable();
       CGPoint topLeft = CGPointMake(rect.origin.x + xLEFTBUFFERFORBUBBLE + triangleHeight + xLEFTSHADOWMARGIN, rect.origin.y + yTOPBUBBLEBUFFER);
       CGPoint topRight = CGPointMake(topLeft.x + xRIGHTBUFFERFORTEXT + textWidth, rect.origin.y + yTOPBUBBLEBUFFER);
       CGPoint bottomLeft = CGPointMake(topLeft.x, rect.origin.y + rect.size.height - yBOTTOMBUBBLEBUFFER - yBOTTOMSHADOWMARGIN);
       CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y);
    
        // move to top left
        CGPathMoveToPoint(path, NULL, topLeft.x + cornerRadius, topLeft.y);
    
        // add top line
        CGPathAddLineToPoint(path, NULL, topRight.x - cornerRadius, topRight.y);
    
        // add top right curve
        CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius);
    
        // add right line
        CGPathAddLineToPoint(path,NULL, bottomRight.x, bottomRight.y - cornerRadius);
    
        // add bottom right curve
        CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - cornerRadius, bottomRight.y);
    
        // add bottom line
        CGPathAddLineToPoint(path, NULL, bottomLeft.x + cornerRadius, bottomLeft.y);
    
        // add bottom left curve
        CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - cornerRadius);
    
        //add little triangle
        CGPathAddLineToPoint(path,NULL, topLeft.x , bottomLeft.y - rect.size.height/2 +  triangleWidth/2 + triangleTopBuffer);
        CGPathAddLineToPoint(path,NULL, topLeft.x - triangleHeight, bottomLeft.y - rect.size.height/2 + triangleTopBuffer);
        CGPathAddLineToPoint(path,NULL, topLeft.x, bottomLeft.y - rect.size.height/2 - triangleWidth/2 + triangleTopBuffer);
    
        // add left line
        CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + cornerRadius);
    
        // add top left curve
        CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y);
    
        // return the path
        return path;
    
    }
- (void)drawRect:(CGRect)rect {
    
        CGContextRef context = UIGraphicsGetCurrentContext();
     CGFloat colorsArray[12]={255.0f/255.0f,255.0f/255.0f,255.0f/255.0f,1.0f,215.0f/255.0f,215.0f/255.0f,215.0f/255.0f,1.0f,230.0f/255.0f,230.0f/255.0f,230.0f/255.0f,1.0f};

            CGContextSetRGBStrokeColor(context, 200.0f/255.0f, 200.0f/255.0f, 200.0f/255.0f, 1.0f);//
            CGContextSaveGState(context);
        CGSize tempSize = [_text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15] constrainedToSize:CGSizeMake(rect.size.width - xLEFTBUFFERFORBUBBLE - xRIGHTBUFFERFORBUBBLE - xLEFTBUFFERFORTEXT - xRIGHTBUFFERFORTEXT - triangleHeight - xLEFTSHADOWMARGIN, 500) lineBreakMode:NSLineBreakByWordWrapping];
    
        CGPoint textStartPoint = CGPointMake(rect.origin.x + xLEFTSHADOWMARGIN + xLEFTBUFFERFORBUBBLE  + xLEFTBUFFERFORTEXT + triangleHeight, rect.origin.y + netYBUFFERFORCELL/2);
       CGMutablePathRef path = createPathForResponderSpeechBubble(rect, 8.0f,tempSize.width);
    
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

        [_text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,tempSize.width,tempSize.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    
        CGPathRelease(path);
    }

@end

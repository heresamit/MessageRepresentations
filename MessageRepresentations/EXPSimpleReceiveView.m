//
//  EXPSimpleReceiveView.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPSimpleReceiveView.h"
#import "pathMethods.h"
#import "constants.h"
@implementation EXPSimpleReceiveView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize tempSize = [_text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15] constrainedToSize:CGSizeMake(rect.size.width - xLEFTBUFFERFORBUBBLE - xRIGHTBUFFERFORBUBBLE - xLEFTBUFFERFORTEXT - xRIGHTBUFFERFORTEXT - triangleHeight - xLEFTSHADOWMARGIN, 500) lineBreakMode:NSLineBreakByWordWrapping];
    CGPoint textStartPoint = CGPointMake(rect.origin.x + xLEFTSHADOWMARGIN + xLEFTBUFFERFORBUBBLE  + xLEFTBUFFERFORTEXT + triangleHeight, rect.origin.y + netYBUFFERFORCELL/2);
    CGMutablePathRef path = createPathForResponderSpeechBubble(rect, 8.0f,tempSize.width);
    CGContextSetLineWidth(context, 1.0f);
    CGContextAddPath(context, path);
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 200.0f/255.0f, 200.0f/255.0f, 200.0f/255.0f, 1.0f);//
    CGContextSetRGBFillColor(context,230.0f/255.0f,230.0f/255.0f,230.0f/255.0f,1.0f);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
    [_text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,tempSize.width,tempSize.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    CGPathRelease(path);
}

@end

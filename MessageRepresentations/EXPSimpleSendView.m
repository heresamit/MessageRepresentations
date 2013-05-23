//
//  EXPSimpleSendView.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPSimpleSendView.h"
#import "constants.h"
#import "pathMethods.h"
@implementation EXPSimpleSendView
@synthesize text = _text;
@synthesize size = _size;

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize tempSize =[_size CGSizeValue];
    CGPoint textStartPoint = CGPointMake(rect.size.width - xRIGHTBUFFERFORBUBBLE - xRIGHTBUFFERFORTEXT - triangleHeight - tempSize.width, rect.origin.y + netYBUFFERFORCELL/2);
    CGMutablePathRef path = createPathForHostSpeechBubble(rect, 8.0f, tempSize.width);
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, 1.0f);
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 142.0f/255.0f, 207.0f/255.0f, 235.0f/255.0f, 1.0f);
    CGContextSetRGBFillColor(context,215.0f/255.0f,235.0f/255.0f,240.0f/255.0f,1.0f);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
    [_text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,tempSize.width,tempSize.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
    CGPathRelease(path);
}

@end

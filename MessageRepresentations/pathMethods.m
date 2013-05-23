//
//  pathMethods.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "pathMethods.h"
#import "constants.h"

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

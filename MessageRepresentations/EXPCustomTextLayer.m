//
//  EXPCustomTextLayer.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 29/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPCustomTextLayer.h"
#import "constants.h"

@implementation EXPCustomTextLayer
- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetFillColorWithColor(ctx, [[UIColor darkTextColor] CGColor]);
    
    UIGraphicsPushContext(ctx);
    [_text drawInRect:CGRectMake(0,0,self.size.width,self.size.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];

    UIGraphicsPopContext();
}

-(void) setText:(NSString *)text
{
    _text = text;
    [self setNeedsDisplay];
}
@end

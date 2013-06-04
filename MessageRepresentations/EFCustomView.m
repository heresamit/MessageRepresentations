//
//  EFCustomView.m
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EFCustomView.h"
#import "pathMethods.h"

@implementation EFCustomView

- (void) shiftFrameForLandScape
{
    self.transform = CGAffineTransformMakeTranslation(160,0);
}
- (void) shiftFrameForPortrait
{
     self.transform = CGAffineTransformMakeTranslation(0,0);
}


- (id)initWithFrame:(CGRect)frame withType:(typeOfBubble) type withText:(NSString*) text withTextFrameSize:(CGSize)tempSize withImage:(UIImage *) img
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _text = text;
        _size = tempSize;
        _avatarImage = img;
    }
    return self;
}

-(void) setType:(typeOfBubble)type
{
    _type = type;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    switch (_type) {
            
            
        case selectedReceivedWithAvatar:
        {
            CGContextRef context = UIGraphicsGetCurrentContext();
            [_avatarImage drawInRect:CGRectMake(AVATARXBUFFER/2,YCELLBUFFER/2, AVATARPICWIDTH, AVATARPICHEIGHT)];
            // 1) draw Avatar Image
            
            //get path
            CGMutablePathRef path = CGPathCreateMutable();
            CGPoint topLeft = CGPointMake(AVATARXBUFFER + AVATARPICWIDTH + triangleHeight, YCELLBUFFER/2);
            CGPoint topRight = CGPointMake(topLeft.x + XTEXTBUFFER + self.size.width, topLeft.y);
            
            CGPoint bottomLeft = CGPointMake(topLeft.x, rect.origin.y + rect.size.height - YCELLBUFFER/2);
            CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y);
            
            // move to top left
            CGPathMoveToPoint(path, NULL, topLeft.x + CORNERRADIUS, topLeft.y);
            
            // add top line
            CGPathAddLineToPoint(path, NULL, topRight.x - CORNERRADIUS, topRight.y);
            
            // add top right curve
            CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + CORNERRADIUS);
            
            // add right line
            CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - CORNERRADIUS);
            
            //add little triangle
            // CGPathAddLineToPoint(path,NULL, bottomRight.x, bottomRight.y - rect.size.height/2 - triangleWidth/2 + triangleTopBuffer);
            
            
            
            // add bottom right curve
            CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - CORNERRADIUS, bottomRight.y);
            
            // add bottom line
            CGPathAddLineToPoint(path, NULL, bottomLeft.x + CORNERRADIUS, bottomLeft.y);
            
            // add bottom left curve
            CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - CORNERRADIUS);
            
            // add left line
            CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + CORNERRADIUS + triangleHeight);
            
            CGPathAddLineToPoint(path,NULL,topLeft.x - triangleHeight, topRight.y + CORNERRADIUS + triangleWidth/2);
            CGPathAddLineToPoint(path,NULL, topLeft.x , topRight.y + CORNERRADIUS);
            CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + CORNERRADIUS);
            
            
            // add top left curve
            CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + CORNERRADIUS, topLeft.y);
            
            //
            
            
            
            
            CGFloat colorsArray[12] = {40.0f/255.0f,140.0f/255.0f,240.0f/255.0f,1.0f,25.0f/255.0f,95.0f/255.0f,215.0f/255.0f,1.0f,40.0f/255.0f,140.0f/255.0f,240.0f/255.0f,1.0f};
            
            CGContextSetRGBStrokeColor(context, 5.0f/255.0f,80.0f/255.0f,200.0f/255.0f,1.0f);
            CGContextSaveGState(context);
            CGContextAddPath(context, path);
            CGContextClip(context);
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGFloat locations[] = { 0.0f,
                //   0.15,
                0.7f,
                1.0f };
            
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorsArray, locations, 3);
            
            CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect) + YCELLBUFFER/2);
            CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect) - YCELLBUFFER/2);
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
            
            CGContextRestoreGState(context);
            CGContextSetLineWidth(context, 1.0f);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathStroke);
            CGPathRelease(path);
            
            CGPoint textStartPoint = CGPointMake(topLeft.x + XTEXTBUFFER/2, topLeft.y + YTEXTBUFFER/2);
            [[UIColor whiteColor] set];
            [self.text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,self.size.width,self.size.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            break;
        }
        case selectedReadSentWithAvatar:
        {
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            [_avatarImage drawInRect:CGRectMake(rect.size.width - AVATARPICWIDTH - AVATARXBUFFER/2, YCELLBUFFER/2 , AVATARPICWIDTH, AVATARPICHEIGHT)];
            // 1) draw Avatar Image
            
            //get path
            CGMutablePathRef path = CGPathCreateMutable();
            
            CGPoint topRight = CGPointMake(rect.size.width - triangleHeight - AVATARPICWIDTH - AVATARXBUFFER, YCELLBUFFER/2);
            CGPoint topLeft = CGPointMake(topRight.x - self.size.width - XTEXTBUFFER, topRight.y);
            
            CGPoint bottomLeft = CGPointMake(topLeft.x, rect.origin.y + rect.size.height - YCELLBUFFER/2);
            CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y);
            
            // move to top left
            CGPathMoveToPoint(path, NULL, topLeft.x + CORNERRADIUS, topLeft.y);
            
            // add top line
            CGPathAddLineToPoint(path, NULL, topRight.x - CORNERRADIUS, topRight.y);
            
            // add top right curve
            CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + CORNERRADIUS);
            
            // add right line
            
            
            //add little triangle
            // CGPathAddLineToPoint(path,NULL, bottomRight.x, bottomRight.y - rect.size.height/2 - triangleWidth/2 + triangleTopBuffer);
            CGPathAddLineToPoint(path,NULL, bottomRight.x + triangleHeight, topRight.y + CORNERRADIUS + triangleWidth/2);
            CGPathAddLineToPoint(path,NULL, bottomRight.x , topRight.y + CORNERRADIUS + triangleWidth);
            CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - CORNERRADIUS);
            
            
            
            // add bottom right curve
            CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - CORNERRADIUS, bottomRight.y);
            
            // add bottom line
            CGPathAddLineToPoint(path, NULL, bottomLeft.x + CORNERRADIUS, bottomLeft.y);
            
            // add bottom left curve
            CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - CORNERRADIUS);
            
            // add left line
            CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + CORNERRADIUS);
            
            // add top left curve
            CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + CORNERRADIUS, topLeft.y);
            
            //
            
            
            
            CGFloat colorsArray[12] = {40.0f/255.0f,140.0f/255.0f,240.0f/255.0f,1.0f,25.0f/255.0f,95.0f/255.0f,215.0f/255.0f,1.0f,40.0f/255.0f,140.0f/255.0f,240.0f/255.0f,1.0f};
            
            CGContextSetRGBStrokeColor(context, 5.0f/255.0f,80.0f/255.0f,200.0f/255.0f,1.0f);
            CGContextSaveGState(context);
            CGContextAddPath(context, path);
            CGContextClip(context);
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGFloat locations[] = { 0.0f,
                //   0.15,
                0.7f,
                1.0f };
            
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorsArray, locations, 3);
            
            CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect) + YCELLBUFFER/2);
            CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect) - YCELLBUFFER/2);
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
            
            CGContextRestoreGState(context);
            CGContextSetLineWidth(context, 1.0f);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathStroke);
            CGPathRelease(path);
            
            CGPoint textStartPoint = CGPointMake(topLeft.x + XTEXTBUFFER/2, topLeft.y + YTEXTBUFFER/2);
            [[UIColor whiteColor] set];
            [self.text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,self.size.width,self.size.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            break;
        }
            
        case readSentWithAvatar:
        {
               
            CGContextRef context = UIGraphicsGetCurrentContext();
           
            [_avatarImage drawInRect:CGRectMake(rect.size.width - AVATARPICWIDTH - AVATARXBUFFER/2, YCELLBUFFER/2 , AVATARPICWIDTH, AVATARPICHEIGHT)];
            // 1) draw Avatar Image
            
            //get path
            CGMutablePathRef path = CGPathCreateMutable();
            
            CGPoint topRight = CGPointMake(rect.size.width - triangleHeight - AVATARPICWIDTH - AVATARXBUFFER, YCELLBUFFER/2);
            CGPoint topLeft = CGPointMake(topRight.x - self.size.width - XTEXTBUFFER, topRight.y);
            
            CGPoint bottomLeft = CGPointMake(topLeft.x, rect.origin.y + rect.size.height - YCELLBUFFER/2);
            CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y);
            
            // move to top left
            CGPathMoveToPoint(path, NULL, topLeft.x + CORNERRADIUS, topLeft.y);
            
            // add top line
            CGPathAddLineToPoint(path, NULL, topRight.x - CORNERRADIUS, topRight.y);
            
            // add top right curve
            CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + CORNERRADIUS);
            
            // add right line
            
            
            //add little triangle
           // CGPathAddLineToPoint(path,NULL, bottomRight.x, bottomRight.y - rect.size.height/2 - triangleWidth/2 + triangleTopBuffer);
            CGPathAddLineToPoint(path,NULL, bottomRight.x + triangleHeight, topRight.y + CORNERRADIUS + triangleWidth/2);
            CGPathAddLineToPoint(path,NULL, bottomRight.x , topRight.y + CORNERRADIUS + triangleWidth);
            CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - CORNERRADIUS);
            
            
            
            // add bottom right curve
            CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - CORNERRADIUS, bottomRight.y);
            
            // add bottom line
            CGPathAddLineToPoint(path, NULL, bottomLeft.x + CORNERRADIUS, bottomLeft.y);
            
            // add bottom left curve
            CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - CORNERRADIUS);
            
            // add left line
            CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + CORNERRADIUS);
            
            // add top left curve
            CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + CORNERRADIUS, topLeft.y);
            
            //
            
            
            
            CGFloat colorsArray[12] = {215.0f/255.0f,235.0f/255.0f,240.0f/255.0f,1.0f,170.0f/255.0f,220.0f/255.0f,240.0f/255.0f,1.0f,200.0f/255.0f,230.0f/255.0f,240.0f/255.0f,1.0f};
            
            CGContextSetRGBStrokeColor(context, 142.0f/255.0f, 207.0f/255.0f, 235.0f/255.0f, 1.0f);
            CGContextSaveGState(context);
            CGContextAddPath(context, path);
            CGContextClip(context);
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGFloat locations[] = { 0.0f,
                //   0.15,
                0.7f,
                1.0f };
            
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorsArray, locations, 3);
            
            CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect) + YCELLBUFFER/2);
            CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect) - YCELLBUFFER/2);
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
            
            CGContextRestoreGState(context);
            CGContextSetLineWidth(context, 1.0f);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathStroke);
            CGPathRelease(path);
            
            CGPoint textStartPoint = CGPointMake(topLeft.x + XTEXTBUFFER/2, topLeft.y + YTEXTBUFFER/2);
            
            [self.text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,self.size.width,self.size.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            break;
        }
            
            
        
        case receivedWithAvatar:
        {
            CGContextRef context = UIGraphicsGetCurrentContext();
            [_avatarImage drawInRect:CGRectMake(AVATARXBUFFER/2,YCELLBUFFER/2, AVATARPICWIDTH, AVATARPICHEIGHT)];
            // 1) draw Avatar Image
            
            //get path
            CGMutablePathRef path = CGPathCreateMutable();
            CGPoint topLeft = CGPointMake(AVATARXBUFFER + AVATARPICWIDTH + triangleHeight, YCELLBUFFER/2);
            CGPoint topRight = CGPointMake(topLeft.x + XTEXTBUFFER + self.size.width, topLeft.y);
             
            CGPoint bottomLeft = CGPointMake(topLeft.x, rect.origin.y + rect.size.height - YCELLBUFFER/2);
            CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y);
            
            // move to top left
            CGPathMoveToPoint(path, NULL, topLeft.x + CORNERRADIUS, topLeft.y);
            
            // add top line
            CGPathAddLineToPoint(path, NULL, topRight.x - CORNERRADIUS, topRight.y);
            
            // add top right curve
            CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + CORNERRADIUS);
            
            // add right line
            CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - CORNERRADIUS);
            
            //add little triangle
            // CGPathAddLineToPoint(path,NULL, bottomRight.x, bottomRight.y - rect.size.height/2 - triangleWidth/2 + triangleTopBuffer);
            
            
            
            // add bottom right curve
            CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - CORNERRADIUS, bottomRight.y);
            
            // add bottom line
            CGPathAddLineToPoint(path, NULL, bottomLeft.x + CORNERRADIUS, bottomLeft.y);
            
            // add bottom left curve
            CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - CORNERRADIUS);
            
            // add left line
            CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + CORNERRADIUS + triangleHeight);
            
            CGPathAddLineToPoint(path,NULL,topLeft.x - triangleHeight, topRight.y + CORNERRADIUS + triangleWidth/2);
            CGPathAddLineToPoint(path,NULL, topLeft.x , topRight.y + CORNERRADIUS);
            CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + CORNERRADIUS);
            
            
            // add top left curve
            CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + CORNERRADIUS, topLeft.y);
            
            //
            
            
            
            CGFloat colorsArray[12]={255.0f/255.0f,255.0f/255.0f,255.0f/255.0f,1.0f,220.0f/255.0f,220.0f/255.0f,220.0f/255.0f,1.0f,230.0f/255.0f,230.0f/255.0f,230.0f/255.0f,1.0f};
            
            CGContextSetRGBStrokeColor(context, 200.0f/255.0f, 200.0f/255.0f, 200.0f/255.0f, 1.0f);
            CGContextSaveGState(context);
            CGContextAddPath(context, path);
            CGContextClip(context);
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGFloat locations[] = { 0.0f,
                //   0.15,
                0.7f,
                1.0f };
            
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorsArray, locations, 3);
            
            CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect) + YCELLBUFFER/2);
            CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect) - YCELLBUFFER/2);
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
            
            CGContextRestoreGState(context);
            CGContextSetLineWidth(context, 1.0f);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathStroke);
            CGPathRelease(path);
            
            CGPoint textStartPoint = CGPointMake(topLeft.x + XTEXTBUFFER/2, topLeft.y + YTEXTBUFFER/2);
            
            [self.text drawInRect:CGRectMake(textStartPoint.x,textStartPoint.y,self.size.width,self.size.height) withFont:[UIFont fontWithName:@"Helvetica Neue" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            break;
        }
                        
        default:
            break;
    }
}


@end

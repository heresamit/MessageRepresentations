//
//  EXPAppDataSource.m
//  Experiment
//
//  Created by Amit Chowdhary on 21/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPAppDataSource.h"
#import "constants.h" 
#import "pathMethods.h"
@interface EXPAppDataSource()
-(void) parseMessageFileToArray;
@end

@implementation EXPAppDataSource
@synthesize messageArray = _messageArray;
@synthesize heightArray = _heightArray;
@synthesize pathArray = _pathArray;

-(id) init
{
        self = [super init];
        if(self)
            {
                _heightArray = [[NSMutableArray alloc] init];
                _pathArray = [[NSMutableArray alloc] init];
                [self parseMessageFileToArray];
            }
        return self;
    }

- (void) parseMessageFileToArray
{
        _messageArray = [[NSMutableArray alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:
                                                 @"MessageFile" ofType:@"plist"];
        _messageArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        for(id obj in _messageArray)
        {
            CGSize tempSize = [[obj objectAtIndex:1] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]  constrainedToSize: CGSizeMake(CELLWIDTH - xLEFTBUFFERFORBUBBLE - xRIGHTBUFFERFORBUBBLE - xLEFTBUFFERFORTEXT - xRIGHTBUFFERFORTEXT - triangleHeight - xLEFTSHADOWMARGIN, 500) lineBreakMode:NSLineBreakByWordWrapping];
           [_heightArray addObject:[NSValue valueWithCGSize:tempSize]];
            
            CGRect tempRect = CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,tempSize.height + netYBUFFERFORCELL);
            
            CGPathRef path;
            if([[obj objectAtIndex:0] boolValue])
                path = createPathForHostSpeechBubble(tempRect, 8.0f ,tempSize.width);
            else
                path =  createPathForResponderSpeechBubble(tempRect, 8.0f ,tempSize.width);
            
            [_pathArray addObject:[UIBezierPath bezierPathWithCGPath:path]];
            
        }
   // NSLog(@"%@",_pathArray);
}


@end

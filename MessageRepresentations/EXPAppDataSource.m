//
//  EXPAppDataSource.m
//  Experiment
//
//  Created by Amit Chowdhary on 21/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPAppDataSource.h"
#import "constants.h" 

@interface EXPAppDataSource()
-(void) parseMessageFileToArray;
@end

@implementation EXPAppDataSource
@synthesize messageArray = _messageArray;
@synthesize heightArray = _heightArray;

-(id) init
{
        self = [super init];
        if(self)
            {
                _heightArray = [[NSMutableArray alloc] init];
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
           [_heightArray addObject:
            [NSValue valueWithCGSize:
             [[obj objectAtIndex:1] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15]  constrainedToSize: CGSizeMake(CELLWIDTH - xLEFTBUFFERFORBUBBLE - xRIGHTBUFFERFORBUBBLE - xLEFTBUFFERFORTEXT - xRIGHTBUFFERFORTEXT - triangleHeight - xLEFTSHADOWMARGIN, 500) lineBreakMode:NSLineBreakByWordWrapping]]]  ;
            
        }
}


@end

//
//  PerformanceMeasurer.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 28/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "PerformanceMeasurer.h"
#import <QuartzCore/QuartzCore.h>
#import "EXPLazyDrawnCachedTableViewController.h"

@implementation PerformanceMeasurer
-(id)initWithObject:(id)sender
{
    self = [super init];
    if(self)
    {
        _sender = sender;
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(targetMethod:)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void) targetMethod:(CADisplayLink *)displayink
{
    _displayTime = displayink.timestamp - _previousTimestamp;
    if(_displayTime > .0175)
    {
        _missed++;
        [_sender updateNavBar:_missed];
    }
    _previousTimestamp = displayink.timestamp;

}
@end

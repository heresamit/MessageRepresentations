//
//  PerformanceMeasurer.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 28/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerformanceMeasurer : NSObject
@property (nonatomic, strong) CADisplayLink* link;
@property (nonatomic, weak) id sender;
@property (nonatomic) CFTimeInterval previousTimestamp;
@property (nonatomic) int missed;
@property (nonatomic) float displayTime;
-(id)initWithObject:(id)sender;
-(void) targetMethod:(CADisplayLink *)displayink;
@end

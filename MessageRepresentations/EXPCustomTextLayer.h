//
//  EXPCustomTextLayer.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 29/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface EXPCustomTextLayer : CALayer
@property (nonatomic,weak) NSString *text;
@property (nonatomic) CGSize size;
@end

//
//  EXPAppDataSource.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXPAppDataSource : NSObject
@property (nonatomic,strong) NSMutableArray *messageArray;
@property (nonatomic,strong) NSMutableArray *heightArray;
@property (nonatomic,strong) NSMutableArray *pathArray;
@end
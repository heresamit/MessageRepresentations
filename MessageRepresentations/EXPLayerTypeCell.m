//
//  EXPLayerTypeCell.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 28/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPLayerTypeCell.h"

@implementation EXPLayerTypeCell

- (void) setData:(CALayerMethodCellData *)data
{
    _data = data;
    for(UIView *view in self.contentView.subviews){
        [view removeFromSuperview];
    }
    [self.contentView addSubview:data.customView];
}

@end

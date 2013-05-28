//
//  EFTableViewCell.h
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFCellData.h"
@interface EFTableViewCell : UITableViewCell
@property (nonatomic,strong) EFCellData* data;
//- (void)setFrame:(CGRect)frame;

@end

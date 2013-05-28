//
//  EFTableViewCell.m
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EFTableViewCell.h"

@implementation EFTableViewCell

-(id)initWithCoder:(NSCoder *)aDecoder
{
    //NSLog(@"initWithCoder");
    
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        

    }
    return self;
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self.contentView addSubview:_data.customView];
//        NSLog(@"initWithStyle");
//    }
//    return self;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

//- (void) setupInternalData
//{
//    //self.selectionStyle = UITableViewCellSelectionStyleNone;
//    //    [self.contentView addSubview:self.data.view];
//}
//
//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//	[self setupInternalData];
//}


- (void) setData:(EFCellData *)data
{
    _data = data;
    for(UIView *view in self.contentView.subviews){
        [view removeFromSuperview];
    }
    //[data.customView setFrameWithFrame:self.frame];
    [self.contentView addSubview:data.customView];
}

@end

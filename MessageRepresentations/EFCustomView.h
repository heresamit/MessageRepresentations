//
//  EFCustomView.h
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface EFCustomView : UIView
@property (nonatomic) typeOfBubble type;
@property (nonatomic, weak) NSString* text;
@property (nonatomic) CGSize size;
@property (nonatomic, weak) UIImage *avatarImage;
- (id)initWithFrame:(CGRect)frame withType:(typeOfBubble) type withText:(NSString*) text withTextFrameSize:(CGSize)tempSize withImage:(UIImage *) img;
- (void) shiftFrameForLandScape;
- (void) shiftFrameForPortrait;
@end

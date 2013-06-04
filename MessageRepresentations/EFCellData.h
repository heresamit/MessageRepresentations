//
//  EFCellData.h
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "EFCustomView.h"

@interface EFCellData : NSObject

@property (nonatomic,strong) EFCustomView *customView;
@property (readonly,nonatomic,strong) NSValue *sizeOfCell;
@property (nonatomic) typeOfBubble type;
@property (nonatomic,strong) NSString* text;
@property (nonatomic, weak) UIImage *avatarImage;
@property (nonatomic) BOOL viewHasBeenCreated;

-(id) initWithText:(NSString *)text withType:(typeOfBubble)type withImage:(UIImage *)avatarImage;
-(id) initWithTextWithoutViewCreation:(NSString *)text withType:(typeOfBubble)type withImage:(UIImage *)avatarImage;
-(void) drawView;
- (EFCustomView *) getView;
@end

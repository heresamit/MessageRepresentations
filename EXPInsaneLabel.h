//
//  EXPInsaneLabel.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 31/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

/*
 
 *---------Implemented---------*
 
 The main feature of this class is to return a view which has rich text in it.
 The input is an NSString, with numbers, hyperlinks and codes for images(emoticons) (eg. ":)" and ":(").
 The object requires an NSDictionary with keys as these codes and corresponding UIImages as objects.
 The size of these images can be variable. They are placed inline, with the text.
 Initialization also needs a maxWidth, the bound on width of the view being generated.
 Support for contiguous text larger than the maxWidth also remains to be added.
 An object must conform to the EXPInsaneLabeldelegate protocol,
 if it wants to receive touhces on hyperlinks and numbers.
 Multiple, consecutive/non-consecutive newline characters in the text are supported.
 Support for consecutive multiple whitespaces remains.
 Hyperlinks are recognized and are clickable.
 
 *---------Implemented---------*
 
 
 *-----------Pending-----------*
 
 1) Numbers remain to be covered.
 2) Hyperlinks are not underlined yet.

 *-----------Pending-----------*
 
 */


#import <UIKit/UIKit.h>

@class EXPInsaneLabel;
@protocol EXPInsaneLabeldelegate   //define delegate protocol

- (void) handleHyperLinkOrNumberTouches: (UIButton *) sender;  //define delegate method to be implemented within another class

@end //end protocol

@interface EXPInsaneLabel : NSObject
@property (nonatomic,strong) NSDictionary *emoticonDictionary;
@property (nonatomic) CGFloat maxTextWidth;
@property (nonatomic, weak) id <EXPInsaneLabeldelegate> delegate;

- (CGSize) sizeOfViewForText:(NSString *)text;
- (NSString *) prepareStringForTokenization: (NSString *) text;
- (UIView *) getViewForText:(NSString *)text;
- (id) initWithEmoticonDictionary:(NSDictionary *) emoticonDictionary withMaxTextWidth:(CGFloat) maxTextWidth;
@end

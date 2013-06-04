//
//  EFCellData.m
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 27/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EFCellData.h"


@implementation EFCellData


-(id) initWithText:(NSString *)text withType:(typeOfBubble)type withImage:(UIImage *)avatarImage
{
    
    self = [super init];
    if (self)
    {
        //calculate size for this amount of text
        //calculate size and store in self.size
        //alloc and create custom view depending on its type using size calculated above
        
    CGSize tempSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(MAXTEXTWIDTH,INFINITY)  lineBreakMode:NSLineBreakByWordWrapping];// can font be reused?
    
    _sizeOfCell = [NSValue valueWithCGSize:tempSize];
    _text = text;
    _type = type;
    _avatarImage = avatarImage;
    CGFloat temp = tempSize.width + XBUBBLEBUFFER + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
    
    switch (type) {
        case readSentWithAvatar:
                 _customView = [[EFCustomView alloc] initWithFrame:CGRectMake( [[UIScreen mainScreen] bounds].size.width - temp, 0.0f,temp, MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:type withText:text withTextFrameSize:tempSize withImage:_avatarImage];
            break;
               
        case receivedWithAvatar:
           
                 _customView = [[EFCustomView alloc] initWithFrame:CGRectMake(0.0f,0.0f,temp,MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:type withText:text withTextFrameSize:tempSize withImage:_avatarImage];
            break;
                
        default:
            break;
        }
   
    _customView.backgroundColor = [UIColor clearColor];
    
    }
    
    return self;
}

-(id) initWithTextWithoutViewCreation:(NSString *)text withType:(typeOfBubble)type withImage:(UIImage *)avatarImage
{
    self = [super init];
    if (self)
    {
        //calculate size for this amount of text
        //calculate size and store in self.size
        //alloc and create custom view depending on its type using size calculated above
        
        CGSize tempSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(MAXTEXTWIDTH,INFINITY)  lineBreakMode:NSLineBreakByWordWrapping];// can font be reused?
        
        _sizeOfCell = [NSValue valueWithCGSize:tempSize];
        _text = text;
        _type = type;
        _avatarImage = avatarImage;
        _viewHasBeenCreated = NO;
    }
    return self;
}

- (EFCustomView *) getView{
    
    CGSize tempSize = [_sizeOfCell CGSizeValue];
    CGFloat temp = tempSize.width + XBUBBLEBUFFER + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
    EFCustomView *view;
    switch (_type)
    {
        case readSentWithAvatar:
            view = [[EFCustomView alloc] initWithFrame:CGRectMake( [[UIScreen mainScreen] bounds].size.width - temp, 0.0f,temp, MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:_type withText:_text withTextFrameSize:tempSize withImage:_avatarImage];
            break;
        case receivedWithAvatar:
            
            view = [[EFCustomView alloc] initWithFrame:CGRectMake(0.0f,0.0f,temp,MAX(tempSize.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER) withType:_type withText:_text withTextFrameSize:tempSize withImage:_avatarImage];
            break;
        default:
            return (EFCustomView *)[NSNull null];
    }
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void) drawView
{
    self.customView = [self getView];
    _viewHasBeenCreated = YES;
    _customView.backgroundColor = [UIColor clearColor];
}
@end

//
//  EXPInsaneLabel.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 31/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPInsaneLabel.h"


//-------------------CONSTANTS-------------------//

#define EMOTICONWIDTH 8.0f
#define EMOTICONHEIFHT 8.0f
#define CHARACTERWIDTH 8.0f
#define ISEMOTICON(x) (x >= 0xE000 && x <= 0XF8FF) ? YES : NO //Give personal use range here.
#define YBUFFERFOREMOTICON 8.0f

//-------------------CONSTANTS-------------------//

@interface EXPInsaneLabel ()

@property (nonatomic, strong) NSMutableArray* thingsInCurrentLine;
@property (nonatomic) CGFloat currentX;//Points to where last UILabel or emoticonImage has Ended.
@property (nonatomic) CGFloat currentY;//Points to the bottom of last Line on top.
@property (nonatomic) CGFloat maxHeightInCurrentLine;//height of tallest view (Label or emoticon) in current line.
@property (nonatomic) CGFloat prevMaxHeightInCurrentLine;//variable to save previous max ht, used to shift views when max height changes.
@property (nonatomic, strong) NSArray* chunks;
@property (nonatomic) CGFloat maxWidth;
@end
@implementation EXPInsaneLabel

-(void) resetVariables
{
    self.currentX = 0.0f;
    self.currentY = 0.0f;
    [self.thingsInCurrentLine removeAllObjects];
    self.maxHeightInCurrentLine = 0.0f;
    self.prevMaxHeightInCurrentLine = 0.0f;
    self.maxWidth = 0.0f;
}

-(id) initWithEmoticonDictionary:(NSDictionary *) emoticonDictionary withMaxTextWidth:(CGFloat) maxTextWidth;
{
    self = [super init];
    if(self)
    {
        self.emoticonDictionary = emoticonDictionary;
        self.thingsInCurrentLine = [[NSMutableArray alloc] init];//stores pointers to labels and emoticons in current line.
        self.maxTextWidth = maxTextWidth;//width of the view being returned stays within this bound.
        
    }
    return self;
}

- (void) shiftFramesByY:(CGFloat) y
{
    //Whenever an emoticon needs to be inserted that is larger in the y dimension than the currently tallest component of the line,
    //we need to shift all the previous views down, to place the emoticon at the line bottom.
    for(UIView *obj in self.thingsInCurrentLine)
       obj.transform = CGAffineTransformMakeTranslation(0,y);
}

- (void) breakToNewLine//this method adjusts the internal properties whenever the line is changed.
{
    if(self.currentX > self.maxWidth)
        self.maxWidth = self.currentX;
    
    self.currentX = 0.0f;
    self.currentY += self.maxHeightInCurrentLine;
    self.maxHeightInCurrentLine = 0.0f;
    [self.thingsInCurrentLine removeAllObjects];
}

- (NSString *) handleMultipleconsecutiveSpaces: (NSString *) text
{

    CFStringRef selfAsCFStr = (__bridge CFStringRef)text;
    CFStringInlineBuffer inlineBuffer;
    CFIndex length = CFStringGetLength(selfAsCFStr);
    CFStringInitInlineBuffer(selfAsCFStr, &inlineBuffer, CFRangeMake(0, length));
    
    NSUInteger counter = 0;
    CFIndex j = 0;
    
    for (CFIndex i = 0; i < text.length; i++)
    {
        UniChar c = CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i);
        
        if (c == ' ')
        {
            counter = 0;
            j = i;
            i++;
            while ((i < text.length) && ( CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i) == ' '))
            {
                counter++;
                i++;
            }
            if(counter > 0)
            {
                NSRange tempRange = NSMakeRange(j, counter);
                NSString *tempString = [NSString stringWithFormat:@" %@%d", @"\uE000",counter];
                text = [text stringByReplacingCharactersInRange:tempRange withString:tempString];
                selfAsCFStr = (__bridge CFStringRef)text;
                CFStringInitInlineBuffer(selfAsCFStr, &inlineBuffer, CFRangeMake(0, text.length));
                i = i - (counter) +  tempString.length;
            }
        }

    }
    return text;
}

- (CGSize) sizeOfViewForText:(NSString *)text
{
   [self resetVariables];
    BOOL skipNextObj = NO;
    self.chunks = [text componentsSeparatedByString:@" "];
    int length = self.chunks.count;
    for (int a = 0; a < length; a++)
    {
        if(skipNextObj)
        {
            skipNextObj = NO;
            continue;
        }
        
        skipNextObj = NO;
        NSString *obj = self.chunks[a];
        UIImage *img = [self.emoticonDictionary objectForKey:obj];
        if(img)
        {
            if(self.currentX + img.size.width < self.maxTextWidth)//current emoticon can be accomodated in current line, simply add it.
            {
                if(img.size.height  > self.maxHeightInCurrentLine)//should it have been img.size.height + YBU
                {
                    self.prevMaxHeightInCurrentLine = self.maxHeightInCurrentLine;
                    self.maxHeightInCurrentLine = img.size.height;//change maxHeightInCurrentLine
                }
                
                self.currentX += img.size.width;
            }
            else if(img.size.width > self.maxTextWidth)//ERROR emoticon image is too big, skip
            {
                NSLog(@"Emoticon image is too wide, skipping it");
            }
            else//need to shift to new line as emoticon cannot be accomodated in current line.
            {
                //NSLog(@"2");
                [self breakToNewLine];
            }
            
            
        }
        //case 1 or 3 or 4
        else
        {
            if(a+1 < length)
            {
                NSString *nextObj = self.chunks[a+1];
                if([nextObj hasPrefix:[NSString stringWithFormat:@"%@", @"\uE000"]])
                {
                    NSString *spaces = [@"" stringByPaddingToLength:[[nextObj substringFromIndex:1] integerValue] withString: @" " startingAtIndex:0];
                    obj = [obj stringByAppendingString:spaces];
                    skipNextObj = YES;
                    //NSLog(@"%@",obj);
                }
            }
            
            //if([[NSScanner scannerWithString:value] scanInt:nil])
                CGSize newLabelSize = [[obj stringByAppendingString:@" "] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f]];//uses wordwrapping
                if(self.currentX + newLabelSize.width < self.maxTextWidth)//simply add a new UILabel
                {
                    if(newLabelSize.height > self.maxHeightInCurrentLine)
                    {
                        self.prevMaxHeightInCurrentLine = self.maxHeightInCurrentLine;
                        self.maxHeightInCurrentLine = newLabelSize.height;
                    }
                    self.currentX += newLabelSize.width;
                }
                else if(newLabelSize.width > self.maxTextWidth)//must break this obj into fittable labels
                {
                   [self breakToNewLine];
                    CGSize tempSize = [obj sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(self.maxTextWidth, INFINITY) lineBreakMode:NSLineBreakByCharWrapping];
                    self.maxHeightInCurrentLine = tempSize.height;
                    [self breakToNewLine];
                }
                else
                {
                    [self breakToNewLine];
                    
                    if(newLabelSize.height > self.maxHeightInCurrentLine)
                    {
                        self.prevMaxHeightInCurrentLine = self.maxHeightInCurrentLine;
                        self.maxHeightInCurrentLine = newLabelSize.height;
                    }
                    self.currentX += newLabelSize.width;
                }
            
        }
      
    
    }
    return CGSizeMake( MAX(self.currentX,self.maxWidth), self.currentY + self.maxHeightInCurrentLine);
}

- (NSString *) prepareStringForTokenization: (NSString *) text
{
    
    CFStringRef selfAsCFStr = (__bridge CFStringRef)text;
    CFStringInlineBuffer inlineBuffer;
    CFIndex length = CFStringGetLength(selfAsCFStr);
    CFStringInitInlineBuffer(selfAsCFStr, &inlineBuffer, CFRangeMake(0, length));
    
    NSUInteger counter = 0;
    CFIndex j = 0;
    
    for (CFIndex i = 0; i < text.length; i++)
    {
        UniChar c = CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i);
        
        if (c == ' ')
        {
            counter = 0;
            j = i;
            i++;
            while ((i < text.length) && ( CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i) == ' '))
            {
                counter++;
                i++;
            }
            if(counter > 0)
            {
                NSRange tempRange = NSMakeRange(j, counter);
                NSString *tempString = [NSString stringWithFormat:@" %@%d", @"\uE000",counter];
                text = [text stringByReplacingCharactersInRange:tempRange withString:tempString];
                selfAsCFStr = (__bridge CFStringRef)text;
                CFStringInitInlineBuffer(selfAsCFStr, &inlineBuffer, CFRangeMake(0, text.length));
                i = i - (counter) +  tempString.length;
            }
        }
        
    }
    return text;
}


- (UIView *) getViewForText:(NSString *)text
{
    /*
     Pending things: See header file. 
     Handle the case where first obj in chunk would have started with a sapce.
     */
    BOOL skipNextObj = NO;
    //text = [self handleMultipleconsecutiveSpaces:text];
    //NSLog(@"%@",self.emoticonDictionary);
    UIView *viewToReturn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.maxTextWidth, INFINITY)];//this view will be returned.
    //viewToReturn.backgroundColor = [UIColor greenColor];
    self.chunks = [text componentsSeparatedByString:@" "];//tokenized parts of our string.
    //NSLog(@"%@",chunks);

    //BOOL currentLineHasEmoticon = NO;//whether or not current line has emoticons
    //think whether it is useful
    int length = self.chunks.count;
    for (int a = 0; a < length; a++)
    {
        if(skipNextObj)
        {
            skipNextObj = NO;
            continue;
        }
        
        skipNextObj = NO;
        NSString *obj = self.chunks[a];
        /*
         Cases to be handled.
         1) normal text
         2) emoticon
         3) hyperlink
         4) number
         5) think about '\n' in obj, it will be a subcase of 1.
         */
        
        
        //case 2: Emoticon
        UIImage *img = [self.emoticonDictionary objectForKey:obj];
        //A Problem is faced here because the UILabels place text within themselves in a CGRect that is slightly smaller in the y dimension,
        //i.e. they provide a yBuffer. To place emoticons correctly we need to keep that into consideration. We use the #define YBUFFER for this.
        if(img)
        {
            //NSLog(@"%@",img);
            
            //currentLineHasEmoticon = YES;
            if(self.currentX + img.size.width < self.maxTextWidth)//current emoticon can be accomodated in current line, simply add it.
            {
                if(img.size.height  > self.maxHeightInCurrentLine)//should it have been img.size.height + YBU
                {
                    self.prevMaxHeightInCurrentLine = self.maxHeightInCurrentLine;
                    self.maxHeightInCurrentLine = img.size.height;//change maxHeightInCurrentLine
                    //should it have been img.size.height + YBUFFERFOREMOTICON above??
                    if(self.prevMaxHeightInCurrentLine != 0.0f)//make sure that this isn't the first view of this line
                        [self shiftFramesByY:self.maxHeightInCurrentLine - self.prevMaxHeightInCurrentLine];//shift all previous frames by change in maxHt
                }

                UIImageView *tempEmoticon = [[UIImageView alloc] initWithFrame:CGRectMake(self.currentX,
                                                                                      self.currentY + self.maxHeightInCurrentLine - img.size.height - YBUFFERFOREMOTICON/2.0f,
                                                                                      //currentY has bottom of the line above.
                                                                                      img.size.width,
                                                                                      img.size.height)];
                //tempEmoticon.backgroundColor = [UIColor blackColor];
                tempEmoticon.image = img;//set emoticon image for this view.
                [viewToReturn addSubview:tempEmoticon];//add label to the view to be returned
                self.currentX += img.size.width;
                [self.thingsInCurrentLine addObject:tempEmoticon];
            }
            else if(img.size.width > self.maxTextWidth)//ERROR emoticon image is too big, skip
            {
                NSLog(@"Emoticon image is too wide, skipping it");
            }
            else//need to shift to new line as emoticon cannot be accomodated in current line.
            {
                //NSLog(@"2");
                [self breakToNewLine];
            }
            
            
        }
        //case 1 or 3 or 4
        else
        {
            if(a+1 < length)
            {
                NSString *nextObj = self.chunks[a+1];
                if([nextObj hasPrefix:[NSString stringWithFormat:@"%@", @"\uE000"]])
                {
                    NSString *spaces = [@"" stringByPaddingToLength:[[nextObj substringFromIndex:1] integerValue] withString: @" " startingAtIndex:0];
                    obj = [obj stringByAppendingString:spaces];
                    skipNextObj = YES;
                           //NSLog(@"%@",obj);
                }
            }
            
            //if([[NSScanner scannerWithString:value] scanInt:nil])
            BOOL isUrl = [obj hasPrefix:@"http://"] || [obj hasPrefix:@"www."] || [obj hasPrefix:@"https://"] || [obj hasPrefix:@"ftp://"];
            BOOL isANumber = [[NSScanner scannerWithString:obj] scanInt:nil];
            
            if((!isUrl) && (!isANumber))
            {
                CGSize newLabelSize = [[obj stringByAppendingString:@" "] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f]];//uses wordwrapping
                if(self.currentX + newLabelSize.width < self.maxTextWidth)//simply add a new UILabel
                {
                    if(newLabelSize.height > self.maxHeightInCurrentLine)
                    {
                        self.prevMaxHeightInCurrentLine = self.maxHeightInCurrentLine;
                        self.maxHeightInCurrentLine = newLabelSize.height;
                        if(self.prevMaxHeightInCurrentLine != 0.0f)//make sure that this isn't the first view of this line
                            [self shiftFramesByY:self.maxHeightInCurrentLine - self.prevMaxHeightInCurrentLine];//shift all previous frames by change in maxHt
                    }
                    
                    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.currentX,
                                                                                   self.currentY + self.maxHeightInCurrentLine - newLabelSize.height,
                                                                                   //currentY has bottom of the line above.
                                                                                   newLabelSize.width, newLabelSize.height)];
                    
                    //set appropriate frame properties (text, backgroundColor, font) below.
                    tempLabel.backgroundColor = [UIColor clearColor];
                    tempLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
                    tempLabel.text = [obj stringByAppendingString:@" "];
                    //tempLabel.textAlignment =
                    [viewToReturn addSubview:tempLabel];//add label to the view to be returned
                    self.currentX += tempLabel.frame.size.width;
                    //dont need to modify currentY & currentLineHasEmoticon
                    [self.thingsInCurrentLine addObject:tempLabel];
                }
                else if(newLabelSize.width > self.maxTextWidth)//must break this obj into fittable labels
                {
                    /*
                     Steps to follow:
                     1) Break to new line.
                     2) Add a multiline label.
                     3) Update variables like self.maxHeightInCurrentLine
                     3) Break to new line.
                     */
                    [self breakToNewLine];
                    CGSize tempSize = [obj sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(self.maxTextWidth, INFINITY) lineBreakMode:NSLineBreakByCharWrapping];
                    //forWidth:self.maxTextWidth lineBreakMode:NSLineBreakByCharWrapping];
                    //NSLog(@"-00-%f",tempSize.height);
                    self.maxHeightInCurrentLine = tempSize.height;
                    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.currentX,
                                                                                   self.currentY + self.maxHeightInCurrentLine - tempSize.height,
                                                                                   //currentY has bottom of the line above.
                                                                                   tempSize.width, tempSize.height)];
                    tempLabel.numberOfLines = 0;
                    //set appropriate frame properties (text, backgroundColor, font) below.
                    tempLabel.lineBreakMode = NSLineBreakByCharWrapping;
                    tempLabel.backgroundColor = [UIColor clearColor];
                    tempLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
                    tempLabel.text = [obj stringByAppendingString:@" "];
                    //tempLabel.textAlignment =
                    [viewToReturn addSubview:tempLabel];
                    [self breakToNewLine];
                }
                else//must changeLine i.e. handle currentX, currentY,maxHeightInCurrentLine, currentLineHasEmoticon & thingsInCurrentLine.
                {
                    [self breakToNewLine];
                    
                    if(newLabelSize.height >self.maxHeightInCurrentLine)
                    {
                        self.prevMaxHeightInCurrentLine = self.maxHeightInCurrentLine;
                        self.maxHeightInCurrentLine = newLabelSize.height;
                        if(self.prevMaxHeightInCurrentLine != 0.0f)//make sure that this isn't the first view of this line
                            [self shiftFramesByY:self.maxHeightInCurrentLine - self.prevMaxHeightInCurrentLine];//shift all previous frames by change in maxHt
                    }
                    
                    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.currentX,
                                                                                   self.currentY + self.maxHeightInCurrentLine - newLabelSize.height,
                                                                                   //currentY has bottom of the line above.
                                                                                   newLabelSize.width, newLabelSize.height)];
                    
                    //set appropriate frame properties (text, backgroundColor, font) below.
                    tempLabel.backgroundColor = [UIColor clearColor];
                    tempLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
                    tempLabel.text = [obj stringByAppendingString:@" "];
                    //tempLabel.textAlignment =
                    [viewToReturn addSubview:tempLabel];//add label to the view to be returned
                    self.currentX += tempLabel.frame.size.width;
                    //dont need to modify currentY & currentLineHasEmoticon
                    [self.thingsInCurrentLine addObject:tempLabel];
                    
                    
                    //currentLineHasEmoticon = NO;
                }
            }
            else if(isUrl || isANumber)
            {
                
                CGSize newLabelSize = [[obj stringByAppendingString:@" "] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f]];//uses wordwrapping
                if(self.currentX + newLabelSize.width < self.maxTextWidth)//simply add a new UILabel
                {
                    if(newLabelSize.height > self.maxHeightInCurrentLine)
                    {
                        self.prevMaxHeightInCurrentLine = self.maxHeightInCurrentLine;
                        self.maxHeightInCurrentLine = newLabelSize.height;
                        if(self.prevMaxHeightInCurrentLine != 0.0f)//make sure that this isn't the first view of this line
                            [self shiftFramesByY:self.maxHeightInCurrentLine - self.prevMaxHeightInCurrentLine];//shift all previous frames by change in maxHt
                    }
                   
                    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.currentX,
                                                                                   self.currentY + self.maxHeightInCurrentLine - newLabelSize.height,
                                                                                   //currentY has bottom of the line above.
                                                                                   newLabelSize.width, newLabelSize.height)];
                    UIButton *tempButton = [[UIButton alloc] initWithFrame:tempLabel.frame];
                    tempButton.backgroundColor = [UIColor clearColor];
                    tempLabel.backgroundColor = [UIColor clearColor];
                   
                    if(isUrl)
                        tempLabel.textColor = [UIColor greenColor];
                    else
                        tempLabel.textColor = [UIColor blueColor];
                    
                    [tempButton addTarget:self.delegate action:@selector(handleHyperLinkOrNumberTouches:) forControlEvents:UIControlEventTouchUpInside];
                    //tempButton.titleLabel = tempLabel;
                    
                    //set appropriate frame properties (text, backgroundColor, font) below.
                    tempButton.backgroundColor = [UIColor clearColor];
                    tempLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
                    tempLabel.text = [obj stringByAppendingString:@" "];
                    tempButton.titleLabel.text = obj;
                    //tempLabel.textAlignment =
                    [viewToReturn addSubview:tempLabel];//add label to the view to be returned
                    [viewToReturn addSubview:tempButton];
                    self.currentX += tempLabel.frame.size.width;
                    //dont need to modify currentY & currentLineHasEmoticon
                    [self.thingsInCurrentLine addObject:tempLabel];
                }
                else if(newLabelSize.width > self.maxTextWidth)//must break this obj into fittable labels
                {
                    /*
                     Steps to follow:
                     1) Break to new line.
                     2) Add a multiline label.
                     3) Update variables like self.maxHeightInCurrentLine
                     3) Break to new line.
                     */
                    [self breakToNewLine];
                    CGSize tempSize = [obj sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(self.maxTextWidth, INFINITY) lineBreakMode:NSLineBreakByCharWrapping];
                    //forWidth:self.maxTextWidth lineBreakMode:NSLineBreakByCharWrapping];
                    //NSLog(@"-00-%f",tempSize.height);
                    self.maxHeightInCurrentLine = tempSize.height;
                    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.currentX,
                                                                                   self.currentY + self.maxHeightInCurrentLine - tempSize.height,
                                                                                   //currentY has bottom of the line above.
                                                                                   tempSize.width, tempSize.height)];
                    tempLabel.numberOfLines = 0;
                    //set appropriate frame properties (text, backgroundColor, font) below.
                    tempLabel.lineBreakMode = NSLineBreakByCharWrapping;
                    tempLabel.backgroundColor = [UIColor clearColor];
                    tempLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
                    tempLabel.text = [obj stringByAppendingString:@" "];
                    UIButton *tempButton = [[UIButton alloc] initWithFrame:tempLabel.frame];
                    tempButton.titleLabel.text = obj;
                    
                    tempButton.backgroundColor = [UIColor clearColor];
                    if(isUrl)
                        tempLabel.textColor = [UIColor greenColor];
                    else
                        tempLabel.textColor = [UIColor blueColor];
                    
                    [tempButton addTarget:self.delegate action:@selector(handleHyperLinkOrNumberTouches:)forControlEvents:UIControlEventTouchUpInside];

                    [viewToReturn addSubview:tempLabel];
                    [viewToReturn addSubview:tempButton];
                    
                    [self breakToNewLine];
                }
                else//must changeLine i.e. handle currentX, currentY,maxHeightInCurrentLine, currentLineHasEmoticon & thingsInCurrentLine.
                {
                    [self breakToNewLine];
                    
                    if(newLabelSize.height >self.maxHeightInCurrentLine)
                    {
                        self.prevMaxHeightInCurrentLine = self.maxHeightInCurrentLine;
                        self.maxHeightInCurrentLine = newLabelSize.height;
                        if(self.prevMaxHeightInCurrentLine != 0.0f)//make sure that this isn't the first view of this line
                            [self shiftFramesByY:self.maxHeightInCurrentLine - self.prevMaxHeightInCurrentLine];//shift all previous frames by change in maxHt
                    }
                    
                    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.currentX,
                                                                                   self.currentY + self.maxHeightInCurrentLine - newLabelSize.height,
                                                                                   //currentY has bottom of the line above.
                                                                                   newLabelSize.width, newLabelSize.height)];
                    
                    //set appropriate frame properties (text, backgroundColor, font) below.
                    tempLabel.backgroundColor = [UIColor clearColor];
                    tempLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
                    tempLabel.text = [obj stringByAppendingString:@" "];
                    
                    //tempLabel.textAlignment =
                    UIButton *tempButton = [[UIButton alloc] initWithFrame:tempLabel.frame];
                    tempButton.backgroundColor = [UIColor clearColor];
                    tempButton.titleLabel.text = obj;
                    if(isUrl)
                        tempLabel.textColor = [UIColor greenColor];
                    else
                        tempLabel.textColor = [UIColor blueColor];
                    
                    [tempButton addTarget:self.delegate action:@selector(handleHyperLinkOrNumberTouches:) forControlEvents:UIControlEventTouchUpInside];
                    //tempLabel.textAlignment =
                    
                    [viewToReturn addSubview:tempLabel];//add label to the view to be returned
                    [viewToReturn addSubview:tempButton];
                    self.currentX += tempLabel.frame.size.width;
                    //dont need to modify currentY & currentLineHasEmoticon
                    [self.thingsInCurrentLine addObject:tempLabel];
                    
                    
                    //currentLineHasEmoticon = NO;
                }

            }
        }
        
    }
    
    viewToReturn.frame = CGRectMake(0, 0, MAX(self.currentX,self.maxWidth), self.currentY + self.maxHeightInCurrentLine);//in the end the net height is in currentY
    return viewToReturn;
}
//
//- (NSMutableArray *) setText:(NSString *)text
//{
//    
//    NSString *newText = [[NSString alloc] init];;
//    //UILabel *label = [[UILabel alloc] init];
//    
//    self.numberOfLines = 0;
//    //NSDictionary *emoticonDictionary;
//    CGFloat currentX,currentY,temp;
//    currentX = currentY = temp = 0.0f;
//    //BOOL state = NO;
//    NSMutableArray *emoticonArray = [[NSMutableArray alloc] init];
//    NSArray *chunks = [text componentsSeparatedByString:@" "];
//    for (NSString *obj in chunks) {
//        //UIImage *emoticonImage = [emoticonDictionary objectForKey:obj];
//        UIImage *emoticonImage ;
//       
//        if([obj isEqualToString:@":)"])
//            emoticonImage = [UIImage imageNamed:@"avatarPlaceHolder.png"];
//        else
//            emoticonImage = nil;
//        
//        if(emoticonImage)
//        {
//            currentX += emoticonImage.size.width;
//            if(currentX > self.maxTextWidth)
//            {
//                currentX = 0;
//                temp = currentY;
//                currentY = [[newText stringByAppendingString:@"\n"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(self.maxTextWidth, INFINITY) lineBreakMode:NSLineBreakByWordWrapping].height;
//            }
//            UIImageView *emoticonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(currentX, currentY, emoticonImage.size.width, emoticonImage.size.height)];
//            emoticonImageView.image = emoticonImage;
//            [emoticonArray addObject:emoticonImageView];
//            newText = [newText stringByAppendingString:@"   "];
//            //CGSize tempSize =
//            NSLog(@"+++%@",obj);
//
//            
//        }
//        else
//        {
//            CGSize tempSize = [obj sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f]];
//            currentX += tempSize.width;
//            if(currentX > self.maxTextWidth)
//            {
//                currentX = 0;
//                temp = currentY;
//                currentY = tempSize.height;
//            }
//            NSLog(@"---%@",obj);
//            newText = [newText stringByAppendingString:[NSString stringWithFormat:@"%@ ",obj]];
//        }
//    }
//    
//    /*
//     TO DO LIST.
//     1) Adjust frame of UILabel.
//     2) Adjust text of UILabel.
//     3) Get CurrentX and CurrentY.
//     */
//    [super setText:newText];
//    CGSize tempSize1 = [newText sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(self.maxTextWidth, INFINITY) lineBreakMode:NSLineBreakByWordWrapping];
//    NSLog(@"%@",newText);
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, tempSize1.width, tempSize1.height);
//    return emoticonArray;
//
//}

//- (void) setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

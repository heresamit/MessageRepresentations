//
//  sizeOfTextFrame.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 30/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "sizeOfTextFrame.h"
#include <stdio.h>


//-------------------CONSTANTS-------------------//

#define EMOTICONWIDTH 8.0f
#define EMOTICONHEIFHT 8.0f
#define MAXTEXTWIDTH 300.0f
#define CHARACTERWIDTH 8.0f
#define ISEMOTICON(x) (x >= 0xE000 && x <= 0XF8FF) ? YES : NO //Give personal use range here.

//-------------------CONSTANTS-------------------//

@implementation sizeOfTextFrame

- (CGSize) calculateSizeOfFrame:(NSString *) text
{
    CGSize size = {0.0f,0.0f};
    CGFloat maxWidth,currentLineWidth,lineWidthAtPreviousWordBreak;
    maxWidth = currentLineWidth = lineWidthAtPreviousWordBreak = 0.0f;
    BOOL currentLineHasEmoticon = NO;
    BOOL emoticonsPresentBeforeLastBreak = NO;//change to emoticons present before last break
    BOOL emoticonsPresentInCurrentSegment = NO;
    NSInteger numberOfLinesWithEmoticons, numberOfLines, previousWordBreakPosition;
    numberOfLinesWithEmoticons = previousWordBreakPosition = 0;
    numberOfLines = 1;
    unichar temp;
    NSMutableArray *arrayWithIndexesOfLineStarts = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0], nil];

    for(NSInteger i = 0; i < [text length]; i++)
    {
        temp = [text characterAtIndex:i];
        if(ISEMOTICON(temp))
        {
            currentLineWidth += EMOTICONWIDTH;
            if(!currentLineHasEmoticon)
                {
                    numberOfLinesWithEmoticons++;
                    currentLineHasEmoticon = YES;
                    emoticonsPresentInCurrentSegment = YES;
                }
        }
        else
        {
            currentLineWidth += CHARACTERWIDTH;
            if(temp == ' ')
            {
                previousWordBreakPosition = i;
                lineWidthAtPreviousWordBreak = currentLineWidth;
                emoticonsPresentBeforeLastBreak = emoticonsPresentBeforeLastBreak | emoticonsPresentInCurrentSegment;
                emoticonsPresentInCurrentSegment = NO;
            }
            else if(temp == '\n')
            {
                numberOfLines++;
                currentLineWidth = 0.0f;
                lineWidthAtPreviousWordBreak = 0.0f;
                emoticonsPresentBeforeLastBreak = NO;
                emoticonsPresentInCurrentSegment = NO;
                [arrayWithIndexesOfLineStarts addObject:[NSNumber numberWithInteger:previousWordBreakPosition+1]];
            }
            
        }
        
        if(currentLineWidth > MAXTEXTWIDTH)
        {
            if(lineWidthAtPreviousWordBreak > maxWidth)
                maxWidth = lineWidthAtPreviousWordBreak;
            lineWidthAtPreviousWordBreak = 0.0f;
            currentLineWidth = 0.0f;
            numberOfLines++;
            i = previousWordBreakPosition;
            emoticonsPresentBeforeLastBreak = NO;
            emoticonsPresentInCurrentSegment = NO;
            
        }
        
    }
    
    return size;
}

- (void) setText:(NSString *)text
{    
    
    
    
    
}
@end

//
//  calculateSize.c
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 30/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#include <stdio.h>
#import <CoreGraphics/CoreGraphics.h>
//-------------------CONSTANTS-------------------//

#define EMOTICONWIDTH 8.0f
#define EMOTICONHEIFHT 8.0f
#define MAXTEXTWIDTH 200.0f
#define CHARACTERWIDTH 8.0f

//-------------------CONSTANTS-------------------//
int isEmoticon(unsigned int val)
{
    if(val >= 0xE000 && val <= 0XF8FF )
        return 1;//Private use area
    else if(val >= && val <= )
        return 2;//Emoji
    else
        return 0;//Not an emoticon.
}

CGSize calculateSize(const unsigned int* textPtr, CGFloat characterHeight, CGFloat characterWidth, CGFloat emoticonHeight, CGFloat emoticonWidth)
{
    CGSize size = {0.0f,0.0f};
    CGFloat t1,t2,t3;
    t1=t2=t3=0.0f;
    
    while(*textPtr != '\0')
    {
        while(1)
        {
            if(isEmoticon )
            if(t1 > MAXTEXTWIDTH)
            {
                
                break;
            }
        }
        textPtr++;
    }
    
    
    return size;
}
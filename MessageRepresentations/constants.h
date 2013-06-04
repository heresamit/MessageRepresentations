//
//  constants.h
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#define kYBuffer 3.0f
#define avatarWidth 30.0f

#define xLEFTBUFFERFORBUBBLE 2.0f
#define xRIGHTBUFFERFORBUBBLE 2.0f
#define xLEFTBUFFERFORTEXT 5.0f
#define xRIGHTBUFFERFORTEXT 10.0f
#define netYBUFFERFORCELL 20.0f

#define yBOTTOMSHADOWMARGIN 4.0f
#define xLEFTSHADOWMARGIN 4.0f

#define triangleHeight  9.5f
#define triangleWidth  9.5f
#define triangleTopBuffer 4.0f

#define yTOPBUBBLEBUFFER 5.0f
#define yBOTTOMBUBBLEBUFFER 2.0f

#define CELLWIDTH [[UIScreen mainScreen] bounds].size.width

#define MAXTEXTWIDTH 230.0f
#define AVATARPICHEIGHT 30.0f
#define AVATARPICWIDTH 30.0f
#define AVATARXBUFFER 8.0f
#define MAXTEXTHEIGHT 99999.0f

#define YCELLBUFFER 12.0f
#define YTEXTBUFFER 8.0f
#define XTEXTBUFFER 15.0f
#define XBUBBLEBUFFER 8.0f

#define triangleHeight  9.5f
#define triangleWidth  9.5f
#define triangleTopBuffer 4.0f
#define CORNERRADIUS 8.0f


typedef enum{
    receivedWithAvatar = 0,
    receivedWithoutAvatar,
    readSentWithAvatar,
    readSentWithoutAvatar,
    sendingWithAvatar,
    sendingWithoutAvatar,
    unreadSentWithAvatar,
    unreadSentWithoutAvatar,
    
    selectedReadSentWithAvatar,
    selectedReceivedWithAvatar
    //...
}typeOfBubble;

typedef enum _NSBubbleType
{
    BubbleTypeMine = 0,
    BubbleTypeSomeoneElse = 1
} NSBubbleType;

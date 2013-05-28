//
//  EXPSpecialTableView.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPSpecialTableView.h"
#import "EXPSpecialTableViewCell.h"
@interface EXPSpecialTableView ()

@end

@implementation EXPSpecialTableView

@synthesize dataObjectForBubbles = _dataObjectForBubbles;

-(void) initializer
{
    self.backgroundColor = [UIColor lightGrayColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    assert(self.style == UITableViewStylePlain);
    self.delegate = self;
    self.dataSource = self;

}

#pragma mark - initializer needs to be called in all inits

- (id)init
{
    self = [super init];
    if (self) [self initializer];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) [self initializer];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self initializer];
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) [self initializer];
    return self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    //NSLog(@"%d",[_dataObjectForBubbles rowsForBubbleTable:self]);
    return [_dataObjectForBubbles rowsForBubbleTable:self];
}


//
//#pragma mark - Override
//
//- (void)reloadData
//{
//    self.showsVerticalScrollIndicator = NO;
//    self.showsHorizontalScrollIndicator = NO;
//    
//    // Cleaning up
//	self.bubbleSection = nil;
//    
//    // Loading new data
//    int count = 0;
//    self.bubbleSection = [[NSMutableArray alloc] init];
//    
//    if (self.bubbleDataSource && (count = [self.bubbleDataSource rowsForBubbleTable:self]) > 0)
//    {
//        NSMutableArray *bubbleData = [[NSMutableArray alloc] initWithCapacity:count];
//        for (int i = 0; i < count; i++)
//        {
//            NSObject *object = [self.bubbleDataSource bubbleTableView:self dataForRow:i];
//            assert([object isKindOfClass:[NSBubbleData class]]);
//            [bubbleData addObject:object];
//        }
//        
//        [bubbleData sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
//         {
//             NSBubbleData *bubbleData1 = (NSBubbleData *)obj1;
//             NSBubbleData *bubbleData2 = (NSBubbleData *)obj2;
//             
//             return [bubbleData1.date compare:bubbleData2.date];
//         }];
//        
//        NSDate *last = [NSDate dateWithTimeIntervalSince1970:0];
//        NSMutableArray *currentSection = nil;
//        
//        for (int i = 0; i < count; i++)
//        {
//            NSBubbleData *data = (NSBubbleData *)[bubbleData objectAtIndex:i];
//            
//            if ([data.date timeIntervalSinceDate:last] > self.snapInterval)
//            {
//                currentSection = [[NSMutableArray alloc] init];
//                [self.bubbleSection addObject:currentSection];
//            }
//            
//            [currentSection addObject:data];
//            last = data.date;
//        }
//    }
//    
//    [super reloadData];
//}
//
//#pragma mark - UITableViewDelegate implementation
//
//#pragma mark - UITableViewDataSource implementation
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    int result = [self.bubbleSection count];
//    if (self.typingBubble != NSBubbleTypingTypeNobody) result++;
//    return result;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // This is for now typing bubble
//	if (section >= [self.bubbleSection count]) return 1;
//    
//    return [[self.bubbleSection objectAtIndex:section] count] + 1;
//}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    EXPBubbleData *data = [_dataObjectForBubbles bubbleTableView:self dataForRow:indexPath.row];
    return MAX(data.insets.top + data.view.frame.size.height + data.insets.bottom, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Standard bubble
    static NSString *cellId = @"tblBubbleCell";
    EXPSpecialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    EXPBubbleData *data = [_dataObjectForBubbles bubbleTableView:self dataForRow:indexPath.row];
    if (!cell) cell = [[EXPSpecialTableViewCell alloc] init];
    cell.data = data;
    return cell;
}

@end


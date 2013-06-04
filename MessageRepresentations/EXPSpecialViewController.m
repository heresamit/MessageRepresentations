//
//  EXPSpecialViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 23/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPSpecialViewController.h"
#import "EXPSpecialTableView.h"
#import "PerformanceMeasurer.h"
@interface EXPSpecialViewController ()
@property (nonatomic,strong) PerformanceMeasurer* pm;
@property (nonatomic, strong) NSMutableArray *dataForBubbles;
@property (nonatomic, strong) UIImage *avatar;

@end

@implementation EXPSpecialViewController

-(void) updateNavBar:(int)toDisplay
{
    self.navigationItem.title = [NSString stringWithFormat:@"%d",toDisplay];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
         //_pm = [[PerformanceMeasurer alloc] initWithObject:self];
        // Custom initialization
    }
    return self;
    
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
         //_pm = [[PerformanceMeasurer alloc] initWithObject:self];
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _avatar = [UIImage imageNamed:@"avatarPlaceHolder"];
    //UIImage *newImage = [image _imageScaledToSize:CGSizeMake(290, 390)                             interpolationQuality:1];
    _dataForBubbles = [[NSMutableArray alloc] init];
    for(id obj in _messages.messageArray)
    {
        [_dataForBubbles addObject:[EXPBubbleData dataWithText:[obj objectAtIndex:1] date:[NSDate dateWithTimeIntervalSinceNow:0] type:!([[obj objectAtIndex:0] boolValue]) withAvatar:_avatar]];
        
    }
    self.bubbleTableView.dataObjectForBubbles = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)rowsForBubbleTable:(EXPSpecialTableView *)tableView
{
    return [_dataForBubbles count];
}

- (EXPBubbleData *)bubbleTableView:(EXPSpecialTableView *)tableView dataForRow:(NSInteger)row
{
    return [_dataForBubbles objectAtIndex:row];
}

- (void)viewDidUnload {
    [self setBubbleTableView:nil];
    [super viewDidUnload];
}
@end

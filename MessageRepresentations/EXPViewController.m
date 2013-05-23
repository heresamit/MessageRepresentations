//
//  EXPViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 22/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPViewController.h"
#import "EXPFullyDrawnTableViewController.h"
#import "EXPFullyDrawnHeightsCachedViewController.h"
#import "EXPAppDataSource.h"
@interface EXPViewController ()
@property (nonatomic,strong) EXPAppDataSource* messages;
@end

@implementation EXPViewController
@synthesize messages = _messages;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _messages = [[EXPAppDataSource alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"fullyDrawnTableViewSegue"]){
        EXPFullyDrawnTableViewController *tvc = (EXPFullyDrawnTableViewController *)[segue destinationViewController];
        tvc.messages = _messages;
    }
    if([[segue identifier] isEqualToString:@"fullyDrawnHeightsCachedSegue"]){
        EXPFullyDrawnHeightsCachedViewController *tvc = (EXPFullyDrawnHeightsCachedViewController *)[segue destinationViewController];
        tvc.messages = _messages;
    }
    
}

@end

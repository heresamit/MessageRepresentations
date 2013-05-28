//
//  ViewController.m
//  ExtremelyFastMessageTable
//
//  Created by Amit Chowdhary on 24/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "ViewController.h"
#import "EFCellData.h"
#import "EFTableViewController.h"
#import "EFCustomView.h"

@interface ViewController ()
{
    NSMutableArray *dataArray;
}
@end

@implementation ViewController
- (void)parseData
{
    dataArray = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MessageFile" ofType:@"plist"];
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    UIImage *avatarImage1 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
    UIImage *avatarImage2 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
    for(NSArray *obj in tempArray)
    {
        if([obj[0] boolValue])
        {
            [dataArray addObject:[[EFCellData alloc] initWithText:obj[1] withType:readSentWithAvatar withImage:avatarImage1]];
        }
        else
        {
            [dataArray addObject:[[EFCellData alloc] initWithText:obj[1] withType:receivedWithAvatar withImage:avatarImage2]];
        }
        
            }
    //NSLog(@"%@",dataArray);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self parseData];
//    EFCustomView *abc = [[EFCustomView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 50) withType:2 withText:@"Hello" withTextFrameSize:CGSizeMake(60, 40)];
//    [abc setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:abc];
//	 Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([[segue identifier] isEqualToString:@"DrawnSegue"])
    {
        EFTableViewController *tvc = (EFTableViewController *)[segue destinationViewController];
        tvc.dataArray = dataArray;
    }
    
    
    
}

@end

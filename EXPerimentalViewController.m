//
//  EXPerimentalViewController.m
//  MessageRepresentations
//
//  Created by Amit Chowdhary on 30/05/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "EXPerimentalViewController.h"

@interface EXPerimentalViewController ()

@end

@implementation EXPerimentalViewController

- (void) handleHyperLinkOrNumberTouches: (UIButton *) sender
{
    
    NSString *obj = sender.titleLabel.text;
     NSLog(@"%@",obj);
    [[NSScanner scannerWithString:obj] scanInt:nil];
    if([obj hasPrefix:@"http://"] || [obj hasPrefix:@"www."] || [obj hasPrefix:@"https://"] || [obj hasPrefix:@"ftp://"])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: sender.titleLabel.text]];
   
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSString *imagePath = [[NSBundle mainBundle] resourcePath];
//    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
//    imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//
//    NSString *HTMLData = @"\n"
//    "<h1>Hello this is a test</h1>\n"
//    "<img src=\"avatarPlaceHolder.png\" alt=\"\" width=\"100\" height=\"100\" />";
//    
//    UIWebView *wv = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
//    [wv loadHTMLString:HTMLData baseURL:
//     [NSURL URLWithString:
//      [NSString stringWithFormat:@"file:/%@//",imagePath]
//      ]];
//    [self.view addSubview:wv];
    
    NSDictionary *emoticonDictionary = [[NSDictionary alloc]
                               initWithObjects:[NSArray arrayWithObjects:[UIImage imageNamed:@"happyEmoticon.png"],
                                                [UIImage imageNamed:@"sadEmoticon.png"],
                                                nil]
                               forKeys:[NSArray arrayWithObjects:@":)",@":(", nil]];
    
    EXPInsaneLabel *label = [[EXPInsaneLabel alloc] initWithEmoticonDictionary:emoticonDictionary withMaxTextWidth:300];
    label.delegate = self;
    UIView * temp = [label getViewForText:@":)  http://www.google.com 8988123123  This is a good label indeed! 22323 hello, wassup? :) :(   https://www.gmail.com"];
    
    temp.transform = CGAffineTransformMakeTranslation(20,100);
    [self.view addSubview:temp];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

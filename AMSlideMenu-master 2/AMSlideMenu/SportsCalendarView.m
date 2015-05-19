//
//  SportsCalendarView.m
//  AMSlideMenu
//
//  Created by Jacky Zou on 2/3/15.
//  Copyright (c) 2015 Artur Mkrtchyan. All rights reserved.
//

#import "SportsCalendarView.h"

@implementation SportsCalendarView
- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 80.0, 768.0, 1000.0)];
    NSURL *URL = [NSURL URLWithString:@"http://sports.rutgersprep.org/page/show/94674-calendar"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:URL];
    webView.delegate = self ;
    [webView loadRequest:requestObj];
    [self.view addSubview:webView];
    //a thing
}
@end

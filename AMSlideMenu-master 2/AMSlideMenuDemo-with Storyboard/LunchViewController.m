//
//  LunchViewController.m
//  RPSchedule
//
//  Created by Jacky Zou on 4/13/15.
//  Copyright (c) 2015 Rutgers Preparatory School. All rights reserved.
//

#import "LunchViewController.h"

@interface LunchViewController ()

@end

@implementation LunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 80.0, 768.0, 1000.0)];
    NSURL *URL = [NSURL URLWithString:@"http://www.sagedining.com/menus/rutgerspreparatory?view=daily"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:URL];
    webView.delegate = self ;
    [webView loadRequest:requestObj];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

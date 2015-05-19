//
//  ViewController.h
//  GetTop10Albums
//
//  Created by Jacky Zou on 11/18/14.
//  Copyright (c) 2014 Jacky Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)getData:(id)sender;


@end


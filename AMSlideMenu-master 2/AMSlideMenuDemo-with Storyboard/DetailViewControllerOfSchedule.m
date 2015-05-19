//
//  DetailViewController.m
//  GetTop10Albums
//
//  Created by Jacky Zou on 11/19/14.
//  Copyright (c) 2014 Jacky Zou. All rights reserved.
//

#import "DetailViewControllerOfSchedule.h"

@interface DetailViewControllerOfSchedule ()

@end

@implementation DetailViewControllerOfSchedule
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _SongName.text =  _DetailModal[0];
    
    _SongPrice.text = _DetailModalForPrice[0];
    
    _SongType.text = _DetailModalForType[0];
    
    /*NSURL * imageURL = [NSURL URLWithString: _DetailModalForPicture[0]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    _artwork.image = image;
  */
    
    self.navigationItem.title = _DetailModal[0];
    
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

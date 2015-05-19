//
//  TwitterViewController.h
//  MySocailPlatform
//
//  Created by Jacky Zou on 9/21/14.
//  Copyright (c) 2014 Jacky Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuVC.h"
#import "MainVC.h"
#import <Social/Social.h>

@interface ChangeProfileViewController :UIViewController<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) UIImage *originalImage;
@property (strong, nonatomic) LeftMenuVC *leftview;
@property (strong, nonatomic) MainVC *mainSlider;
- (IBAction)cancel:(id)sender;
- (IBAction)ok:(id)sender;



@end

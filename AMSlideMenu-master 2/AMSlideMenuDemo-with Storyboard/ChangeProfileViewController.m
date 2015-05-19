//
//  TwitterViewController.m
//  MySocailPlatform
//
//  Created by Jacky Zou on 9/21/14.
//  Copyright (c) 2014 Jacky Zou. All rights reserved.
//

#import "ChangeProfileViewController.h"

#import <MessageUI/MessageUI.h>

@interface ChangeProfileViewController ()
@property (strong, nonatomic) UIImage *image;// this is private
@end

@implementation ChangeProfileViewController
@synthesize imageView = _imageView;//create getter and setter


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
    // Do any additional setup after loading the view.
    self.imageView.userInteractionEnabled =YES;
    

    [self setUpView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpView
{
    //Add a gesture
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeImage:)];
    
    [self.imageView addGestureRecognizer:tgr];
    
    //update view
    [self updateView];
    
}

-(void) updateView
{
    BOOL sharingEnbled = self.image ? YES : NO;
    
    float sharingAlpha = sharingEnbled ? 1.0 : 0.5;
    
    NSLog(@"This is alpha: %g", sharingAlpha);
    
}

-(void) takeImage:(UITapGestureRecognizer *)tgr
{
    

    //Initialized Image Picker
    UIImagePickerController *ip = [[UIImagePickerController alloc] init];
    
    [ip setDelegate:self];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [ip setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [ip setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }
    
    
    //present view controller
    [self presentViewController:ip animated:YES completion:nil];
    
    
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    self.originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(self.originalImage)
    {
        self.imageView.image =
        self.originalImage;
        
        self.leftview.profilePhoto = self.originalImage;
 
        
        [self updateView];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setImage:(UIImage *)image
{
    if(_image != image)
    {
        _image = image;
        
        //Update Image view
        self.imageView.image = _image;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    // Get reference to the destination view controller
    UINavigationController *navigationController = segue.destinationViewController;
    LeftMenuVC *vc = [[navigationController viewControllers] objectAtIndex:0];
    [vc setPicture:self.originalImage];
    
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.view.backgroundColor = [UIColor yellowColor];
}




- (IBAction)cancel:(id)sender
{
  
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

    

}

- (IBAction)ok:(id)sender
{
      [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}
@end

//
//  SOLViewController.m
//  PresentingFun
//
//  Created by Jesse Wolff on 10/31/13.
//  Copyright (c) 2013 Soleares, Inc. All rights reserved.
//

#import "SOLBounceTransitionAnimator.h"
#import "SOLBounceViewController.h"
#import "SOLCollectionViewController.h"
#import "SOLDropTransitionAnimator.h"
#import "SOLDropViewController.h"
#import "SOLFoldTransitionAnimator.h"
#import "SOLFoldViewController.h"
#import "SOLOptions.h"
#import "SOLOptionsTransitionAnimator.h"
#import "SOLOptionsViewController.h"
#import "SOLSlideTransitionAnimator.h"
#import "SOLSlideViewController.h"
#import "SOLViewController.h"

// Table view sections
typedef NS_ENUM(NSInteger, TableViewSection) {
    TableViewSectionBasic,
    TableViewSectionSpring,
    TableViewSectionKeyframe,
    TableViewSectionCollectionView,
    TableViewSectionDynamics
    //change
};

// Segue Ids

static NSString * const kSegueDropDismiss1    = @"dropDismiss";
static NSString * const kSegueDropModal1      = @"dropModal";


@interface SOLViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
@end

@implementation SOLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Setup the tableview background view
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpeg"]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [backgroundView addSubview:imageView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectZero];
    maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    maskView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
    [backgroundView addSubview:maskView];
    
    //self.tableView.backgroundView = backgroundView;
}

/*
 Prepare for segue
 
 navigationController.delegate:
 We need to set the UINavigationControllerDelegate everytime for push transitions.
 This is necessary because this VC presents multiple VCs, some with custom transitions
 (Options, Slide, Bounce, Fold, Drop) and one with a standard transition (Flow 1).
 The delegate is set to self for the custom transitions so that they work with
 the navigation controller. The delegate is set to nil for the standard transition
 so that the default interactive pop transition works.
 
 modalPresentationStyle:
 Specify UIModalPresentationCustom for transitions where the source VC should
 stay in the view hierarchy after the transition is complete (Options, Drop).
 For the other cases (Slide, Bounce, Fold) we don't set it which defaults it
 to UIModalPresentationFullScreen.
 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Drop - modal
     if ([segue.identifier isEqualToString:kSegueDropModal1]) {
        UIViewController *toVC = segue.destinationViewController;
        toVC.modalPresentationStyle = UIModalPresentationCustom;
        toVC.transitioningDelegate = self;
    }
    
    [super prepareForSegue:segue sender:sender];
}

#pragma mark - UITableViewDelegate

/*
 Push/Present the appropriate view controller when a cell is selected.
 
 For a static table view you would typically connect the segues directly
 to the table view cells and not need this method. Because there's more
 than one possible segue per cell (push or modal) we need to trigger the
 segue manually.
 
 */

#pragma mark - UIViewControllerTransitioningDelegate

/*
 Called when presenting a view controller that has a transitioningDelegate
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    id<UIViewControllerAnimatedTransitioning> animationController;
    
    
    // Drop
    
        SOLDropTransitionAnimator *animator = [[SOLDropTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = 1.5;
        animationController = animator;
    
    
    return animationController;
}

/*
 Called when dismissing a view controller that has a transitioningDelegate
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id<UIViewControllerAnimatedTransitioning> animationController1;
    
       // Drop
     if ([dismissed isKindOfClass:[SOLDropViewController class]]) {
        SOLDropTransitionAnimator *animator = [[SOLDropTransitionAnimator alloc] init];
        animator.appearing = NO;
        animator.duration = 1.5;
        animationController1 = animator;
         //hello this is a test
         NSLog(@"hello");
    }
    
    return animationController1;
}

#pragma mark - Storyboard unwinding

/*
 Unwind segue action called to dismiss the Options and Drop view controllers and
 when the Slide, Bounce and Fold view controllers are dismissed with a single tap.
 
 Normally an unwind segue will pop/dismiss the view controller but this doesn't happen
 for custom modal transitions so we have to manually call dismiss.
 */
@end

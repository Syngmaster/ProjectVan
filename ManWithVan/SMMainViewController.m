//
//  SMMainViewController.m
//  SlideOutMenu
//
//  Created by Syngmaster on 18/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMainViewController.h"
#import "SMSideMenuViewController.h"
#import "SMSignInViewController.h"
#import "SMAboutUsViewController.h"
#import "SMRequestCallbackViewController.h"
#import "SMSocialLinksViewController.h"
#import "SMReviewsViewController.h"
#import "SMGalleryViewController.h"
#import "SMMovingTypeViewController.h"

#import "SMPresentMenuAnimator.h"
#import "SMDismissMenuAnimator.h"
#import "SMCustomNavigationBar.h"
#import "SMInteractor.h"


typedef NS_ENUM(NSInteger, Direction) {
    
    DirectionUp,
    DirectionDown,
    DirectionLeft,
    DirectionRight
    
};


@interface SMMainViewController () <UIViewControllerTransitioningDelegate, SMSideMenuDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) SMInteractor *interactor;

@end

@implementation SMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.delegate = self;
    UIScreenEdgePanGestureRecognizer *panRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    panRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:panRecognizer];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";

    self.interactor = [[SMInteractor alloc] init];
    
}

- (IBAction)openMenuAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"showMenu" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showMenu"]) {
        
        SMSideMenuViewController *menuVC = segue.destinationViewController;
        menuVC.transitioningDelegate = self;
        menuVC.delegate = self;
        menuVC.interactor = self.interactor;
    }

}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)sender {
    CGFloat progress = [sender translationInView:self.view].x / (self.view.frame.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.interactor.hasStarted = YES;
        [self performSegueWithIdentifier:@"showMenu" sender:nil];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.interactor updateInteractiveTransition:progress];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        self.interactor.hasStarted = NO;
        if (progress > 0.4) {
            [self.interactor finishInteractiveTransition];
        }
        else {
            [self.interactor cancelInteractiveTransition];
        }
    } else if (sender.state == UIGestureRecognizerStateCancelled) {
        self.interactor.hasStarted = NO;
        [self.interactor cancelInteractiveTransition];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[SMPresentMenuAnimator alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[SMDismissMenuAnimator alloc] init];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactor.hasStarted ? self.interactor : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactor.hasStarted ? self.interactor : nil;
}

#pragma mark - SMSideMenuDelegate

- (void)viewController:(SMSideMenuViewController *)viewController isDismissedWithData:(NSInteger) passedData {
    
    /*if (passedData == 1) {
        
        SMSignInViewController *signVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSignInViewController"];
        [self.navigationController pushViewController:signVC animated:NO];
        
    } else*/ if (passedData == 1) {
        
        SMAboutUsViewController *aboutUs = [self.storyboard instantiateViewControllerWithIdentifier:@"SMAboutUsViewController"];
        [self.navigationController pushViewController:aboutUs animated:NO];
        
    } else if (passedData == 2) {
        
        SMRequestCallbackViewController *requestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMRequestCallbackViewController"];
        [self.navigationController pushViewController:requestVC animated:NO];
        
    } else if (passedData == 3) {
        
        SMReviewsViewController *reviewsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMReviewsViewController"];
        [self.navigationController pushViewController:reviewsVC animated:NO];
        
    } else if (passedData == 4) {
        
        SMGalleryViewController *galleryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMGalleryViewController"];
        [self.navigationController pushViewController:galleryVC animated:NO];

    } else if (passedData == 5) {
        
        SMSocialLinksViewController *socialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSocialLinksViewController"];
        [self.navigationController pushViewController:socialVC animated:NO];
        
    } else if (passedData == 6) {
        
        SMMovingTypeViewController *movingTypeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMMovingTypeViewController"];
        [self.navigationController pushViewController:movingTypeVC animated:NO];
    }
}



@end

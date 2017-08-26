//
//  SMSideMenusParentViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSideMenusParentViewController.h"
#import "SMSideMenuViewController.h"

#import "SMMainViewController.h"
#import "SMAboutUsViewController.h"
#import "SMRequestCallbackViewController.h"
#import "SMSignInViewController.h"
#import "SMSocialLinksViewController.h"
#import "SMReviewsViewController.h"
#import "SMGalleryViewController.h"
#import "SMMovingTypeViewController.h"

#import "SMPresentMenuAnimator.h"
#import "SMDismissMenuAnimator.h"
#import "SMInteractor.h"

@interface SMSideMenusParentViewController () <UIViewControllerTransitioningDelegate, SMSideMenuDelegate>

@property (strong, nonatomic) SMInteractor *interactor;

@end

@implementation SMSideMenusParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScreenEdgePanGestureRecognizer *panRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    panRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:panRecognizer];
    self.interactor = [[SMInteractor alloc] init];
}

- (void)showMenu {
    
    SMSideMenuViewController *sideMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSideMenuViewController"];
    sideMenuVC.transitioningDelegate = self;
    sideMenuVC.delegate = self;
    sideMenuVC.interactor = self.interactor;
    [self presentViewController:sideMenuVC animated:YES completion:nil];
    
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)sender {
    CGFloat progress = [sender translationInView:self.view].x / (self.view.frame.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.interactor.hasStarted = YES;
        [self showMenu];
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
    
    if (passedData == 0) {
        
        SMMainViewController *mainInVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMMainViewController"];
        [self presentVC:mainInVC];
        
    } /*else if (passedData == 1) {
        
        SMSignInViewController *signInVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSignInViewController"];
        [self presentVC:signInVC];
        
    }*/ else if (passedData == 1) {
        
        SMAboutUsViewController *aboutUs = [self.storyboard instantiateViewControllerWithIdentifier:@"SMAboutUsViewController"];
        [self presentVC:aboutUs];
        
    } else if (passedData == 2) {
        
        SMRequestCallbackViewController *requestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMRequestCallbackViewController"];
        [self presentVC:requestVC];
        
    } else if (passedData == 3) {
        
        SMReviewsViewController *reviewsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMReviewsViewController"];
        [self presentVC:reviewsVC];
        
    } else if (passedData == 4) {
        
        SMGalleryViewController *galleryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMGalleryViewController"];
        [self presentVC:galleryVC];
        
    } else if (passedData == 5) {
        
        SMSocialLinksViewController *socialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSocialLinksViewController"];
        [self presentVC:socialVC];
        
    } else if (passedData == 6) {
        
        SMMovingTypeViewController *movingTypeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMMovingTypeViewController"];
        [self presentVC:movingTypeVC];
    }
    
}

- (void)presentVC:(UIViewController *) viewController {
    
    UINavigationController *navVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    [self.navigationController popViewControllerAnimated:NO];
    [navVC pushViewController:viewController animated:NO];
}



@end

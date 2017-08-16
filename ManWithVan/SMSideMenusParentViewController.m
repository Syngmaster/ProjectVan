//
//  SMSideMenusParentViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSideMenusParentViewController.h"
#import "SMSideMenuViewController.h"
#import "SMAboutUsViewController.h"
#import "SMRequestCallbackViewController.h"
#import "SMSignInViewController.h"
#import "SMMainViewController.h"
#import "SMSocialLinksViewController.h"

#import "SMPresentMenuAnimator.h"
#import "SMDismissMenuAnimator.h"

@interface SMSideMenusParentViewController () <UIViewControllerTransitioningDelegate, SMSideMenuDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation SMSideMenusParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScreenEdgePanGestureRecognizer *panRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    panRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:panRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.interactiveTransition = nil;
}

- (void)showMenu {
    
    SMSideMenuViewController *sideMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSideMenuViewController"];
    sideMenuVC.transitioningDelegate = self;
    sideMenuVC.delegate = self;
    sideMenuVC.interactiveTransition = self.interactiveTransition;
    [self presentViewController:sideMenuVC animated:YES completion:nil];
    
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)sender {
    CGFloat progress = [sender translationInView:self.view].x / (self.view.frame.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self showMenu];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.interactiveTransition updateInteractiveTransition:progress];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.15) {
            [self.interactiveTransition finishInteractiveTransition];
        }
        else {
            [self.interactiveTransition cancelInteractiveTransition];
        }
        //self.interactiveTransition = nil;
    } else if (sender.state == UIGestureRecognizerStateCancelled) {
        [self.interactiveTransition cancelInteractiveTransition];
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
    return self.interactiveTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition;
}


#pragma mark - SMSideMenuDelegate

- (void)viewController:(SMSideMenuViewController *)viewController isDismissedWithData:(NSInteger) passedData {
    NSLog(@"parent1 - %i", (int)passedData);
    NSLog(@"%@", viewController);
    
    if (passedData == 0) {
        
        SMMainViewController *mainInVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMMainViewController"];
        UINavigationController *navVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
        [self.navigationController popViewControllerAnimated:NO];
        [navVC pushViewController:mainInVC animated:NO];
        
    } else if (passedData == 1) {
        
        SMSignInViewController *signInVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSignInViewController"];
         UINavigationController *navVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
         [self.navigationController popViewControllerAnimated:NO];
         [navVC pushViewController:signInVC animated:NO];
        
    } else if (passedData == 2) {
        
        SMAboutUsViewController *aboutUs = [self.storyboard instantiateViewControllerWithIdentifier:@"SMAboutUsViewController"];
        UINavigationController *navVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
        [self.navigationController popViewControllerAnimated:NO];
        [navVC pushViewController: aboutUs animated:NO];
        
    } else if (passedData == 3) {
        
        SMRequestCallbackViewController *requestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMRequestCallbackViewController"];
        UINavigationController *navVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
        [self.navigationController popViewControllerAnimated:NO];
        [navVC pushViewController:requestVC animated:NO];
        
    } else if (passedData == 4) {
        

        
    } else if (passedData == 5) {
        

        
    } else if (passedData == 6) {
        
        SMSocialLinksViewController *socialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSocialLinksViewController"];
        UINavigationController *navVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
        [self.navigationController popViewControllerAnimated:NO];
        [navVC pushViewController:socialVC animated:NO];
        
    }
    
    NSLog(@"parent2 - %i", (int)passedData);


    
    
    
}





@end

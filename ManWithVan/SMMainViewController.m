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

#import "SMPresentMenuAnimator.h"
#import "SMDismissMenuAnimator.h"
#import "SMCustomNavigationBar.h"


typedef NS_ENUM(NSInteger, Direction) {
    
    DirectionUp,
    DirectionDown,
    DirectionLeft,
    DirectionRight
    
};


@interface SMMainViewController () <UIViewControllerTransitioningDelegate, SMSideMenuDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactiveTransition;


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

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.interactiveTransition = nil;
}


- (IBAction)openMenuAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"showMenu" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showMenu"]) {
        
        SMSideMenuViewController *menuVC = segue.destinationViewController;
        menuVC.transitioningDelegate = self;
        menuVC.delegate = self;
        menuVC.interactiveTransition = self.interactiveTransition;
        
    }

}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)sender {
    CGFloat progress = [sender translationInView:self.view].x / (self.view.frame.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self performSegueWithIdentifier:@"showMenu" sender:nil];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.interactiveTransition updateInteractiveTransition:progress];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.25) {
            [self.interactiveTransition finishInteractiveTransition];
            //self.interactiveTransition = nil;
        }
        else {
            [self.interactiveTransition cancelInteractiveTransition];
        }
        //self.interactiveTransition = nil;
    } else if (sender.state == UIGestureRecognizerStateCancelled) {
        [self.interactiveTransition cancelInteractiveTransition];
    }
}


#pragma mark - UINavigationControllerDelegate


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return  [[SMPresentMenuAnimator alloc] init];
    } else if (operation == UINavigationControllerOperationPop) {
        return  [[SMDismissMenuAnimator alloc] init];
    }
    return nil;
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
    NSLog(@"%i", (int)passedData);
    if (passedData == 0) {
        
        
    } else if (passedData == 1) {
        
        SMSignInViewController *signVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSignInViewController"];
        [self.navigationController pushViewController:signVC animated:NO];
        
    } else if (passedData == 2) {
        
        SMAboutUsViewController *aboutUs = [self.storyboard instantiateViewControllerWithIdentifier:@"SMAboutUsViewController"];
        [self.navigationController pushViewController:aboutUs animated:NO];
        
    } else if (passedData == 3) {
        
        SMRequestCallbackViewController *requestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMRequestCallbackViewController"];
        [self.navigationController pushViewController:requestVC animated:NO];
        
    } else if (passedData == 4) {
        

        
    } else if (passedData == 5) {
        

        
    } else if (passedData == 6) {
        
        SMSocialLinksViewController *socialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSocialLinksViewController"];
        [self.navigationController pushViewController:socialVC animated:NO];
        
    }
}



@end

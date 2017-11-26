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


@interface SMMainViewController ()

@end

@implementation SMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";

}

- (IBAction)getStartedAction:(UIButton *)sender {
    
    self.tabBarController.selectedIndex = 2;
    
}


@end

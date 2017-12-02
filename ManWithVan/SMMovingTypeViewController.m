//
//  SMMovingTypeViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 28/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMovingTypeViewController.h"
#import "SMGetQuoteViewController.h"


typedef NS_ENUM (NSInteger, MovingType) {
 
    MovingTypeSmall,
    MovingTypeBig,
    MovingTypeHeavy
    
};

@interface SMMovingTypeViewController ()

@property (nonatomic, weak) NSString *test;

@end

@implementation SMMovingTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Type of moving";

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_button_img.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setCentralButtonHidden:NO];
}

- (void)setCentralButtonHidden:(BOOL)isHidden {
    
    UITabBarController *rootVC = (UITabBarController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    
    for (UIView *view in rootVC.view.subviews) {
        if (view.tag == 1) {
            UIButton *button = (UIButton *)view;
            button.hidden = isHidden ? YES : NO;
            button.enabled = isHidden ? NO : YES;
            isHidden? [rootVC.view insertSubview:view atIndex:0]: [rootVC.view bringSubviewToFront:view];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    
    SMGetQuoteViewController *dvc = segue.destinationViewController;

    switch (sender.tag) {
        case MovingTypeSmall:
            dvc.movingType = MovingTypeSmall;
            break;
        case MovingTypeBig:
            dvc.movingType = MovingTypeBig;
            break;
        case MovingTypeHeavy:
            dvc.movingType = MovingTypeHeavy;
            break;

    }
    [self setCentralButtonHidden:YES];
    
}



@end

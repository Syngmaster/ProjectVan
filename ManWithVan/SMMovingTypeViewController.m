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
    MovingTypeBig
    
};

@interface SMMovingTypeViewController ()

@end

@implementation SMMovingTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Type of moving";

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    
    if (sender.tag == MovingTypeSmall) {
        if ([segue.identifier isEqualToString:@"small"]) {
            SMGetQuoteViewController *dvc = segue.destinationViewController;
            dvc.isSmallMoving = YES;
        }
    } else {
        if ([segue.identifier isEqualToString:@"big"]) {
            SMGetQuoteViewController *dvc = segue.destinationViewController;
            dvc.isSmallMoving = NO;
        }
    }
    
}



@end

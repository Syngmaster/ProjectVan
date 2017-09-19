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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
}



@end

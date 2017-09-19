//
//  SMLocationSettingsViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 28/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMLocationSettingsViewController.h"
#import "SMSetUpLocationData.h"
#import "SMDataManager.h"

@interface SMLocationSettingsViewController ()

@end

@implementation SMLocationSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Location settings";
    self.buildingTypeSegment.tintColor = [SMDataManager sharedInstance].baseColor;
    self.floorLabel.text = [NSString stringWithFormat:@"%i",(int)self.locationData.pickUpFloor];
    self.buildingTypeSegment.selectedSegmentIndex = self.locationData.buildingType;
    
    if (self.buildingTypeSegment.selectedSegmentIndex == 0) {
        
        self.minusButton.enabled = NO;
        self.minusButton.alpha = 0.5;
        
        self.plusButton.enabled = NO;
        self.plusButton.alpha = 0.5;
        
        self.liftButton.enabled = NO;
        self.liftButton.alpha = 0.5;
        
        self.floorLabel.text = @"";
        
    } else {
        
        self.floorLabel.text = [NSString stringWithFormat:@"%i",(int)self.locationData.pickUpFloor];

        if (self.locationData.liftAvailable) {
            self.tickImageView.image = [UIImage imageNamed:@"Tick.png"];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions


- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)buildingTypeAction:(UISegmentedControl *)sender {
    
    self.locationData.buildingType = sender.selectedSegmentIndex;
    
    if (sender.selectedSegmentIndex == 0) {
        
        self.minusButton.enabled = NO;
        self.minusButton.alpha = 0.5;

        self.plusButton.enabled = NO;
        self.plusButton.alpha = 0.5;

        self.liftButton.enabled = NO;
        self.liftButton.alpha = 0.5;
        
        self.floorLabel.text = @"";
        self.locationData.pickUpFloor = 0;
        self.locationData.liftAvailable = NO;
        self.tickImageView.image = [UIImage imageNamed:@"Tick_inactive.png"];

    } else {
        
        self.floorLabel.alpha = 1.0;
        
        self.minusButton.enabled = YES;
        self.minusButton.alpha = 1.0;
        
        self.plusButton.enabled = YES;
        self.plusButton.alpha = 1.0;
        
        self.liftButton.enabled = YES;
        self.liftButton.alpha = 1.0;
        
        self.floorLabel.text = [NSString stringWithFormat:@"%i", (int)self.locationData.pickUpFloor];
    }
    
}
- (IBAction)floorChangedAction:(UIButton *)sender {
    
    NSInteger i = self.locationData.pickUpFloor;
    
    if (sender.tag == 0) {
        
        if (i > 0) {
            
            i = i - 1;
            self.locationData.pickUpFloor = i;
            self.floorLabel.text = [NSString stringWithFormat:@"%i", (int)self.locationData.pickUpFloor];
        }
        
    } else {
        
        if (i < 10) {
            
            i = i + 1;
            self.locationData.pickUpFloor = i;
            self.floorLabel.text = [NSString stringWithFormat:@"%i", (int)self.locationData.pickUpFloor];
        }
    }
    
}

- (IBAction)liftAvailableAction:(UIButton *)sender {
    
    if (!self.locationData.liftAvailable) {
        
        self.locationData.liftAvailable = YES;
        self.tickImageView.image = [UIImage imageNamed:@"Tick.png"];
        
    } else {
        
        self.locationData.liftAvailable = NO;
        self.tickImageView.image = [UIImage imageNamed:@"Tick_inactive.png"];
    }
    
}

- (IBAction)saveAction:(UIButton *)sender {
    
    [self.delegate viewController:self dismissedWithLocationData:self.locationData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

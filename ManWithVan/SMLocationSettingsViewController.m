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

    self.floorLabel.text = [NSString stringWithFormat:@"%i",(int)self.locationData.pickUpFloor];
    self.buildingTypeSegment.selectedSegmentIndex = self.locationData.buildingType;
    
    if (self.buildingTypeSegment.selectedSegmentIndex == 0) {
        
        [self setButtonsEnabled:NO];
        
        self.floorLabel.text = @"";
        
    } else {
        
        self.floorLabel.text = [NSString stringWithFormat:@"%i",(int)self.locationData.pickUpFloor];

        if (self.locationData.liftAvailable) {
            [self setLiftButtonActive:YES];
        }
    }

}

- (void)setButtonsEnabled:(BOOL)isEnabled {
    if (isEnabled) {
        self.minusButton.enabled = YES;
        self.minusButton.alpha = 1.0;
        
        self.plusButton.enabled = YES;
        self.plusButton.alpha = 1.0;
        
        self.liftButton.enabled = YES;
        self.liftButton.alpha = 1.0;
    } else {
        self.minusButton.enabled = NO;
        self.minusButton.alpha = 0.5;
        
        self.plusButton.enabled = NO;
        self.plusButton.alpha = 0.5;
        
        self.liftButton.enabled = NO;
        self.liftButton.alpha = 0.5;
    }
}

- (void)setLiftButtonActive:(BOOL)isActive {
    if (isActive) {
        self.liftButton.backgroundColor = [SMDataManager sharedInstance].baseColor;
        [self.liftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.liftButton.layer.borderColor = [UIColor clearColor].CGColor;
    } else {
        self.liftButton.backgroundColor = [UIColor whiteColor];
        [self.liftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.liftButton.layer.borderColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0].CGColor;
    }
}

#pragma mark - Actions


- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)buildingTypeAction:(UISegmentedControl *)sender {
    
    self.locationData.buildingType = sender.selectedSegmentIndex;
    
    if (sender.selectedSegmentIndex == 0) {
        
        [self setButtonsEnabled:NO];
        
        self.floorLabel.text = @"";
        self.locationData.pickUpFloor = 0;
        self.locationData.liftAvailable = NO;
        [self setLiftButtonActive:NO];

    } else {
        
        self.floorLabel.alpha = 1.0;
        [self setButtonsEnabled:YES];
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
        [self setLiftButtonActive:YES];
        
    } else {
        
        self.locationData.liftAvailable = NO;
        [self setLiftButtonActive:NO];

    }
    
}


- (IBAction)saveAction:(UIButton *)sender {
    
    [self.delegate viewController:self dismissedWithLocationData:self.locationData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

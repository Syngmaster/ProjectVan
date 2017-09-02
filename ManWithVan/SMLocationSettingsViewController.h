//
//  SMLocationSettingsViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 28/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMLocationSettingsViewController, SMSetUpLocationData;

@protocol SMLocationSettingsDelegate <NSObject>

- (void)viewController:(SMLocationSettingsViewController *)viewController dismissedWithLocationData:(SMSetUpLocationData *)locationData;

@end

@interface SMLocationSettingsViewController : UIViewController

@property (weak, nonatomic) id <SMLocationSettingsDelegate> delegate;
@property (strong, nonatomic) SMSetUpLocationData *locationData;

@property (weak, nonatomic) IBOutlet UISegmentedControl *buildingTypeSegment;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageView;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *liftButton;

- (IBAction)buildingTypeAction:(UISegmentedControl *)sender;
- (IBAction)floorChangedAction:(UIButton *)sender;
- (IBAction)liftAvailableAction:(UIButton *)sender;
- (IBAction)saveAction:(UIButton *)sender;
- (IBAction)cancelAction:(UIButton *)sender;


@end

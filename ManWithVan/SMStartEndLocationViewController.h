//
//  SMStartEndLocationViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMSetUpLocationData, SMStartEndLocationViewController, SMQuoteData;

@protocol SMStartEndLocationDelegate <NSObject>

- (void)viewController:(SMStartEndLocationViewController *)viewController dismisssedWithData:(SMSetUpLocationData *)data;

@end


@interface SMStartEndLocationViewController : UIViewController

@property (strong, nonatomic) SMQuoteData *quote;
@property (weak, nonatomic) id <SMStartEndLocationDelegate> delegate;

// textField for setting up an address
@property (weak, nonatomic) IBOutlet UITextField *houseApartmentTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *countyTextField;


- (IBAction)mapLocationAction:(UIButton *)sender;

- (IBAction)buildingTypeAction:(UIButton *)sender;

// image views for building type
@property (weak, nonatomic) IBOutlet UIImageView *houseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *apartmentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *otherImageView;


@property (weak, nonatomic) IBOutlet UITextField *pickUpFloorTextField;
// lift availability

- (IBAction)liftAvailableAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *liftImageView;
- (IBAction)saveAction:(UIButton *)sender;

@end

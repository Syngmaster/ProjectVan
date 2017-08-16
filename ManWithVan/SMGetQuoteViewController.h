//
//  SMGetQuoteTableViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMGetQuoteViewController : UIViewController

@property (assign, nonatomic) BOOL isSmallMoving;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *addInformationTextField;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)twoPeopleAction:(UIButton *)sender;
- (IBAction)addPhotoAction:(UIButton *)sender;
- (IBAction)startLocationAction:(UIButton *)sender;
- (IBAction)endLocationButton:(UIButton *)sender;
- (IBAction)getQuoteAction:(UIButton *)sender;

@end

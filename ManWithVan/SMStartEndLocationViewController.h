//
//  SMStartEndLocationViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMQuoteData;

@interface SMStartEndLocationViewController : UIViewController

@property (strong, nonatomic) SMQuoteData *quote;

@property (weak, nonatomic) IBOutlet UITextField *locationFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationToTextField;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageView;
@property (weak, nonatomic) IBOutlet UITextField *addInfoTextField;


- (IBAction)showMapAction:(UIButton *)sender;
- (IBAction)showSettingsAction:(UIButton *)sender;
- (IBAction)twoPeopleAction:(UIButton *)sender;
- (IBAction)calculateQuoteAction:(UIButton *)sender;


@end

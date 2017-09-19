//
//  SMStartEndLocationViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#import "SMStartEndLocationViewController.h"
#import "SMLocationSettingsViewController.h"
#import "SMMapViewController.h"
#import "SMYourQuoteViewController.h"
#import "SMRequestCallbackViewController.h"

#import "SMDataManager.h"
#import "SMQuoteData.h"
#import "SMSetUpLocationData.h"
#import "SMLocationAddress.h"

#import "SMCustomActivityIndicator.h"
#import "SMCustomNavigationBar.h"
#import "SMCustomNavBarWithoutBtn.h"


@interface SMStartEndLocationViewController () <UITextFieldDelegate, SMLocationSettingsDelegate, SMMapViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) SMSetUpLocationData *locationData;
@property (strong, nonatomic) SMLocationAddress *address;

@end

@implementation SMStartEndLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";
    self.navigationItem.title = @"Set up location";

    SMSetUpLocationData *startLocationData = [[SMSetUpLocationData alloc] init];
    SMSetUpLocationData *endLocationData = [[SMSetUpLocationData alloc] init];

    self.quote.startLocation = startLocationData;
    self.quote.endLocation = endLocationData;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.quote.isStartLocation) {
        self.locationFromTextField.text = self.quote.startLocation.fullAddress;
    } else {
        self.locationToTextField.text = self.quote.endLocation.fullAddress;
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:self.locationFromTextField]) {
        self.quote.startLocation.fullAddress = textField.text;
    } else if ([textField isEqual:self.locationToTextField]) {
        self.quote.endLocation.fullAddress = textField.text;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  {
    
    [textField resignFirstResponder];

    return YES;
}

#pragma mark - SMLocationSettingsDelegate

- (void)viewController:(SMLocationSettingsViewController *)viewController dismissedWithLocationData:(SMSetUpLocationData *)locationData {
     
    if (self.quote.isStartLocation == YES) {
        self.quote.startLocation = locationData;
    } else {
        self.quote.endLocation = locationData;
    }
}

#pragma mark - SMMapViewDelegate

- (void)viewController:(SMMapViewController *)viewController dismissedWithData:(SMLocationAddress *)data {
    
    if (data) {
        self.address = data;
        
        if (self.quote.isStartLocation) {
            self.quote.startLocation.fullAddress = data.fullAddress;
        } else {
            self.quote.endLocation.fullAddress = data.fullAddress;
        }
        
    } else {
        [self noConnectionAlert];
    }
    
}

- (void)noConnectionAlert {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please check your internet connection!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:okAction];
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark - prepare for segue methods;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SMMapViewController *dvc = segue.destinationViewController;
    dvc.delegate = self;
    
}

#pragma mark - Actions

- (IBAction)showMapAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        self.quote.isStartLocation = YES;
    } else {
        self.quote.isStartLocation = NO;
    }
    [self performSegueWithIdentifier:@"showMap" sender:nil];
    
}

- (IBAction)showSettingsAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        self.quote.isStartLocation = YES;
    } else {
        self.quote.isStartLocation = NO;
    }
    
    SMLocationSettingsViewController *locationSettingsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMLocationSettingsViewController"];
    locationSettingsVC.delegate = self;
    if (sender.tag == 0) {
        locationSettingsVC.locationData = self.quote.startLocation;
    } else {
        locationSettingsVC.locationData = self.quote.endLocation;
    }
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithNavigationBarClass:[SMCustomNavBarWithoutBtn class] toolbarClass:nil];
    [navVC setViewControllers:@[locationSettingsVC]];
    
    [self presentViewController:navVC animated:YES completion:nil];
    
}

- (IBAction)twoPeopleAction:(UIButton *)sender {
    
    if (!self.quote.twoPeople) {
        
        self.quote.twoPeople = YES;
        self.tickImageView.image = [UIImage imageNamed:@"Tick.png"];
        
    } else {
        
        self.quote.twoPeople = NO;
        self.tickImageView.image = [UIImage imageNamed:@"Tick_inactive.png"];
    }
    
}

- (IBAction)calculateQuoteAction:(UIButton *)sender {
    
    self.quote.startLocation.fullAddress = self.locationFromTextField.text;
    self.quote.endLocation.fullAddress = self.locationToTextField.text;
    self.quote.addInfoText = self.addInfoTextField.text;
    
    SMCustomActivityIndicator *ind = [[SMCustomActivityIndicator alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:ind];
    
    [[SMDataManager sharedInstance] calculationOfQuote:self.quote onComplete:^(NSInteger price, NSError *error) {
        
        [ind removeFromSuperview];
        
        if (!error) {
            
            if (price != 0) {
                
                self.quote.price = price;
                
                SMYourQuoteViewController *yourQuoteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMYourQuoteViewController"];
                yourQuoteVC.quote = self.quote;
                
                [self presentViewController:yourQuoteVC animated:YES completion:nil];
                
            } else {
                
                NSString *alertTitle = @"Warning!";
                NSString *alertMessage = @"Please set up start and end location";
                [self raiseAlertWithTitle:alertTitle message:alertMessage andErrorCode:0];
                
            }
            
        } else {
            
            if (error.code == 8 || error.code == 4) {
                
                NSString *alertTitle = @"Warning!";
                NSString *alertMessage = @"Sorry, we are unable to calculate the quote at the moment. \nPlease check your location addresses.";
                [self raiseAlertWithTitle:alertTitle message:alertMessage andErrorCode:error.code];
                
            } else {
                
                NSString *alertTitle = @"Error";
                NSString *alertMessage = @"Sorry, we unable to calculate the quote. \n Please check your internet connection. \n Alternatively you can either request a callback or call us directly";
                [self raiseAlertWithTitle:alertTitle message:alertMessage andErrorCode:error.code];
                
            }
        }
        
    }];
    
}

- (void)raiseAlertWithTitle:(NSString *) title message:(NSString *) message andErrorCode:(NSInteger) errorCode  {
    
    if (errorCode == 2 || errorCode == 8) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *callbackAction = [UIAlertAction actionWithTitle:@"Callback" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            SMRequestCallbackViewController *requestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMRequestCallbackViewController"];
            UINavigationController *navVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
            [self.navigationController popViewControllerAnimated:NO];
            [navVC pushViewController:requestVC animated:NO];
            
        }];
        UIAlertAction *callUsAction = [UIAlertAction actionWithTitle:@"Call Us" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0851119555"]];
                
            } else {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0851119555"] options:@{} completionHandler:nil];
            }
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [controller addAction:callUsAction];
        [controller addAction:callbackAction];
        [self presentViewController:controller animated:YES completion:nil];
        
    } else {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
}

@end

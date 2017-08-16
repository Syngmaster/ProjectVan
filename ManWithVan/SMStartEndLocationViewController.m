//
//  SMStartEndLocationViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//


#import "SMStartEndLocationViewController.h"
#import "SMFloorPickerViewController.h"
#import "SMMapViewController.h"

#import "SMQuoteData.h"
#import "SMSetUpLocationData.h"
#import "SMLocationAddress.h"
#import "SMCustomNavigationBar.h"


@interface SMStartEndLocationViewController () <UITextFieldDelegate, UIPopoverPresentationControllerDelegate, SMFloorPickerDelegate, SMMapViewDelegate>

@property (strong, nonatomic) SMSetUpLocationData *locationData;
@property (strong, nonatomic) SMLocationAddress *address;

@end

@implementation SMStartEndLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.locationData) {
        
        if ((!self.quote.startLocation && self.quote.isStartLocation) || (!self.quote.endLocation && !self.quote.isStartLocation)) {
            
            SMSetUpLocationData *locationData = [[SMSetUpLocationData alloc] init];
            self.locationData = locationData;
            self.pickUpFloorTextField.text = locationData.pickUpFloor;
            
        } else {
            
            if (self.quote.startLocation && self.quote.isStartLocation) {
                
                [self setUpViewWith:self.quote.startLocation];

            } else if (self.quote.endLocation && !self.quote.isStartLocation) {
                
                [self setUpViewWith:self.quote.endLocation];
            }
        }
        
    } else {
        
        if (self.address) {
            
            self.houseApartmentTextField.text = self.address.houseApartmentNumber;
            self.streetTextField.text = self.address.streetName;
            self.cityTextField.text = self.address.cityName;
            self.countyTextField.text = self.address.countyName;
            
        } else {
            
            [self updateTextFieldsWithData:self.locationData];
        }
    }
}

- (void)setUpViewWith:(SMSetUpLocationData *) data {
    
    SMSetUpLocationData *locationData = [[SMSetUpLocationData alloc] init];
    self.locationData = locationData;
    [self updateTextFieldsWithData:data];
    
    UIImage *tickActive = [UIImage imageNamed:@"Tick.png"];
    UIImage *tickInactive = [UIImage imageNamed:@"Tick_inactive.png"];
    
    if ([data.buildingType isEqualToString:@"House"]) {
        
        self.houseImageView.image = tickActive;
        self.apartmentImageView.image = tickInactive;
        self.otherImageView.image = tickInactive;
        
    } else if ([data.buildingType isEqualToString:@"Apartment"]) {
        
        self.houseImageView.image = tickInactive;
        self.apartmentImageView.image = tickActive;
        self.otherImageView.image = tickInactive;
        
    } else {
        
        self.houseImageView.image = tickInactive;
        self.apartmentImageView.image = tickInactive;
        self.otherImageView.image = tickActive;
    }
    
    if (data.liftAvailable) {
        self.liftImageView.image = tickActive;
    } else {
        self.liftImageView.image = tickInactive;
    }
    
    self.pickUpFloorTextField.text = data.pickUpFloor;
    
}

- (void)updateTextFieldsWithData:(SMSetUpLocationData *) locationData {
    
    self.houseApartmentTextField.text = locationData.houseApartmentNumber;
    self.streetTextField.text = locationData.streetName;
    self.cityTextField.text = locationData.cityName;
    self.countyTextField.text = locationData.countyName;
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  {
    
    if ([textField isEqual:self.houseApartmentTextField]) {
        [self.streetTextField becomeFirstResponder];
        
    } else if ([textField isEqual:self.streetTextField]) {

        [self.cityTextField becomeFirstResponder];
        
    } else if ([textField isEqual:self.cityTextField]) {

        [self.countyTextField becomeFirstResponder];
        
    } else if ([textField isEqual:self.countyTextField]) {

        [textField resignFirstResponder];
        
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.pickUpFloorTextField]) {
        
        SMFloorPickerViewController *pickerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMFloorPickerViewController"];
        pickerVC.delegate = self;
        pickerVC.chosenFloor = textField.text;

        UINavigationController *navVC = [[UINavigationController alloc] initWithNavigationBarClass:[SMCustomNavigationBar class] toolbarClass:nil];
        [navVC setViewControllers:@[pickerVC]];

        navVC.preferredContentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 0.8, 200);
        navVC.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *popVC = [navVC popoverPresentationController];
        popVC.permittedArrowDirections = 0;
        popVC.sourceView = self.view;
        popVC.sourceRect = self.view.frame;
        popVC.delegate = self;
        
        [self presentViewController:navVC animated:NO completion:nil];

        return NO;
    }
    
    return YES;
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
    
}

#pragma mark - SMFloorPickerDelegate

- (void)viewController:(SMFloorPickerViewController *)viewController dismissedWithFloor:(NSString *)data {
 
    self.pickUpFloorTextField.text = data;
    
}


#pragma mark - SMMapViewDelegate

- (void)viewController:(SMMapViewController *)viewController dismissedWithData:(SMLocationAddress *)data {
    
    if (data) {
        self.address = data;
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

- (IBAction)mapLocationAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"map" sender:nil];
    
}

- (IBAction)buildingTypeAction:(UIButton *)sender {
    
    UIImage *tickActive = [UIImage imageNamed:@"Tick.png"];
    UIImage *tickInactive = [UIImage imageNamed:@"Tick_inactive.png"];
    
    switch (sender.tag) {
        case BuildingTypeHouse:
            
            self.locationData.buildingType = @"House";
            self.houseImageView.image = tickActive;
            self.apartmentImageView.image = tickInactive;
            self.otherImageView.image = tickInactive;
            break;
            
        case BuildingTypeApartment:
            
            self.locationData.buildingType = @"Apartment";
            self.houseImageView.image = tickInactive;
            self.apartmentImageView.image = tickActive;
            self.otherImageView.image = tickInactive;
            break;
            
        case BuildingTypeOther:
            
            self.locationData.buildingType = @"Other";
            self.houseImageView.image = tickInactive;
            self.apartmentImageView.image = tickInactive;
            self.otherImageView.image = tickActive;
            break;
    }
    
}

- (IBAction)saveAction:(UIButton *)sender {
    
    UIImage *tickActive = [UIImage imageNamed:@"Tick.png"];
    
    self.locationData.houseApartmentNumber = self.houseApartmentTextField.text;
    self.locationData.streetName = self.streetTextField.text;
    self.locationData.cityName = self.cityTextField.text;
    self.locationData.countyName = self.countyTextField.text;
    self.locationData.pickUpFloor = self.pickUpFloorTextField.text;
    
    if ([self.houseImageView.image isEqual:tickActive]) {
        self.locationData.buildingType = @"House";
    } else if ([self.apartmentImageView.image isEqual:tickActive]) {
        self.locationData.buildingType = @"Apartment";
    } else if ([self.otherImageView.image isEqual:tickActive]) {
        self.locationData.buildingType = @"Other";
    }
    
    if ([self.liftImageView.image isEqual:tickActive]) {
        self.locationData.liftAvailable = YES;
    }

    
    [self.delegate viewController:self dismisssedWithData:self.locationData];
    [self.navigationController popViewControllerAnimated:YES];
        
}



- (IBAction)liftAvailableAction:(UIButton *)sender {
    
    if (!self.locationData.liftAvailable) {
        
        self.locationData.liftAvailable = YES;
        self.liftImageView.image = [UIImage imageNamed:@"Tick.png"];
        
    } else {
        
        self.locationData.liftAvailable = NO;
        self.liftImageView.image = [UIImage imageNamed:@"Tick_inactive.png"];
    }
}

@end

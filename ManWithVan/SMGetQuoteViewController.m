//
//  SMGetQuoteTableViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMGetQuoteViewController.h"
#import "SMQuoteData.h"
#import "SMStartEndLocationViewController.h"
#import "SMDataManager.h"
#import "SMAddPhotoViewCell.h"
#import "SMCustomActivityIndicator.h"
#import "SMKeyboardHandler.h"

#import <MessageUI/MessageUI.h>

#define kOFFSET_FOR_KEYBOARD 80.0

@interface SMGetQuoteViewController () <UITextFieldDelegate, SMStartEndLocationDelegate, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate>

@property (strong, nonatomic) SMQuoteData *quote;
@property (assign, nonatomic) BOOL hasAtSign;
@property (assign, nonatomic) BOOL moveUp;
@property (assign, nonatomic) CGFloat moveUpViewHeight;
@property (strong, nonatomic) NSMutableArray *addPhotoArray;
@property (strong, nonatomic) NSMutableArray *placeholderArray;

@end

@implementation SMGetQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMQuoteData *quote = [[SMQuoteData alloc] init];
    quote.isSmallMoving = self.isSmallMoving;
    self.quote = quote;
    self.hasAtSign = YES;
    self.addPhotoArray = [NSMutableArray array];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, -20,[UIScreen mainScreen].bounds.size.width, 20)];
    view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:view];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.photoCollectionView reloadData];

}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    NSLog(@"%f", self.moveUpViewHeight);
    
    [self.view setFrame:CGRectMake(0,-self.moveUpViewHeight,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame))];

}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
    [self.view setFrame:CGRectMake(0,0,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame))];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.moveUp = NO;
    CGRect keyboardRect = CGRectMake(0, CGRectGetMaxY(self.view.bounds), CGRectGetWidth(self.view.bounds), -253);
    CGRect rect = [self.view convertRect:textField.frame fromView:textField.superview];
    
    if (CGRectIntersectsRect(keyboardRect, rect)) {
        NSLog(@"Intersects");
        self.moveUp = YES;
        CGRect intersection = CGRectMake(20, 20, 20, 20);
        intersection.size.height = fabs(CGRectGetHeight(keyboardRect)) - (CGRectGetMaxY(self.view.bounds) - rect.origin.y) + CGRectGetHeight(textField.bounds) + 5;
        self.moveUpViewHeight = CGRectGetHeight(intersection);
        NSLog(@"%@", NSStringFromCGRect(intersection));
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    }
    
    

    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (self.moveUp) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    }

    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField
         isEqual:self.phoneNumberTextField]) {
        
        return [self validationCheckOfCharactersAgeFieldFrom:textField inString:string];
    }
    
    if ([textField isEqual:self.emailTextField]) {
        
        return [self validationCheckOfCharactersEmailFieldFrom:textField string:string inRange:range];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.nameTextField]) {
        
        [self.phoneNumberTextField becomeFirstResponder];
        
    } else if ([textField isEqual:self.phoneNumberTextField]) {
        
        [self.emailTextField becomeFirstResponder];
        
    } else if ([textField isEqual:self.emailTextField]) {
        
        [textField resignFirstResponder];
    }
    
    if ([textField isEqual:self.descriptionTextField]) {
        
        [textField resignFirstResponder];
    }
    
    if ([textField isEqual:self.addInformationTextField]) {
        
        [textField resignFirstResponder];
    }
        
    return YES;
}



#pragma mark - Validation Check for TextField

- (BOOL)validationCheckOfCharactersAgeFieldFrom:(UITextField *) textField inString:(NSString *) string {
    
    NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *words = [string componentsSeparatedByCharactersInSet:set];
    
    if ([words count] > 1) {
        
        return NO;
        
    }
    
    return YES;
    
}

- (BOOL)validationCheckOfCharactersEmailFieldFrom:(UITextField *) textField string:(NSString *) string inRange:(NSRange) range {
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@":;'\"()+-"];
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray *words = [string componentsSeparatedByCharactersInSet:set];
    
    if ([words count] > 1 || [newString length] > 50) {
        return NO;
    }
    
    if ([textField.text length] == 0) {
        self.hasAtSign = YES;
    }
    
    if ([textField.text length] == 0 && [string isEqualToString:@"@"]) {
        
        return NO;
        
    } else if ([string isEqualToString:@"@"] && self.hasAtSign) {
        
        self.hasAtSign = NO;
        
    } else if ([string isEqualToString:@"@"] && !self.hasAtSign) {
        
        return NO;
        
    }
    
    return YES;
    
}

#pragma mark - Actions


- (IBAction)twoPeopleAction:(UIButton *)sender {

    if (!self.quote.twoPeople) {
        
        self.quote.twoPeople = YES;
        self.tickImageView.image = [UIImage imageNamed:@"Tick.png"];
        
    } else {
        
        self.quote.twoPeople = NO;
        self.tickImageView.image = [UIImage imageNamed:@"Tick_inactive.png"];
    }
    
}

- (IBAction)startLocationAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"startLocation" sender:sender];
    
}

- (IBAction)endLocationButton:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"endLocation" sender:sender];

}


- (IBAction)getQuoteAction:(UIButton *)sender {
    
    self.quote.clientName = self.nameTextField.text;
    self.quote.phoneNumber = self.phoneNumberTextField.text;
    self.quote.clientEmail = self.emailTextField.text;
    self.quote.descriptionText = self.descriptionTextField.text;
    self.quote.addInfoText = self.addInformationTextField.text;
    
    if ([self.nameTextField.text isEqualToString:@""] || [self.phoneNumberTextField.text isEqualToString:@""] ||[self.emailTextField.text isEqualToString:@""]) {
        
        NSString *alertTitle = @"Warning!";
        NSString *alertMessage = @"Please enter your name, phone number and email address";
        
        [self raiseAlertWithTitle:alertTitle message:alertMessage andErrorCode:0];
        
    } else {
        
        SMCustomActivityIndicator *ind = [[SMCustomActivityIndicator alloc] initWithFrame:self.view.frame];
        
        [self.view addSubview:ind];
        
        [[SMDataManager sharedInstance] calculationOfQuote:self.quote onComplete:^(NSInteger price, NSError *error) {
            
            [ind removeFromSuperview];
            
            if (!error) {
                
                if (price != 0) {
                    
                    UIAlertController *controller = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Your quote is %i EUR \n(1 van load)", (int)price] message:@"Would you like to proceed with this quote?" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                    UIAlertAction *proceedAction = [UIAlertAction actionWithTitle:@"Proceed" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self sendEmail];
                        
                    }];
                    
                    [controller addAction:proceedAction];
                    [controller addAction:cancelAction];
                    [self presentViewController:controller animated:YES completion:nil];

                } else {
                    
                    NSString *alertTitle = @"Warning!";
                    NSString *alertMessage = @"Please set up start and end location";
                    [self raiseAlertWithTitle:alertTitle message:alertMessage andErrorCode:0];
                    
                }
                
            } else {
                
                if (error.code == 8 || error.code == 4) {
                    
                    NSString *alertTitle = @"Warning!";
                    NSString *alertMessage = @"Please set up start and end location";
                    [self raiseAlertWithTitle:alertTitle message:alertMessage andErrorCode:error.code];
                    
                } else {
                    
                    NSString *alertTitle = @"Error";
                    NSString *alertMessage = @"Sorry, we unable to calculate the quote. \n Please check your internet connection. \n Alternatively you can either request a callback or call us directly";
                    [self raiseAlertWithTitle:alertTitle message:alertMessage andErrorCode:error.code];
                    
                }
                

            }

        }];
    }
}

- (void)raiseAlertWithTitle:(NSString *) title message:(NSString *) message andErrorCode:(NSInteger) errorCode  {
    
    if (errorCode == 2) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *callbackAction = [UIAlertAction actionWithTitle:@"Callback" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *callUsAction = [UIAlertAction actionWithTitle:@"Call Us" style:UIAlertActionStyleDefault handler:nil];
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

- (void)sendEmail {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        NSArray *recipients = [NSArray arrayWithObject:@"max6361@mail.ru"];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setToRecipients:recipients];
        [mc setSubject:@"A new quote"];
        [mc setMessageBody:[NSString stringWithFormat:
                            @"Name: %@\r\n Phone number: %@\r\n Email: %@\r\n\n Quote Details: \n\n Description: %@ \n Comments: %@ \n Two people required: %@ \n\n Moving from %@ %@ %@ %@ \r\n Building Type: %@ \n Pick up Floor: %@ \n Lift Available: %@ \r\n\n Moving to %@ %@ %@ %@ \r\n Building Type: %@ \n Pick up Floor: %@ \n Lift available: %@ \r\n\n ",
                            self.quote.clientName,
                            self.quote.phoneNumber,
                            self.quote.clientEmail,
                            self.quote.descriptionText,
                            self.quote.addInfoText,
                            self.quote.twoPeople ? @"YES" : @"NO",
                            self.quote.startLocation.houseApartmentNumber,
                            self.quote.startLocation.streetName,
                            self.quote.startLocation.cityName,
                            self.quote.startLocation.countyName,
                            self.quote.startLocation.buildingType,
                            self.quote.startLocation.pickUpFloor,
                            self.quote.startLocation.liftAvailable? @"YES": @"NO",
                            self.quote.endLocation.houseApartmentNumber,
                            self.quote.endLocation.streetName,
                            self.quote.endLocation.cityName,
                            self.quote.endLocation.countyName,
                            self.quote.endLocation.buildingType,
                            self.quote.endLocation.pickUpFloor,
                            self.quote.endLocation.liftAvailable? @"YES": @"NO"]
                    isHTML: NO];
        
        for (UIImage *image in self.addPhotoArray) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            [mc addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"imageName"];
        }
        
        [self presentViewController:mc animated:YES completion:nil];
    }
}

- (IBAction)addPhotoAction:(UIButton *)sender {
    
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:@"Add a photo" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
        imageVC.delegate = self;
        imageVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        imageVC.allowsEditing = YES;
        
        [self presentViewController:imageVC animated:YES completion:nil];
    }];
    
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
        imageVC.delegate = self;
        imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imageVC.allowsEditing = YES;
        
        [self presentViewController:imageVC animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancelAction];
    [controller addAction:libraryAction];
    [controller addAction:cameraAction];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    [self.addPhotoArray addObject:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    SMAddPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[SMAddPhotoViewCell alloc] init];
    }
    
    [cell configureCellWith:self.addPhotoArray atIndexPath:indexPath.row];

    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CGRectGetWidth(collectionView.bounds)/5.5, CGRectGetWidth(collectionView.bounds)/5.5);
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < [self.addPhotoArray count]) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Info" message:@"Remove photo?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.addPhotoArray removeObjectAtIndex:indexPath.row];
            [self.photoCollectionView reloadData];
            
        }];
        
        [controller addAction:cancelAction];
        [controller addAction:okAction];
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}



#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    if (result == MFMailComposeResultSent) {
        
        UIAlertController *contr = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Thanks for your quote!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [contr addAction:cancel];
        [self presentViewController:contr animated:YES completion:nil];
        
    }
    

    
}

#pragma mark - prepare for segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"startLocation"]) {
        
        SMStartEndLocationViewController *dvc = segue.destinationViewController;
        self.quote.isStartLocation = YES;
        dvc.delegate = self;
        dvc.quote = self.quote;
        
    } else if ([segue.identifier isEqualToString:@"endLocation"]) {
        
        SMStartEndLocationViewController *dvc = segue.destinationViewController;
        self.quote.isStartLocation = NO;
        dvc.delegate = self;
        dvc.quote = self.quote;
    }
    
}

#pragma mark - SMStartEndLocationDelegate

- (void)viewController:(SMStartEndLocationViewController *)viewController dismisssedWithData:(SMSetUpLocationData *)data {
    
    self.quote.isStartLocation ? (self.quote.startLocation = data) : (self.quote.endLocation = data);
    
}


@end

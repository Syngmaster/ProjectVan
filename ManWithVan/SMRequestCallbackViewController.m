//
//  SMRequestCallbackViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#import "SMRequestCallbackViewController.h"
#import "SMSideMenuViewController.h"
#import "SMSignInViewController.h"
#import "SMAboutUsViewController.h"


@interface SMRequestCallbackViewController () <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@end

@implementation SMRequestCallbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)openMenuAction:(UIButton *)sender {
    
    [self showMenu];
    
}


- (IBAction)sendRequestAction:(UIButton *)sender {
    
    //check if either of textFields are empty
    if ([self.nameTextField.text isEqualToString:@""] || [self.phoneTextField.text isEqualToString: @""]) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Please enter your name and your phone number" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
        
    } else {
        
        //send data to the administrator email address
        [self sendCallBackWithName:self.nameTextField.text andPhoneNumber:self.phoneTextField.text];
        
    }

}

#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.nameTextField]) {
        [self.phoneTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [self validationCheckOfCharactersAgeFieldFrom:textField inString:string];
    
}



#pragma mark - Validation Check for TextField

- (BOOL)validationCheckOfCharactersAgeFieldFrom:(UITextField *) textField inString:(NSString *) string {
    
    if ([textField isEqual:self.phoneTextField]){
        
        NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *words = [string componentsSeparatedByCharactersInSet:set];
        
        if ([words count] > 1) {
            
            return NO;
            
        }
        
    }
    
    return YES;
    
}

#pragma mark - Send Email Method

- (void)sendCallBackWithName:(NSString *) name andPhoneNumber:(NSString *) phoneNumber {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        NSArray *recipients = [NSArray arrayWithObject:@"info@vipvan.ie"];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setToRecipients:recipients];
        [mc setSubject:@"VIPvan callback request"];
        [mc setMessageBody:[NSString stringWithFormat:
                            @"Hello. \n My name is %@. \n Please call me back - %@ \n Thank you.",
                            name,
                            phoneNumber]
                    isHTML: NO];
        
        [self presentViewController:mc animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultSent) {
        
        //present an alert to inform user that request was sent successfully
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Thank you for the request! We will call you back in a moment." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.nameTextField.text = @"";
            self.phoneTextField.text = @"";
        }];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
}

@end

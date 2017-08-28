//
//  SMYourQuoteViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 28/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMYourQuoteViewController.h"
#import "SMQuoteData.h"

#import <MessageUI/MessageUI.h>

@interface SMYourQuoteViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation SMYourQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.priceLabel.text = [NSString stringWithFormat:@"%i €", (int)self.quote.price];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)proceedAction:(UIButton *)sender {
    
    [self sendEmailWithQuoteData:self.quote];
    
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)sendEmailWithQuoteData:(SMQuoteData *)quote {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        NSArray *recipients = [NSArray arrayWithObject:@"max6361@mail.ru"];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setToRecipients:recipients];
        [mc setSubject:[NSString stringWithFormat:@"A new quote (%@)", (self.quote.movingType == 0) ? @"Small moving" : self.quote.movingType == 1 ? @"House apartment moving" : @"Heavy item moving"]];
        [mc setMessageBody:[NSString stringWithFormat:
                            @"Name: %@\r\n Phone number: %@\r\n Email: %@\r\n\n Quote Details: \n\n Price: %i EUR \n Description: %@ \n Comments: %@ \n Two people required: %@ \n\n Moving from: %@ \r\n Building Type: %@ \n Pick up Floor: %i \n Lift Available: %@ \r\n\n Moving to: %@ \r\n Building Type: %@ \n Pick up Floor: %i \n Lift available: %@ \r\n\n ",
                            quote.clientName,
                            quote.phoneNumber,
                            quote.clientEmail,
                            (int)quote.price,
                            quote.descriptionText,
                            quote.addInfoText,
                            quote.twoPeople ? @"YES" : @"NO",
                            quote.startLocation.fullAddress,
                            (quote.startLocation.buildingType == 0) ? @"House" : (quote.startLocation.buildingType == 1 ? @"Apartment" : @"Other"),
                            (int)quote.startLocation.pickUpFloor,
                            quote.startLocation.liftAvailable? @"YES": @"NO",
                            quote.endLocation.fullAddress,
                            (quote.endLocation.buildingType == 0) ? @"House" : (quote.startLocation.buildingType == 1 ? @"Apartment" : @"Other"),
                            (int)quote.endLocation.pickUpFloor,
                            quote.endLocation.liftAvailable? @"YES": @"NO"]
                    isHTML: NO];
        
        int i = 1;
        
        for (UIImage *image in quote.photosArray) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            [mc addAttachmentData:imageData mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"Attached Image %i", i]];
            i = i + 1;
        }
        
        [self presentViewController:mc animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultSent) {
        
        UIAlertController *contr = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Thanks for your quote! \n We will contact you in moment." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [contr addAction:cancel];
        [self presentViewController:contr animated:YES completion:nil];
        
    }
    
}

@end

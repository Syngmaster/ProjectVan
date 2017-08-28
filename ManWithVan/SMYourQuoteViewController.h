//
//  SMYourQuoteViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 28/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMQuoteData;

@interface SMYourQuoteViewController : UIViewController

@property (strong, nonatomic) SMQuoteData *quote;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)proceedAction:(UIButton *)sender;
- (IBAction)cancelAction:(UIButton *)sender;

@end

//
//  SMRequestCallbackViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSideMenusParentViewController.h"

@interface SMRequestCallbackViewController : SMSideMenusParentViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

- (IBAction)sendRequestAction:(UIButton *)sender;

@end

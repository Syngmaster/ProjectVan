//
//  SMProfileViewCell.m
//  ManWithVan
//
//  Created by Syngmaster on 27/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMProfileViewCell.h"

@implementation SMProfileViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: self.profileLabel.text = @"*Your name:";
                self.profileTextField.placeholder = @"Your name";
                self.profileTextField.returnKeyType = UIReturnKeyDone;
                self.profileTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            break;
        case 1: self.profileLabel.text = @"*Your phone number:";
                self.profileTextField.placeholder = @"Your phone number";
                self.profileTextField.returnKeyType = UIReturnKeyDone;
                self.profileTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            break;
        case 2: self.profileLabel.text = @"*Your email address:";
                self.profileTextField.placeholder = @"Your email address";
                self.profileTextField.returnKeyType = UIReturnKeyDone;
                self.profileTextField.keyboardType = UIKeyboardTypeEmailAddress;
                self.profileTextField.autocorrectionType = UITextAutocorrectionTypeNo;

            break;
    }
}

@end

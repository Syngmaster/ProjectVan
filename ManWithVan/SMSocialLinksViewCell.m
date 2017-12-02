//
//  SMSocialLinksViewCell.m
//  ManWithVan
//
//  Created by Syngmaster on 27/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSocialLinksViewCell.h"

@implementation SMSocialLinksViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellAtRow:(NSInteger)row {
    
    switch (row) {
        case 0:
            self.socialImageView.image = [UIImage imageNamed:@"facebook_icon.png"];
            self.socialLabel.text = @"Like us on Facebook";
            break;
        case 1:
            self.socialImageView.image = [UIImage imageNamed:@"twitter_icon.png"];
            self.socialLabel.text = @"Follow us on Twitter";
            break;
            
        case 2:
            self.socialImageView.image = [UIImage imageNamed:@"google_icon.png"];
            self.socialLabel.text = @"Add us on Google Plus";
            break;
            
        case 3:
            self.socialImageView.image = [UIImage imageNamed:@"youtube_icon.png"];
            self.socialLabel.text = @"Subscribe to us on YouTube";
            break;
            
        case 4:
            self.socialImageView.image = [UIImage imageNamed:@"website_icon.png"];
            self.socialLabel.text = @"Check out our website";
            break;
            
            
    }
    
}

@end

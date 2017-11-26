//
//  SMMoreViewCell.m
//  ManWithVan
//
//  Created by Syngmaster on 26/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMoreViewCell.h"

@implementation SMMoreViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellAtRow:(NSInteger)row {

    switch (row) {
        case 0:
            self.moreImageView.image = [UIImage imageNamed:@"reviews_icon.png"];
            self.moreLabel.text = @"Reviews";
            break;
        case 1:
            self.moreImageView.image = [UIImage imageNamed:@"gallery_icon.png"];
            self.moreLabel.text = @"Gallery";
            break;
            
        case 2:
            self.moreImageView.image = [UIImage imageNamed:@"social_links_icon.png"];
            self.moreLabel.text = @"Social links";
            break;


    }
    
}

@end

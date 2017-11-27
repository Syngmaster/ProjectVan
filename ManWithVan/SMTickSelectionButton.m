//
//  SMTickSelectionButton.m
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMTickSelectionButton.h"
#import "SMDataManager.h"

@implementation SMTickSelectionButton


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/8;
    self.layer.borderColor = [SMDataManager sharedInstance].baseColor.CGColor;
    self.layer.borderWidth = 0.75;
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [UIView setAnimationsEnabled:NO];

    CGFloat fontSize = CGRectGetHeight(self.frame)*0.35;
    UIFont *font = [UIFont fontWithName:@"Avenir-Black" size:fontSize];
    UIColor *textColorNormal = [UIColor blackColor];
    NSDictionary *attributesNormal = @{NSForegroundColorAttributeName : textColorNormal, NSFontAttributeName : font, NSBackgroundColorAttributeName : [UIColor whiteColor]};
    NSAttributedString *attrStringNormal = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributesNormal];
    [self setAttributedTitle:attrStringNormal forState:UIControlStateNormal];
    
    
    
    [self layoutIfNeeded];
    [UIView setAnimationsEnabled:YES];
}


@end

//
//  SMTwoPeopleButton.m
//  ManWithVan
//
//  Created by Syngmaster on 27/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMTwoPeopleButton.h"
#import "SMDataManager.h"

@implementation SMTwoPeopleButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    self.layer.borderColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 1.0;
    CGFloat fontSize = CGRectGetHeight(self.frame)*0.35;
    UIFont *font = [UIFont fontWithName:@"Gotham-Book" size:fontSize];
    NSDictionary *attributesNormal = @{NSFontAttributeName : font};
    NSAttributedString *attrStringNormal = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributesNormal];
    [self setAttributedTitle:attrStringNormal forState:UIControlStateNormal];}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    [UIView setAnimationsEnabled:NO];
//    CGFloat fontSize = CGRectGetHeight(self.frame)*0.35;
//    UIFont *font = [UIFont fontWithName:@"Gotham-Book" size:fontSize];
//    NSDictionary *attributesNormal = @{NSFontAttributeName : font};
//    NSAttributedString *attrStringNormal = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributesNormal];
//    [self setAttributedTitle:attrStringNormal forState:UIControlStateNormal];
//    
//    [self layoutIfNeeded];
//    [UIView setAnimationsEnabled:YES];
//}

@end

//
//  SMReviewsViewCell.m
//  ManWithVan
//
//  Created by Syngmaster on 16/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMReviewsViewCell.h"

@implementation SMReviewsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(SMReviewsModel *)model atIndexPath:(NSIndexPath *) indexPath {
    
    self.commentName.text = model.commentNameArray[indexPath.row];
    self.commentBody.text = model.commentBodyArray[indexPath.row];
    
}

@end

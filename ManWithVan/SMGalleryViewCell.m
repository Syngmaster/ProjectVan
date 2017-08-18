//
//  SMGalleryViewCell.m
//  ManWithVan
//
//  Created by Syngmaster on 17/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMGalleryViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation SMGalleryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 1.0;
}


- (void)configureCell:(NSArray *) photosArray atIndexPath:(NSIndexPath *) indexPath {
    [self.galleryImageView setImageWithURL:[NSURL URLWithString:photosArray[indexPath.row]] placeholderImage:nil];
}

@end

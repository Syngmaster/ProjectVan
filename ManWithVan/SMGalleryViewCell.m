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


- (void)configureCell:(NSArray *) photosArray atIndexPath:(NSIndexPath *) indexPath {
    [self.galleryImageView setImageWithURL:[NSURL URLWithString:photosArray[indexPath.row]] placeholderImage:nil];
}

@end

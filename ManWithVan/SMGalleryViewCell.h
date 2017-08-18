//
//  SMGalleryViewCell.h
//  ManWithVan
//
//  Created by Syngmaster on 17/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMGalleryViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *galleryImageView;

- (void)configureCell:(NSArray *) photosArray atIndexPath:(NSIndexPath *) indexPath;

@end

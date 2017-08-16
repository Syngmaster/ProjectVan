//
//  SMAddPhotoViewCell.h
//  ManWithVan
//
//  Created by Syngmaster on 10/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMAddPhotoViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)configureCellWith:(NSMutableArray *) photos atIndexPath:(NSInteger) row;

@end

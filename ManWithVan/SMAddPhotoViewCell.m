//
//  SMAddPhotoViewCell.m
//  ManWithVan
//
//  Created by Syngmaster on 10/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMAddPhotoViewCell.h"
#import "SMDataManager.h"

@implementation SMAddPhotoViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [SMDataManager sharedInstance].baseColor.CGColor;
    self.layer.borderWidth = 1.0;

}

- (void)configureCellWith:(NSMutableArray *) photos atIndexPath:(NSInteger) row {
    
    if (row == 0) {
        
        self.imageView.image = [UIImage imageNamed:@"add_photo_img.png"];
        
    } else {
        
        self.imageView.image = photos[row - 1];
        
    }
    
}

@end

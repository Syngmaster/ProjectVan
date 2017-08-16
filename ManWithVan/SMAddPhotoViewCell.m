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
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0;

}

- (void)configureCellWith:(NSMutableArray *) photos atIndexPath:(NSInteger) row {
    
    if ([photos count] == 0) {
        self.imageView.image = [SMDataManager sharedInstance].placeHolder;
    } if ([photos count] > 0) {
        
        NSInteger i = [photos count];
        if (i > row) {
            self.imageView.image = photos[row];
        } else {
            self.imageView.image = [SMDataManager sharedInstance].placeHolder;
        }
        
    }
    
}

@end

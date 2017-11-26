//
//  SMMoreViewCell.h
//  ManWithVan
//
//  Created by Syngmaster on 26/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMMoreViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

- (void)configureCellAtRow:(NSInteger)row;

@end

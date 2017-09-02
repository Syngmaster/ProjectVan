//
//  SMReviewsViewCell.h
//  ManWithVan
//
//  Created by Syngmaster on 16/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMReviewsModel;

@interface SMReviewsViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentName;
@property (weak, nonatomic) IBOutlet UILabel *commentBody;

- (void)configureCell:(SMReviewsModel *)model atIndexPath:(NSIndexPath *) indexPath;

@end

//
//  SMSocialLinksViewCell.h
//  ManWithVan
//
//  Created by Syngmaster on 27/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSocialLinksViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *socialImageView;
@property (weak, nonatomic) IBOutlet UILabel *socialLabel;

- (void)configureCellAtRow:(NSInteger)row;

@end

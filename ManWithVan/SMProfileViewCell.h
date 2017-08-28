//
//  SMProfileViewCell.h
//  ManWithVan
//
//  Created by Syngmaster on 27/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMProfileViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *profileLabel;
@property (weak, nonatomic) IBOutlet UITextField *profileTextField;

- (void)configureCellAtIndexPath:(NSIndexPath *)indexPath;

@end

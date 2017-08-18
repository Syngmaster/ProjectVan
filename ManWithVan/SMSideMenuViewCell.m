//
//  SMSideMenuViewCell.m
//  ManWithVan
//
//  Created by Syngmaster on 19/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSideMenuViewCell.h"
#import "SMDataManager.h"

@implementation SMSideMenuViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = [SMDataManager sharedInstance].baseColor;
    self.selectedBackgroundView = view;
    self.sideMenuLabel.highlightedTextColor = [UIColor whiteColor];

}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3);
    
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 5);
    
    CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)configureCell:(NSIndexPath *) indexPath {
    
    self.sideMenuImageView.image = [[SMDataManager sharedInstance].iconArray objectAtIndex:indexPath.row];
    self.sideMenuImageView.highlightedImage = [[SMDataManager sharedInstance].pressedIconArray objectAtIndex:indexPath.row];
    self.sideMenuLabel.text = [[SMDataManager sharedInstance].iconNameArray objectAtIndex:indexPath.row];
}

@end

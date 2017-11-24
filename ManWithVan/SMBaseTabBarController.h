//
//  BaseTabBarController.h
//  ManWithVan
//
//  Created by Syngmaster on 24/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMBaseTabBarController : UITabBarController

- (void)addRaisedCenterButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage andOffset:(CGFloat)offset;

@end

//
//  SMGalleryViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 17/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSideMenusParentViewController.h"

@interface SMGalleryViewController : SMSideMenusParentViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)openMenu:(UIButton *)sender;

@end

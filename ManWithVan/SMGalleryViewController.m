//
//  SMGalleryViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 17/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMGalleryViewController.h"
#import "SMGalleryViewCell.h"
#import "SMDataManager.h"

@interface SMGalleryViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *photosArray;

@end

@implementation SMGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.activityIndicator startAnimating];

    [[SMDataManager sharedInstance] getPhotosFromGooglePlusAccountOnComplete:^(NSArray *array, NSError *error) {
        
        if (array) {
            self.photosArray = array;
            [self.activityIndicator stopAnimating];
            [self.activityIndicator hidesWhenStopped];
            [self updateTableData];
        } else {
            
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"No connection!" message:@"Please check your internet connection!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
            [controller addAction:action];
            [self presentViewController:controller animated:YES completion:nil];
        }
        
    }];
}

- (void)updateTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (IBAction)openMenu:(UIButton *)sender {
    
    [self showMenu];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photosArray count];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"galleryCell";
    
    SMGalleryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[SMGalleryViewCell alloc] init];
    }
    
    [cell configureCell:self.photosArray atIndexPath:indexPath];
    
    return cell;
}


@end

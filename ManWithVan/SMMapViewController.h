//
//  SMMapViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class SMMapViewController, SMLocationAddress;

@protocol SMMapViewDelegate <NSObject>

- (void)viewController:(SMMapViewController *)viewController dismissedWithData:(SMLocationAddress *)data;

@end

@interface SMMapViewController : UIViewController

@property (weak, nonatomic) id <SMMapViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

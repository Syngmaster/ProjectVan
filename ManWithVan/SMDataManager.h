//
//  SMDataManager.h
//  ManWithVan
//
//  Created by Syngmaster on 19/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class SMSetUpLocationData, SMQuoteData;

@interface SMDataManager : NSObject

@property (strong, nonatomic) UIColor *baseColor;
@property (strong, nonatomic) NSArray *iconArray;
@property (strong, nonatomic) NSArray *pressedIconArray;
@property (strong, nonatomic) NSArray *iconNameArray;
@property (strong, nonatomic) CLLocation *centerDublinLocation;
@property (strong, nonatomic) CLLocation *officeDublinLocation;
@property (strong, nonatomic) UIImage *placeHolder;
@property (strong, nonatomic) CLGeocoder *geoCoder;

+ (SMDataManager *)sharedInstance;
- (void)getAddressFromCoordinates:(CLLocationCoordinate2D) coordinates onComplete:(void(^)(CLPlacemark *placemark, NSString *error)) completionHandler;
- (void)getCoordinatesFromAddress:(SMSetUpLocationData *) address onComplete:(void(^)(CLLocationCoordinate2D coordinates, NSError *error)) completionHandler;

- (void)calculationOfQuote:(SMQuoteData *) quote onComplete:(void(^)(NSInteger price, NSError *error)) completionHandler;


@end

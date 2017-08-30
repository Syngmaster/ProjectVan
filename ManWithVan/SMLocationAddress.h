//
//  SMLocationAddress.h
//  ManWithVan
//
//  Created by Syngmaster on 27/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SMLocationAddress : NSObject

@property (strong, nonatomic) NSString *fullAddress;

- (instancetype)initWithPlacemark:(CLPlacemark *)placemark;

@end

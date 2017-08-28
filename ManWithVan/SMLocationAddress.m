//
//  SMLocationAddress.m
//  ManWithVan
//
//  Created by Syngmaster on 27/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMLocationAddress.h"

@implementation SMLocationAddress

- (instancetype)initWithPlacemark:(CLPlacemark *)placemark {
    
    self = [super init];
    if (self) {
        
        self.houseApartmentNumber = placemark.subThoroughfare;
        self.streetName = placemark.thoroughfare;
        self.cityName = placemark.locality;
        self.countyName = placemark.administrativeArea;
        
        self.fullAddress = [NSString stringWithFormat:@"%@ %@ %@ %@",
                            placemark.subThoroughfare    ? placemark.subThoroughfare : @"",
                            placemark.thoroughfare       ? placemark.thoroughfare : @"",
                            placemark.locality           ? placemark.locality : @"",
                            placemark.administrativeArea ? placemark.administrativeArea : @""];
        
    }
    return self;
}


@end

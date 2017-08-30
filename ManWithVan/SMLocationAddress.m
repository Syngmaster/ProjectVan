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
        
        self.fullAddress = [NSString stringWithFormat:@"%@%@%@%@",
                            placemark.subThoroughfare    ?
                            [NSString stringWithFormat:@"%@ ", placemark.subThoroughfare] : @"",
                            
                            placemark.thoroughfare       ?
                            [NSString stringWithFormat:@"%@ ", placemark.thoroughfare] : @"",
                            
                            placemark.locality           ?
                            [NSString stringWithFormat:@"%@ ", placemark.locality] : @"",
                            
                            placemark.administrativeArea ?
                            [NSString stringWithFormat:@"%@ ", placemark.administrativeArea] : @""];
        
        
    }
    return self;
}


@end

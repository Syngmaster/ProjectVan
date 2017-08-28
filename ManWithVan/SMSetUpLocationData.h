//
//  SMSetUpLocationData.h
//  ManWithVan
//
//  Created by Syngmaster on 26/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, BuildingType) {
    
    BuildingTypeHouse,
    BuildingTypeApartment,
    BuildingTypeOther
    
};

@interface SMSetUpLocationData : NSObject

@property (strong, nonatomic) NSString *fullAddress;
@property (assign, nonatomic) CLLocationCoordinate2D location;
@property (assign, nonatomic) NSInteger buildingType;
@property (assign, nonatomic) NSInteger pickUpFloor;
@property (assign, nonatomic) float loadingTime;
@property (assign, nonatomic) BOOL liftAvailable;


@end

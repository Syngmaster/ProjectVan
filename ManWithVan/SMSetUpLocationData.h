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

@property (strong, nonatomic) NSString *houseApartmentNumber;
@property (strong, nonatomic) NSString *streetName;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *countyName;
@property (assign, nonatomic) CLLocationCoordinate2D location;
@property (assign, nonatomic) NSString *buildingType;
@property (strong, nonatomic) NSString *pickUpFloor;
@property (assign, nonatomic) float loadingTime;
@property (assign, nonatomic) BOOL liftAvailable;

@end

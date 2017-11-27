//
//  SMDataManager.m
//  ManWithVan
//
//  Created by Syngmaster on 19/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <FirebaseDatabase/FirebaseDatabase.h>
#import <AFNetworking/AFNetworking.h>

#import "SMDataManager.h"
#import "SMSetUpLocationData.h"
#import "SMQuoteData.h"


@interface SMDataManager ()

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation SMDataManager

+ (SMDataManager *)sharedInstance {
    
    static SMDataManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SMDataManager alloc] init];
    });
    
    return sharedManager;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0];
        _centerDublinLocation = [[CLLocation alloc] initWithLatitude:53.338082 longitude:-6.259117];
        _officeDublinLocation = [[CLLocation alloc] initWithLatitude:53.349325 longitude:-6.290251];
    }
    return self;
}

- (void)getPhotosFromGooglePlusAccountOnComplete:(void(^)(NSArray *array, NSError *error)) completionHandler {
    NSString *url = @"https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJDVjn_zMMZ0gRrNRZRFz0UM8&key=AIzaSyCRh3rshLN9sWCL4Oy8HffknYOTTqu8puU";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            NSDictionary *result = responseObject[@"result"];
            NSArray *photosArray = result[@"photos"];
            NSMutableArray *resultArray = [NSMutableArray array];
            
            for (NSDictionary *dict in photosArray) {
                
                NSString *photoURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=%@&photoreference=%@&key=AIzaSyCRh3rshLN9sWCL4Oy8HffknYOTTqu8puU", dict[@"width"], dict[@"photo_reference"]];
                [resultArray addObject:photoURL];
            }
            
            completionHandler(resultArray, nil);
            
        } else {
            
            NSError *error;
            completionHandler(nil,error);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        completionHandler(nil, error);

    }];
    
}

- (void)getAddressFromCoordinates:(CLLocationCoordinate2D) coordinates onComplete:(void(^)(CLPlacemark *placemark, NSString *error)) completionHandler {
    CLLocationCoordinate2D coordinate = coordinates;
    self.geoCoder = [[CLGeocoder alloc] init];

    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        NSString *message = nil;
        
        if (error) {
            
            message = [error description];
            completionHandler(nil, message);
            
        } else {
            
            if ([placemarks count] > 0) {
                
                CLPlacemark *placeMark = [placemarks firstObject];
                completionHandler(placeMark, nil);
                
            } else {
                
                message = @"No placemarks found";
                completionHandler(nil, message);
                
            }
        }
    }];
}

- (void)getCoordinatesFromAddress:(SMSetUpLocationData *) address onComplete:(void(^)(CLLocationCoordinate2D coordinates, NSError *error)) completionHandler {
    
    if (![address isEqual:nil]) {
        
        self.geoCoder = [[CLGeocoder alloc] init];
        
        if ([self.geoCoder isGeocoding]) {
            [self.geoCoder cancelGeocode];
        }

        [self.geoCoder geocodeAddressString:address.fullAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (placemarks) {
                
                CLPlacemark* placemark = [placemarks firstObject];
                CLLocationCoordinate2D coordinates;
                coordinates.latitude = placemark.location.coordinate.latitude;
                coordinates.longitude = placemark.location.coordinate.longitude;
                
                completionHandler(coordinates, nil);
                
            } else {
                
                CLLocationCoordinate2D coordinates = kCLLocationCoordinate2DInvalid;
                completionHandler(coordinates, error);
            }
            
        }];
 
    } else {
        
        NSError *error;
        CLLocationCoordinate2D coordinates = kCLLocationCoordinate2DInvalid;
        completionHandler(coordinates, error);
        
    }
}

- (void)calculationOfQuote:(SMQuoteData *) quote onComplete:(void(^)(NSInteger price, NSError *error)) completionHandler {
    
    __block NSInteger price = 0;
    
    if (quote.movingType == MovingTypeSmall || quote.movingType == MovingTypeHeavy) {
        
        if (quote.startLocation.buildingType == BuildingTypeHouse && quote.endLocation.buildingType == BuildingTypeHouse) {
            
            (quote.movingType == MovingTypeSmall) ? (price = 50) : (price = 130);
            
        } else if (quote.startLocation.buildingType == BuildingTypeApartment && quote.endLocation.buildingType == BuildingTypeApartment) {
            
            if (quote.startLocation.liftAvailable && quote.endLocation.liftAvailable) {
                
                (quote.movingType == MovingTypeSmall) ? (price = 60) : (price = 140);

            } else {
                
                (quote.movingType == MovingTypeSmall) ? (price = 50) : (price = 130);
                
                if (!quote.startLocation.liftAvailable) {
                    price = [self updatePrice:price ofQuote:quote withPickUpFloor:quote.startLocation];
                }
                
                if (!quote.endLocation.liftAvailable) {
                    price = [self updatePrice:price ofQuote:quote withPickUpFloor:quote.endLocation];
                }
                
            }
            
        } else {
            
            (quote.movingType == MovingTypeSmall) ? (price = 50) : (price = 130);
            
            if (quote.startLocation.buildingType == BuildingTypeApartment || quote.startLocation.buildingType == BuildingTypeOther) {
                
                if (quote.startLocation.liftAvailable) {
                    (quote.movingType == MovingTypeSmall) ? (price = 60) : (price = 140);
                } else {
                    price = [self updatePrice:price ofQuote:quote withPickUpFloor:quote.startLocation];
                }
                
            }
            
            if (quote.endLocation.buildingType == BuildingTypeApartment || quote.endLocation.buildingType == BuildingTypeOther) {
                
                if (quote.endLocation.liftAvailable) {
                    price = 60;
                } else {
                    price = [self updatePrice:price ofQuote:quote withPickUpFloor:quote.endLocation];
                }
            }
        }
        
    } else {
        
        quote.startLocation.loadingTime = quote.endLocation.loadingTime = 0.5;

        if (quote.startLocation.buildingType == BuildingTypeApartment && quote.endLocation.buildingType == BuildingTypeApartment) {
            
            if (!quote.startLocation.liftAvailable) {
                price = [self updatePrice:price ofQuote:quote withPickUpFloor:quote.startLocation];
            } else {
                quote.startLocation.loadingTime = 1.0;
            }
            
            if (!quote.endLocation.liftAvailable) {
                price = [self updatePrice:price ofQuote:quote withPickUpFloor:quote.endLocation];
            } else {
                quote.endLocation.loadingTime = 1.0;
            }
            
        } else {
            
            if (quote.startLocation.buildingType == BuildingTypeApartment || quote.startLocation.buildingType == BuildingTypeOther) {
                
                if (!quote.startLocation.liftAvailable) {
                    price = [self updatePrice:price ofQuote:quote withPickUpFloor:quote.startLocation];
                } else {
                    quote.startLocation.loadingTime = 1.0;
                }
                
            }
            
            if (quote.endLocation.buildingType == BuildingTypeApartment || quote.endLocation.buildingType == BuildingTypeOther) {
                
                if (!quote.endLocation.liftAvailable) {
                    price = [self updatePrice:price ofQuote:quote withPickUpFloor:quote.endLocation];
                } else {
                    quote.endLocation.loadingTime = 1.0;

                }
            }
        }
        
    }
    
    [self getCoordinatesFromAddress:quote.startLocation onComplete:^(CLLocationCoordinate2D coordinates, NSError *error) {
        
        if (!error) {
            
            CLLocationCoordinate2D startPoint = coordinates;
            
            [self getCoordinatesFromAddress:quote.endLocation onComplete:^(CLLocationCoordinate2D coordinates, NSError *error) {
                
                if (!error) {
                    
                    CLLocationCoordinate2D endPoint = coordinates;
                    
                    if (quote.movingType == MovingTypeSmall || quote.movingType == MovingTypeHeavy) {
                        
                        if (quote.startLocation && quote.endLocation) {
                            
                            price = [self updatePrice:price ofQuote:quote basedOnStartCoordinates:startPoint andEndCoordinates:endPoint];
                            
                            completionHandler(price, nil);
                            [self.geoCoder cancelGeocode];

                        } else {
                            
                            completionHandler(0, nil);
                            [self.geoCoder cancelGeocode];

                        }
                        
                    } else {
                        
                        [self getDistanceBetweenStartPoint:startPoint andEndPoint:endPoint onComplete:^(MKRoute *resultRoute, NSError *error) {
                            
                            if (resultRoute) {
                                
                                NSInteger finalPrice = [self totalPriceOfQuote:quote basedOn:resultRoute.expectedTravelTime];
                                finalPrice = finalPrice + price;
                                
                                completionHandler(finalPrice, nil);
                                [self.geoCoder cancelGeocode];
                                
                            } else {
                                
                                completionHandler(0, error);
                                [self.geoCoder cancelGeocode];

                            }
                            
                        }];
                    }
                    
                } else {
                    
                    completionHandler(0, error);
                    [self.geoCoder cancelGeocode];

                }
                
            }];

        } else {
            
            completionHandler(0, error);
            [self.geoCoder cancelGeocode];

        }
        
    }];

}

- (NSInteger)updatePrice:(NSInteger) price ofQuote:(SMQuoteData *) quote basedOnStartCoordinates:(CLLocationCoordinate2D) startPoint andEndCoordinates:(CLLocationCoordinate2D) endPoint {
    
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:startPoint.latitude longitude:startPoint.longitude];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:endPoint.latitude longitude:endPoint.longitude];
    
    CLLocationDistance distance1 = [[SMDataManager sharedInstance].centerDublinLocation distanceFromLocation:startLocation];
    CLLocationDistance distance2 = [[SMDataManager sharedInstance].centerDublinLocation distanceFromLocation:endLocation];
    CLLocationDistance distanceFromOfficeToStartPoint = [[SMDataManager sharedInstance].officeDublinLocation distanceFromLocation:startLocation];
    CLLocationDistance workingDistance = [startLocation distanceFromLocation:endLocation];
    
    float estHoursOfWork = 0.0;
    estHoursOfWork = estHoursOfWork + workingDistance/(60000);
    
    if (distanceFromOfficeToStartPoint > 9000) {
        
        NSInteger result;
        result = distanceFromOfficeToStartPoint/1000;
        price = price + result;
        estHoursOfWork = estHoursOfWork + result/60.0;
    }
    
    
    if (quote.twoPeople) {
        
        if (estHoursOfWork > 1) {
            float roundedResult = ceil(estHoursOfWork / 0.5) * 0.5;
            price = price + roundedResult * 30;
        } else {
            price = price + 30;
        }
        
    }
    
    double biggerDistance = MAX(distance1, distance2);
    
    if (biggerDistance > 9000) {
        
        NSInteger result;
        result = biggerDistance/1000;
        result = result - 9;
        price = price + result;
    }
    
    NSInteger roundedResult = ceil((float)price / 5) * 5;
    
    return roundedResult;
}

- (void)getDistanceBetweenStartPoint:(CLLocationCoordinate2D) startPoint andEndPoint:(CLLocationCoordinate2D) endPoint onComplete:(void(^)(MKRoute *resultRoute, NSError *error)) completionHandler {
    
    MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithCoordinate:startPoint addressDictionary:nil];
    MKPlacemark *endPlacemark = [[MKPlacemark alloc] initWithCoordinate:endPoint addressDictionary:nil];
    
    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endPlacemark];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = startItem;
    request.destination = endItem;
    request.transportType = MKDirectionsTransportTypeAutomobile;
    request.requestsAlternateRoutes = YES;
    
    MKDirections *direction = [[MKDirections alloc] initWithRequest:request];
    
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        
        if (response) {
            
            MKRoute *shortestRoute = response.routes[0];
            
            for (MKRoute *route in response.routes) {
                
                if (shortestRoute.expectedTravelTime > route.expectedTravelTime) {
                    shortestRoute = route;
                }
            }
            
            completionHandler(shortestRoute, nil);
            
        } else {
            
            completionHandler(nil, error);
        }
        
    }];
    
}

- (NSInteger)updatePrice:(NSInteger) price ofQuote:(SMQuoteData *) quote withPickUpFloor:(SMSetUpLocationData *)loadingPoint {
    
    NSInteger multiplier = loadingPoint.pickUpFloor;

    if ([quote.startLocation isEqual:loadingPoint]) {
        
        loadingPoint.loadingTime = loadingPoint.loadingTime + 0.5 * multiplier;
    }
    
    price = price + 5 * multiplier;

    return price;
}

- (NSInteger)totalPriceOfQuote:(SMQuoteData *) quote basedOn:(float) expectedTravelTime {
    
    NSInteger roundedResult = ceil(expectedTravelTime / 20) * 20;
    float travelTime = roundedResult/3600.0;
    float totalTime = travelTime * 2 + (quote.startLocation.loadingTime + quote.endLocation.loadingTime);
    NSInteger price = 0;
    
    if (quote.twoPeople) {
        
        price = (totalTime - 1) * 70 + 100;
        price = ceil((float)price / 10) * 10;
        
    } else {
        
        price = (totalTime - 1) * 40 + 70;
        price = ceil((float)price / 10) * 10;
        
    }

    return price;
}

- (void)saveQuoteToFIRDatabase:(SMQuoteData *)quote {
    
    self.ref = [[FIRDatabase database] reference];
    
    [[[self.ref child:@"Sent quotes"] child:[NSString stringWithFormat:@"New quote %@", [NSDate date]]]
            setValue:@{@"Price" : @(quote.price),
                       @"Moving type" : quote.movingType == 0 ? @"Small" : (quote.movingType == 1 ? @"Big" : @"Heavy"),
                       @"Data" : [NSString stringWithFormat:@"%@",[NSDate date]]}];
    
}



@end

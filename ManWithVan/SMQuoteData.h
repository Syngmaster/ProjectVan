//
//  SMQuoteData.h
//  ManWithVan
//
//  Created by Syngmaster on 26/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMSetUpLocationData.h"


@interface SMQuoteData : NSObject

@property (assign,nonatomic) BOOL isSmallMoving;

@property (strong, nonatomic) NSString *clientName;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *clientEmail;
@property (strong, nonatomic) NSString *descriptionText;
@property (strong, nonatomic) NSMutableArray *photosArray;
@property (strong, nonatomic) NSString *addInfoText;
@property (assign, nonatomic) BOOL twoPeople;
@property (assign, nonatomic) NSInteger price;

@property (assign, nonatomic) BOOL isStartLocation;
@property (strong, nonatomic) SMSetUpLocationData *startLocation;
@property (strong, nonatomic) SMSetUpLocationData *endLocation;

@end

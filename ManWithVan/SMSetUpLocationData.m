//
//  SMSetUpLocationData.m
//  ManWithVan
//
//  Created by Syngmaster on 26/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSetUpLocationData.h"

@implementation SMSetUpLocationData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.buildingType = 0;
        self.liftAvailable = NO;
        self.pickUpFloor = 0;
    }
    return self;
}



@end

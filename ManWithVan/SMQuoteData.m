//
//  SMQuoteData.m
//  ManWithVan
//
//  Created by Syngmaster on 26/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMQuoteData.h"

@implementation SMQuoteData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.twoPeople = NO;
        self.photosArray = [NSMutableArray array];
    }
    return self;
}

@end

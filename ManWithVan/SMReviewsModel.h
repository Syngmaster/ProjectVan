//
//  SMReviewsModel.h
//  ManWithVan
//
//  Created by Syngmaster on 16/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMReviewsModel : NSObject

@property (strong, nonatomic) NSString *commentName;
@property (strong, nonatomic) NSString *commentBody;
@property (assign, nonatomic) NSInteger commentRating;

@property (strong, nonatomic) NSArray *commentNameArray;
@property (strong, nonatomic) NSArray *commentBodyArray;

@end

//
//  SMReviewsModel.m
//  ManWithVan
//
//  Created by Syngmaster on 16/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMReviewsModel.h"

@interface SMReviewsModel ()

@end

@implementation SMReviewsModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *commentName = @[@"gal silky",@"TED",@"Eamon Mc Dermott",@"Alison Harte", @"saida jokubauskyte", @"Eslanda Vilcikauskiene", @"tara", @"Philip O'Callaghan", @"Pawel Naczke", @"Margaret Lawlor", @"Moya Guilfoyle", @"Suraj De", @"Pebble Darbai", @"Salvija Zelve"];
        NSArray *commentBody = @[@"Tom arrived on time, gave great service at a reasonable price, I would recommend!", @"He was great, he arrived ten minutes early, which was great. He did my move at 730 in the evening because that was the only time I could move. Really great guy!", @"Very prompt and polite and helpful", @"Would recommend this service to anyone very helpful,reliable and on time couldn't do more for customer.lovely friendly service will be using it whenever I need moving or collecting", @"I was very happy with the service and good communication. I would definitely recommend it to others.", @"I have used this moving company couple of times and was left very satisfied with great service,punctuality,acomodation and meeting  my personal needs.Guys were very fast movers so that saved our time and money.I would greatly recomend this service!", @"Punctual, professional, efficient and courteous.  Tom and partner were most obliging, nothing was too much trouble! Highly recommended.", @"Great service. Very flexible and happy to give my highest recommendation. Keep up the good work.", @"Thanks for the business! Quick and easy! Recommended !", @"Excellent service, professional & punctual. Would definately recommend /use again", @"Excellent service. Very punctual and great communication.", @"Helped me move my stuff to my new apartment no hassle, good service and price. Highly recommend.", @"Fast and good price ", @"Good and quick  service "];
        //NSArray *commentRating = @[@5,@5,@5,@5,@5,@5,@5,@5,@5,@5,@5,@5,@5,@5];
        //NSDictionary *testData = @{@"commentName" : commentName, @"commentBody" : commentBody, @"commentRating" : commentRating};
        
        self.commentNameArray = commentName;
        self.commentBodyArray = commentBody;
    }
    return self;
}

@end

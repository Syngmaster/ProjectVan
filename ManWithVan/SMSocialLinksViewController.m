//
//  SMSocialLinksViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 15/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSocialLinksViewController.h"
#import "SMSocialLinksViewCell.h"

typedef NS_ENUM(NSInteger, SocialLink) {
    
    SocialLinkFacebook,
    SocialLinkTwitter,
    SocialLinkGooglePlus,
    SocialLinkYoutube,
    SocialLinkWebsite
    
};

@interface SMSocialLinksViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SMSocialLinksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SMSocialLinksViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[SMSocialLinksViewCell alloc] init];
    }
    [cell configureCellAtRow:indexPath.row];
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSURL *url;
    
    switch (indexPath.row) {
        case SocialLinkFacebook:
            url = [NSURL URLWithString:@"https://www.facebook.com/vipvandublin/"];
            [self openURLwithURL:url];
            break;
            
        case SocialLinkTwitter:
            url = [NSURL URLWithString:@"https://twitter.com/MANandVANdublin?s=09"];
            [self openURLwithURL:url];
            break;
            
        case SocialLinkGooglePlus:
            url = [NSURL URLWithString:@"https://g.co/kgs/9UmsMm"];
            [self openURLwithURL:url];
            break;
            
        case SocialLinkYoutube:
            url = [NSURL URLWithString:@"https://www.youtube.com/channel/UC2nqLYfTE1k-mSBfqzrpTbg"];
            [self openURLwithURL:url];
            break;
            
        case SocialLinkWebsite:
            url = [NSURL URLWithString:@"http://vipvan.ie/"];
            [self openURLwithURL:url];
            break;
            
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


- (void)openURLwithURL:(NSURL *)url {
    if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

@end

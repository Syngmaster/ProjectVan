//
//  SMSocialLinksViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 15/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSocialLinksViewController.h"

typedef NS_ENUM(NSInteger, SocialLink) {
    
    SocialLinkFacebook,
    SocialLinkGooglePlus,
    SocialLinkTwitter,
    SocialLinkYoutube,
    SocialLinkWebsite
    
};

@interface SMSocialLinksViewController ()

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

- (IBAction)openMenu:(UIButton *)sender {
    
    [self showMenu];
    
}

- (IBAction)socialLinkAction:(UIButton *)sender {
    
    NSURL *url;
    
    switch (sender.tag) {
        case SocialLinkFacebook:
            url = [NSURL URLWithString:@"https://www.facebook.com/vipvandublin/"];
            
            if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
            
            break;
        case SocialLinkGooglePlus:
            url = [NSURL URLWithString:@"https://g.co/kgs/9UmsMm"];
            if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
            break;
        case SocialLinkTwitter:
            url = [NSURL URLWithString:@"https://twitter.com/MANandVANdublin?s=09"];
            if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
            break;
        case SocialLinkYoutube:
            url = [NSURL URLWithString:@"https://www.youtube.com/channel/UC2nqLYfTE1k-mSBfqzrpTbg"];
            if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
            break;
        case SocialLinkWebsite:
            url = [NSURL URLWithString:@"http://vipvan.ie/"];
            if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
            break;

    }
    
}


@end

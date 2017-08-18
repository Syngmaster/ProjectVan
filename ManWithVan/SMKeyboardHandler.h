//
//  SMKeyboardHandler.h
//  ManWithVan
//
//  Created by Syngmaster on 17/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SMKeyboardHandlerDelegate <NSObject>;

- (void)keyboardSizeChanged:(CGSize)delta;

@end

@interface SMKeyboardHandler : NSObject

- (id)init;

// Put 'weak' instead of 'assign' if you use ARC
@property(nonatomic, weak) id <SMKeyboardHandlerDelegate> delegate;
@property(nonatomic) CGRect frame;

@end


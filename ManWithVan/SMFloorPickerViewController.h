//
//  SMFloorPickerViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 28/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMFloorPickerViewController;

@protocol SMFloorPickerDelegate <NSObject>

- (void)viewController:(SMFloorPickerViewController *)viewController dismissedWithFloor:(NSString *)data;

@end

@interface SMFloorPickerViewController : UIViewController

@property (strong, nonatomic) NSString *chosenFloor;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) id <SMFloorPickerDelegate> delegate;

@end

//
//  SMFloorPickerViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 28/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMFloorPickerViewController.h"

@interface SMFloorPickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *pickerData;

@end

@implementation SMFloorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"Ground", @"First", @"Second", @"Third", @"Over third"];
    self.pickerData = array;
    
    self.navigationItem.title = @"Select a floor";

    UIImage *cancelImage = [[UIImage imageNamed:@"Cancel_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:cancelImage style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    

    UIImage *saveImage = [[UIImage imageNamed:@"Tick.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithImage:saveImage style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    
    self.navigationItem.rightBarButtonItem = saveButton;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (NSString *value in self.pickerData) {
        
        if ([value isEqualToString:self.chosenFloor]) {
            
            [self.pickerView selectRow:[self.pickerData indexOfObject:value] inComponent:0 animated:YES];
            
        }
        
    }
}

#pragma mark - Actions

- (void)saveAction:(UIBarButtonItem *)sender {
    
    [self.delegate viewController:self dismissedWithFloor:self.chosenFloor];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerData count];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerData[row];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.chosenFloor = self.pickerData[row];
    
}



@end

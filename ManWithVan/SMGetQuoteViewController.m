//
//  SMGetQuoteTableViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMGetQuoteViewController.h"
#import "SMStartEndLocationViewController.h"

#import "SMAddPhotoViewCell.h"
#import "SMDescriptionViewCell.h"
#import "SMProfileViewCell.h"
#import "SMCustomActivityIndicator.h"
#import "SMSectionLabel.h"
#import "SMCustomLabel.h"

#import "SMQuoteData.h"
#import "SMDataManager.h"

@interface SMGetQuoteViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) SMQuoteData *quote;
@property (assign, nonatomic) BOOL hasAtSign;

@end

@implementation SMGetQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMQuoteData *quote = [[SMQuoteData alloc] init];
    quote.movingType = self.movingType;
    self.quote = quote;
    self.hasAtSign = YES;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.photoCollectionView reloadData];

}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier1 = @"profileCell";
    static NSString *identifier2 = @"descriptionCell";
    
    if (indexPath.section == 0) {
        
        SMProfileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];

        if (!cell) {
            cell = [[SMProfileViewCell alloc] init];
        }
        
        [cell configureCellAtIndexPath:indexPath];
        
        return cell;
        
    } else {
        
        SMProfileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        
        if (!cell) {
            cell = [[SMProfileViewCell alloc] init];
        }
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGRect headerFrame = CGRectMake(0, 0, tableView.frame.size.width, 28);

    UIView *headerView = [[UIView alloc] initWithFrame:headerFrame];
    
    headerView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    
    SMSectionLabel *headerTextLabel = [[SMSectionLabel alloc] initWithFrame:headerFrame];
    headerTextLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:headerTextLabel];
    
    (section == 0) ? (headerTextLabel.text = @"Personal details") : (headerTextLabel.text = @"Description");
    
    return headerView;
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    SMProfileViewCell *phoneNumberCell = self.tableView.visibleCells[1];
    SMProfileViewCell *emailCell = self.tableView.visibleCells[2];

    if ([phoneNumberCell.profileTextField isEqual:textField]) {
        return [self validationCheckOfNumberCharactersFieldFrom:textField inString:string];
    }
    
    if ([emailCell.profileTextField isEqual:textField]) {
        return [self validationCheckOfCharactersEmailFieldFrom:textField string:string inRange:range];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
        
    return YES;
}



#pragma mark - Validation Check for TextField

- (BOOL)validationCheckOfNumberCharactersFieldFrom:(UITextField *) textField inString:(NSString *) string {
    
    NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *words = [string componentsSeparatedByCharactersInSet:set];
    
    if ([words count] > 1) {
        
        return NO;
        
    }
    
    return YES;
    
}

- (BOOL)validationCheckOfCharactersEmailFieldFrom:(UITextField *) textField string:(NSString *) string inRange:(NSRange) range {
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@":;'\"()+-"];
    NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray *words = [string componentsSeparatedByCharactersInSet:set];
    
    if ([words count] > 1 || [newString length] > 50) {
        return NO;
    }
    
    if ([textField.text length] == 0) {
        self.hasAtSign = YES;
    }
    
    if ([textField.text length] == 0 && [string isEqualToString:@"@"]) {
        
        return NO;
        
    } else if ([string isEqualToString:@"@"] && self.hasAtSign) {
        
        self.hasAtSign = NO;
        
    } else if ([string isEqualToString:@"@"] && !self.hasAtSign) {
        
        return NO;
        
    }
    
    return YES;
    
}

#pragma mark - Actions

- (IBAction)nextAction:(UIButton *)sender {
    
    BOOL isEmpty = NO;
    
    for (SMProfileViewCell *cell in self.tableView.visibleCells) {
        
        if ([cell.reuseIdentifier isEqualToString:@"profileCell"]) {
            if ([cell.profileTextField.text isEqualToString:@""]) {
                isEmpty = YES;
            }
        }
    }
    
    if (isEmpty) {
        
        NSString *alertTitle = @"Warning!";
        NSString *alertMessage = @"Please enter your name, phone number and email address";
        
        [self raiseAlertWithTitle:alertTitle andMessage:alertMessage];
        
    } else {
        
        for (UITableViewCell *cell in self.tableView.visibleCells)  {
            [self fillQuoteData:self.quote withDataFromCell:cell];
        }
            
        [self performSegueWithIdentifier:@"location" sender:sender];

    }
    
}

- (void)fillQuoteData:(SMQuoteData *)quoteData withDataFromCell:(UITableViewCell *)cell {
    
    if ([cell isMemberOfClass:[SMProfileViewCell class]]) {
        
        SMProfileViewCell *profileCell = (SMProfileViewCell *)cell;
        
        if ([profileCell.profileLabel.text isEqualToString:@"*Your name:"]) {
            quoteData.clientName = profileCell.profileTextField.text;
        }
        if ([profileCell.profileLabel.text isEqualToString:@"*Your phone number:"]) {
            quoteData.phoneNumber = profileCell.profileTextField.text;
        }
        if ([profileCell.profileLabel.text isEqualToString:@"*Your email address:"]) {
            quoteData.clientEmail = profileCell.profileTextField.text;
        }
        
    } else if ([cell isMemberOfClass:[SMDescriptionViewCell class]]) {
        
        SMDescriptionViewCell *descriptionCell = (SMDescriptionViewCell *)cell;
        quoteData.descriptionText = descriptionCell.descriptionTextField.text;
    }
}

- (void)raiseAlertWithTitle:(NSString *) title andMessage:(NSString *) message {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)cancelAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];

    [self.quote.photosArray addObject:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.quote.photosArray count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    SMAddPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[SMAddPhotoViewCell alloc] init];
    }
    
    [cell configureCellWith:self.quote.photosArray atIndexPath:indexPath.row];

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CGRectGetHeight(collectionView.bounds)* 0.8, CGRectGetHeight(collectionView.bounds) * 0.8);
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self addPhoto];
    } else {
        [self removePhotoAtIndexPath:indexPath];
    }
}

- (void)addPhoto {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:@"Add a photo" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
        imageVC.delegate = self;
        imageVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        imageVC.allowsEditing = YES;
        
        [self presentViewController:imageVC animated:YES completion:nil];
    }];
    
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
        imageVC.delegate = self;
        imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imageVC.allowsEditing = YES;
        
        [self presentViewController:imageVC animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancelAction];
    [controller addAction:libraryAction];
    [controller addAction:cameraAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)removePhotoAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < [self.quote.photosArray count] + 1) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Info" message:@"Remove photo?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.quote.photosArray removeObjectAtIndex:indexPath.row - 1];
            [self.photoCollectionView reloadData];
            
        }];
        
        [controller addAction:cancelAction];
        [controller addAction:okAction];
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
}


#pragma mark - prepare for segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"location"]) {
        
        SMStartEndLocationViewController *dvc = segue.destinationViewController;
        dvc.quote = self.quote;
        
    }
}

@end

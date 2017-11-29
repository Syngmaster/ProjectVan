//
//  SMMapViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "SMMapViewController.h"
#import "SMPin.h"
#import "SMLocationAddress.h"
#import "SMDataManager.h"



@interface SMMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) SMPin *pin;
@property (assign, nonatomic) CLLocationCoordinate2D coordinates;
@property (strong, nonatomic) CLLocationManager *manager;

@end

@implementation SMMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    [self.manager startUpdatingLocation];
    [self.manager requestWhenInUseAuthorization];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.view addGestureRecognizer:longPress];

}


- (void)longPressAction:(UILongPressGestureRecognizer *) sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        if ([self.mapView.annotations count] > 0) {
            [self.mapView removeAnnotations:self.mapView.annotations];
        }
        
        CGPoint location = [sender locationInView:self.view];
        
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:location toCoordinateFromView:self.view];
        
        SMPin *pin = [[SMPin alloc] init];
        pin.coordinate = coordinate;
        self.coordinates = coordinate;
        self.pin = pin;
        [self.mapView addAnnotation:pin];
        
    }
    
}

- (void)dealloc {
    self.mapView.delegate = nil;
    [[SMDataManager sharedInstance].geoCoder cancelGeocode];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self.manager stopUpdatingLocation];
    
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"PinView";
    
    MKAnnotationView *pin = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    
    if (!pin) {
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        pin.draggable = YES;
        pin.image = [UIImage imageNamed:@"map_pin_img.png"];
    } else {
        pin.annotation = annotation;
    }
    
    return  pin;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    __weak SMMapViewController *weakSelf = self;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Info" message:@"Would you like to use your location as a location point?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[SMDataManager sharedInstance] getAddressFromCoordinates:annotation.coordinate onComplete:^(CLPlacemark *placemark, NSString *error) {
                    
                    if (!error) {
                        
                        SMLocationAddress *address = [[SMLocationAddress alloc] initWithPlacemark:placemark];
                        [weakSelf.delegate viewController:weakSelf dismissedWithData:address];
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        
                    } else {
                        
                        [weakSelf.delegate viewController:self dismissedWithData:nil];
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
                
            }];
            
            [controller addAction:cancelAction];
            [controller addAction:okAction];

            [self presentViewController:controller animated:YES completion:nil];

        }
    }
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    

    for (MKAnnotationView *annView in views) {
        
        CGPoint centerNew = annView.center;
        CGPoint center = annView.center;

        centerNew.y = centerNew.y - 15.0;
        annView.center = centerNew;
        

        [UIView animateWithDuration:0.3 animations:^{
            
            annView.center = center;
            
        } completion:nil];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldStat {
    
    if (newState == MKAnnotationViewDragStateStarting) {
        
        
        view.frame = CGRectMake(CGRectGetMinX(view.frame), CGRectGetMinY(view.frame), CGRectGetWidth(view.frame) * 1.4, CGRectGetHeight(view.frame) * 1.4);
        
    } else if (newState == MKAnnotationViewDragStateEnding) {
        
        view.frame = CGRectMake(CGRectGetMinX(view.frame), CGRectGetMinY(view.frame), CGRectGetWidth(view.frame) / 1.4, CGRectGetHeight(view.frame) / 1.4);
    }
    
}

#pragma mark - Actions


- (IBAction)backButtonAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)zoomInAction:(UIButton *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        if (![annotation isMemberOfClass:[MKUserLocation class]]) {
            
            CLLocationCoordinate2D coordinate = annotation.coordinate;
            MKMapPoint center = MKMapPointForCoordinate(coordinate);
            
            static double delta = 15000;
            MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, 2 * delta, 2 * delta);
            
            zoomRect = MKMapRectUnion(rect, zoomRect);
            
            [self.mapView setVisibleMapRect:zoomRect
                                edgePadding:UIEdgeInsetsMake(10, 10, 10, 10)
                                   animated:YES];
            
        }
    }
}

- (IBAction)zoomOutAction:(UIButton *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        if (![annotation isMemberOfClass:[MKUserLocation class]]) {
            
            CLLocationCoordinate2D coordinate = annotation.coordinate;
            MKMapPoint center = MKMapPointForCoordinate(coordinate);
            
            static double delta = 500000;
            MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, 2 * delta, 2 * delta);
            
            zoomRect = MKMapRectUnion(rect, zoomRect);
            
            [self.mapView setVisibleMapRect:zoomRect
                                edgePadding:UIEdgeInsetsMake(10, 10, 10, 10)
                                   animated:YES];
            
        }
    }
    
}

- (IBAction)doneAction:(UIButton *)sender {
    
    __weak SMMapViewController *weakSelf = self;
    
    [[SMDataManager sharedInstance] getAddressFromCoordinates:self.coordinates onComplete:^(CLPlacemark *placemark, NSString *error) {
        
        if (!error) {
            
            SMLocationAddress *address = [[SMLocationAddress alloc] initWithPlacemark:placemark];
            [weakSelf.delegate viewController:weakSelf dismissedWithData:address];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            [weakSelf.delegate viewController:weakSelf dismissedWithData:nil];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}
@end

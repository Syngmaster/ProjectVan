//
//  SMMapViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

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

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    UIBarButtonItem *zoomButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(zoomInLocation:)];
    self.navigationItem.rightBarButtonItems = @[doneButton, zoomButton];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.view addGestureRecognizer:longPress];

}


- (void)zoomInLocation:(UIBarButtonItem *) sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(coordinate);
        
        static double delta = 30000;
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, 2 * delta, 2 * delta);
        
        zoomRect = MKMapRectUnion(rect, zoomRect);
        
        [self.mapView setVisibleMapRect:zoomRect
                            edgePadding:UIEdgeInsetsMake(10, 10, 10, 10)
                               animated:YES];
    }
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

- (void)doneAction:(UIBarButtonItem *) sender {
    
    [[SMDataManager sharedInstance] getAddressFromCoordinates:self.coordinates onComplete:^(CLPlacemark *placemark, NSString *error) {
        
        if (!error) {
            
            SMLocationAddress *address = [[SMLocationAddress alloc] initWithPlacemark:placemark];
            [self.delegate viewController:self dismissedWithData:address];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
        
            [self.delegate viewController:self dismissedWithData:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];

}

- (void)dealloc {
    self.mapView.delegate = nil;
    [[SMDataManager sharedInstance].geoCoder cancelGeocode];
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
        pin.image = [UIImage imageNamed:@"Map_pin.png"];
    } else {
        pin.annotation = annotation;
    }
    
    return  pin;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        if ([annotation isKindOfClass:[MKUserLocation class]]) {

            [[SMDataManager sharedInstance] getAddressFromCoordinates:annotation.coordinate onComplete:^(CLPlacemark *placemark, NSString *error) {
                
                if (!error) {
                    
                    SMLocationAddress *address = [[SMLocationAddress alloc] initWithPlacemark:placemark];
                    [self.delegate viewController:self dismissedWithData:address];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                } else {
                    
                    [self.delegate viewController:self dismissedWithData:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
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


@end

//
//  MapViewController.h
//  CardBump
//
//  Created by 香成 李 on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>
#import <MapKit/MapKit.h>
#import "MJGeocodingServices.h"

// notification
#define AddressChanged		@"addressChanged"

@interface MapViewController : UIViewController <MKMapViewDelegate,MJReverseGeocoderDelegate, MJGeocoderDelegate> {
	MKMapView *mapView;
	MKPointAnnotation *pointAnnotation;
	MKPinAnnotationView* pointAnnotationView;
    
    MKUserLocation *location;
    
    MJReverseGeocoder *reverseGeocoder;
	MJGeocoder *forwardGeocoder;
    AddressComponents *locationAdress;//包含要解析的经度。纬度，街道详情地址

    NSInteger geoCount;//尝试解析3次
}
@property (retain, nonatomic) IBOutlet UIView *noticeView;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKUserLocation *location;
@property (nonatomic, assign) BOOL showSelfLocation;
@property (nonatomic, assign) BOOL enableEditLocation;

- (void)startReverseGeocoder;
- (void)startForwardGeocoder;

-(NSString*)adressString;

@end

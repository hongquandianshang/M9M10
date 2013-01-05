//
//  MapViewController.m
//  CardBump
//
//  Created by 香成 李 on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

@synthesize noticeView;
@synthesize mapView;
@synthesize location;
@synthesize showSelfLocation;
@synthesize enableEditLocation;

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
	[self setMapView:nil];
    [self setNoticeView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[pointAnnotation release];
    [location release];
    [noticeView release];
    
    if (reverseGeocoder) {
		reverseGeocoder.delegate = nil;
		[reverseGeocoder release];
		reverseGeocoder = nil;
	}
    if (forwardGeocoder) {
		forwardGeocoder.delegate = nil;
		[forwardGeocoder release];
		forwardGeocoder = nil;
	}
    if (mapView) {
        mapView.delegate = nil;
        [mapView release];
        mapView = nil;
    }
	
	[locationAdress release];
	[super dealloc];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	noticeView.hidden = YES;
}

- (void)fadeNoticeView {
	[UIView beginAnimations:@"hideNoticeView" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	noticeView.alpha = 0.0;
	[UIView commitAnimations];
}

- (void)recenterMap {
    //NSArray *coordinates = [self.mapView valueForKeyPath:@"annotations.coordinate"];
    CLLocationCoordinate2D my_coordinate=location.coordinate;
    NSValue *value1=[NSValue valueWithBytes:&my_coordinate objCType:@encode(CLLocationCoordinate2D)];
    CLLocationCoordinate2D custom_coordinate=location.coordinate;
    NSValue *value2=[NSValue valueWithBytes:&custom_coordinate objCType:@encode(CLLocationCoordinate2D)];
    NSArray *coordinates=[NSArray arrayWithObjects:value1,value2, nil];
    CLLocationCoordinate2D maxCoord = {-90.0f, -180.0f};
    CLLocationCoordinate2D minCoord = {90.0f, 180.0f};
    for(NSValue *value in coordinates) {
        CLLocationCoordinate2D coord = {0.0f, 0.0f};
        [value getValue:&coord];
        if(coord.longitude > maxCoord.longitude) {
            maxCoord.longitude = coord.longitude;
        }
        if(coord.latitude > maxCoord.latitude) {
            maxCoord.latitude = coord.latitude;
        }
        if(coord.longitude < minCoord.longitude) {
            minCoord.longitude = coord.longitude;
        }
        if(coord.latitude < minCoord.latitude) {
            minCoord.latitude = coord.latitude;
        }
    }
    MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
    region.center.longitude = (minCoord.longitude + maxCoord.longitude) / 2.0;
    region.center.latitude = (minCoord.latitude + maxCoord.latitude) / 2.0;
    region.span.longitudeDelta = maxCoord.longitude - minCoord.longitude;
    region.span.latitudeDelta = maxCoord.latitude - minCoord.latitude;
    [self.mapView setRegion:region animated:YES];
}

- (void)closeViewController{
    if (enableEditLocation) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AddressChanged object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[self adressString], @"address",nil]];
    }
    
    if (reverseGeocoder) {
		reverseGeocoder.delegate = nil;
	}
    
    if (forwardGeocoder) {
		forwardGeocoder.delegate = nil;
	}
    
    if (mapView) {
        mapView.delegate = nil;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	//[self setBackBtnWithModal:YES];
    self.title = @"地理位置";
    UIButton *BackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 51.0, 31.0)];
    [BackBtn setImage:[UIImage imageNamed:@"BackUnClicked.png"] forState:UIControlStateNormal];
    [BackBtn setImage:[UIImage imageNamed:@"BackClicked.png"] forState:UIControlStateHighlighted];
    [BackBtn addTarget:self action:@selector(closeViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *BackBarBtn = [[UIBarButtonItem alloc] initWithCustomView:BackBtn];
    BackBarBtn.style=UIBarButtonItemStyleBordered;
    self.navigationItem.leftBarButtonItem = BackBarBtn;
    //self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(closeViewController)] autorelease];
    
    NSString *versions = [[UIDevice currentDevice] systemVersion];
    if ([versions compare:@"5.0"] != NSOrderedAscending ) { // iOS5.0以上
        
    }
    else{
        [self.navigationController viewWillAppear:YES];
    }
	
    [mapView setShowsUserLocation:self.showSelfLocation];
	
	if (enableEditLocation) {
		self.mapView.showsUserLocation = YES;
		UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
		lpress.minimumPressDuration = 0.5;//按0.5秒响应longPress方法
		lpress.allowableMovement = 10.0;
		[self.mapView addGestureRecognizer:lpress];//m_mapView是MKMapView的实例
		[lpress release];
		[self performSelector:@selector(fadeNoticeView) withObject:nil afterDelay:3];
	} else {
		noticeView.hidden = YES;
	}
    
    if (pointAnnotation) {
        [mapView removeAnnotation:pointAnnotation];
        [pointAnnotation release];
        pointAnnotation = nil;
    }
    pointAnnotation = [[MKPointAnnotation alloc] init];
    [pointAnnotation setCoordinate:location.coordinate];
    pointAnnotation.title = location.title;//@"已放置的大头针";
    pointAnnotation.subtitle = location.subtitle;
    [mapView addAnnotation:pointAnnotation];
    if (enableEditLocation) {
        [mapView selectAnnotation:pointAnnotation animated:YES];
    }
    
    const CLLocationDistance w = 5000;
    self.mapView.region = MKCoordinateRegionMakeWithDistance(location.coordinate, w * 367.0 / 320.0, w);
    //[self recenterMap];
    
    [locationAdress release];
    locationAdress = nil;
    geoCount=0;
    // 需要尽量少的调用google geocoder，否则可能会导致解析失败。
    //[NSObject cancelPreviousPerformRequestsWithTarget:self];//避免fadeNoticeView
    [self performSelector:@selector(startForwardGeocoder) withObject:nil afterDelay:1.0];
}

- (void)setShowSelfLocation:(BOOL)show {
	showSelfLocation = show;
}

- (void)setLocation:(MKUserLocation*)coord {
    [location release];
    location=nil;
    
	location = [coord retain];
}

- (void)longPress:(UIGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        return;
    }
    //坐标转换
    CGPoint touchPoint = [gestureRecognizer locationInView:mapView];
    CLLocationCoordinate2D touchMapCoordinate = [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
    if (pointAnnotation) {
        [mapView removeAnnotation:pointAnnotation];
		[pointAnnotation release];
		pointAnnotation = nil;
    }
    pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = touchMapCoordinate;
	[location setCoordinate:touchMapCoordinate];
	[mapView addAnnotation:pointAnnotation];
	[mapView selectAnnotation:pointAnnotation animated:YES];
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[MKUserLocation class]] && annotation==map.userLocation)
    {
        return nil;
    }
    
    ((MKPointAnnotation *)annotation).title = location.title;//@"已放置的大头针";
	((MKPointAnnotation *)annotation).subtitle = location.subtitle;
    if (!pointAnnotationView) {
        pointAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        pointAnnotationView.pinColor = MKPinAnnotationColorRed;//设置大头针的颜色
        pointAnnotationView.animatesDrop = YES;
        pointAnnotationView.canShowCallout = YES;
        pointAnnotationView.draggable = enableEditLocation;//可以拖动
        pointAnnotationView.rightCalloutAccessoryView = nil;
    }else{
        pointAnnotationView.annotation = location;
    }
    
    return pointAnnotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
	if (newState == MKAnnotationViewDragStateEnding) {
		location = view.annotation;
        
        [locationAdress release];
        locationAdress = nil;
        geoCount=0;
        // 需要尽量少的调用google geocoder，否则可能会导致解析失败。
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(startReverseGeocoder) withObject:nil afterDelay:1.0];
	}
}

#pragma mark MJReverseGeocoder

- (void)startReverseGeocoder {
	if (reverseGeocoder) {
		reverseGeocoder.delegate = nil;
		[reverseGeocoder release];
	}
	
	reverseGeocoder = [[MJReverseGeocoder alloc] initWithCoordinate:location.coordinate];
	reverseGeocoder.delegate=self;
	[reverseGeocoder start];
}

#pragma mark MJReverseGeocoderDelegate methods

-(NSString*)adressString{
    if (locationAdress && [locationAdress isKindOfClass:[AddressComponents class]]) {
        return [NSString stringWithFormat:@"%@ %@, %@, %@", 
								 locationAdress.streetNumber, 
								 locationAdress.route,
								 locationAdress.city,
								 locationAdress.stateCode];
    }
    else{
        return [NSString stringWithFormat:@"%.6f %.6f",location.coordinate.latitude,location.coordinate.longitude];
    }
}

- (void)reverseGeocoder:(MJReverseGeocoder *)geocoder didFindAddress:(AddressComponents *)addressComponents{
    NSLog(@"reverse finished...");
	NSLog(@"streetNumber:%@",addressComponents.streetNumber);//368号
	NSLog(@"route:%@",addressComponents.route);//源深路
	NSLog(@"city:%@",addressComponents.city);//上海市
	NSLog(@"stateCode:%@",addressComponents.stateCode);//上海市
    
    locationAdress=[addressComponents retain];
    location.subtitle=[self adressString];
}


- (void)reverseGeocoder:(MJReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	NSLog(@"MJReverseGeocoder error : %@" , error);
	geocoder.delegate = nil;
    
    if (!locationAdress && geoCount<3) {
        [self performSelector:@selector(startReverseGeocoder) withObject:nil afterDelay:1.0];
        geoCount++;
    }
    else{
        [locationAdress release];
        locationAdress = nil;
    }
}

#pragma mark MJGeocoder

- (void)startForwardGeocoder {
	if (forwardGeocoder) {
		forwardGeocoder.delegate = nil;
		[forwardGeocoder release];
	}
	
	forwardGeocoder = [[MJGeocoder alloc] init];
	forwardGeocoder.delegate=self;
	[forwardGeocoder findLocationsWithAddress:location.subtitle title:nil];
    NSLog(@"geocoder finished...OK");
}

#pragma mark MJGeocoderDelegate

- (void)geocoder:(MJGeocoder *)geocoder didFindLocations:(NSArray *)locations{
	//get first found location, just for demonstration
    if ([locations count]>0) {
        locationAdress = [[locations objectAtIndex:0] retain];
        
        NSString *result = [NSString stringWithFormat:@"%f, %f & %d more", 
                            locationAdress.coordinate.longitude, 
                            locationAdress.coordinate.latitude,
                            [locations count]];
        NSLog(@"geocoder finished...");
        NSLog(@"result:%@",result);
        
        CLLocationCoordinate2D coord;
        coord.latitude = locationAdress.coordinate.latitude;
        coord.longitude = locationAdress.coordinate.longitude;
        
        if (pointAnnotation) {
            [mapView removeAnnotation:pointAnnotation];
            [pointAnnotation release];
            pointAnnotation = nil;
        }
        pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = coord;
        [location setCoordinate:coord];
        [mapView addAnnotation:pointAnnotation];
        [mapView selectAnnotation:pointAnnotation animated:YES];
        
        const CLLocationDistance w = 5000;
        self.mapView.region = MKCoordinateRegionMakeWithDistance(location.coordinate, w * 367.0 / 320.0, w);
        //[self recenterMap];
    }
}

- (void)geocoder:(MJGeocoder *)geocoder didFailWithError:(NSError *)error{
    NSLog(@"MJGeocoder error : %@" , error);
    geocoder.delegate = nil;
    
    if (!locationAdress && geoCount<3) {
        [self performSelector:@selector(startForwardGeocoder) withObject:nil afterDelay:1.0];
        geoCount++;
    }
    else{
        [locationAdress release];
        locationAdress = nil;
    }
}

@end

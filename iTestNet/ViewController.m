//------------------------------------------------------------//
//  ViewController.m
//  iTestNet
//
//  Created by David Owens on 03/09/2015.
//  Copyright (c) 2015 David Owens. All rights reserved.
//------------------------------------------------------------//


#import <MapKit/MapKit.h>
#import "ViewController.h"
#import "LocationEngine.h"
#import "iTest.h"
#import "ping.h"


#pragma mark -

#define kStartLatitude  51.503360    //Only used if the phone is unable to get a location fix. Also used for the simulator
#define kStartLongitude 0.003047     //Only used if the phone is unable to get a location fix. Also used for the simulator


@interface ViewController ()

@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
//@property (nonatomic, strong) MKLocalSearch *localSearch;
//@property (nonatomic, weak) IBOutlet UIBarButtonItem *viewAllButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userCoordinate;
@property(nonatomic, assign) CLLocationCoordinate2D currentCoordinates;
@property(nonatomic, assign) CLLocationSpeed *currentSpeed;

//property for simpleping
@property (strong,nonatomic) NSDate *start;

//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end


@implementation ViewController


@synthesize currentCoordinates = _currentCoordinates;
@synthesize currentSpeed = _currentSpeed;
@synthesize gpsSpeed = _gpsSpeed;
@synthesize location = _location;
@synthesize locationManager = locationManager;
@synthesize imgBlueRock = _imgBlueRock;
@synthesize imgGreenRock = _imgGreenRock;
@synthesize imgOrangeRock = _imgOrangeRock;
@synthesize imgRedRock = _imgRedRock;
@synthesize lblStatus = _lblStatus;
@synthesize indStatus = _indStatus;
@synthesize txtLat = _txtLat;
@synthesize txtLng = _txtLng;
@synthesize txtSpeed = _txtSpeed;
@synthesize lblLatency = _lblLatency;
@synthesize lblWePageSpeed = _webpagespeed;
@synthesize lblDirection = _lbldirection;
@synthesize lblRadioAccessTechnology = _lblRadioAccessTechnology;
@synthesize lblCarrier = _lblCarrier;
@synthesize lblmcc = _lblmcc;
@synthesize lblmnc = _lblmnc;
@synthesize lblDownloadSpeed = _lblDownloadSpeed;
@synthesize lblUploadSpeed = _lblUploadSpeed;
@synthesize btnStart = _btnStart;
@synthesize lblBatt_Percentage = _lblBatt_percentage;
@synthesize lblBatt_Status = _lblBatt_Status;
@synthesize lblTimeStamp = _lblTimeStamp;

//-- app code starts here --//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    // ** Don't forget to add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
    
    //switch screen all the time:-)
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    //set distance filters and required accuracy
    self.locationManager.distanceFilter = 1; // 1 meters
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation; //
    
    [self.locationManager startUpdatingLocation];
    NSLog(@"ready to receive location update call backs");
    
    [NSTimer scheduledTimerWithTimeInterval:60.0
                                     target:self
                                   selector:@selector(onTick:)
                                   userInfo:nil
                                    repeats:YES];

    //NSLog(@"Get location");
    //[self getCurrentLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTick:(NSTimer *)timer {
    //carry out the timed tasks...
    
    [self updateLabel];
    [self UPdateTestResults];
}

-(void) getCurrentLocation {
    // Create a location manager
    self.locationManager = [[CLLocationManager alloc] init];
    // Set a delegate to receive location callbacks
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        //[self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //set distance filters and required accuracy
    self.locationManager.distanceFilter = 1; // 1 meters
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation; //
    
    [self.locationManager startUpdatingLocation];
    NSLog(@"ready to receive location update call backs");
}

-(IBAction)myButtonAction:(id)sender {
    
    NSLog(@"Button Tag is : %li",(long)[sender tag]);
    
    switch ([sender tag]) {
        case 0:
            // Do some think here
            //btnStart.
            break;
        case 1:
            // Do some think here
            break;
        default:
            NSLog(@"Default Message here");
            break;
    }
}


#pragma mark - update lables

- (void) updateLabel {
    UIDevice *myDevice = [UIDevice currentDevice];
    [myDevice setBatteryMonitoringEnabled:YES];
    float batLeft = [myDevice batteryLevel]*100;
    int status=[myDevice batteryState];
    NSLog(@"level:%0.0f",batLeft);
    NSString *status_str;
    
    switch (status){
        case UIDeviceBatteryStateUnplugged:{
            NSLog(@"UnpluggedKey");
            status_str=@"UnPlugged";
            break;
        }
        case UIDeviceBatteryStateCharging:{
            NSLog(@"ChargingKey");
            status_str=@"Charging";
            _lblBatt_Status.text = [NSString stringWithFormat: @"Charging"];
            break;
        }
        case UIDeviceBatteryStateFull:{
            NSLog(@"FullKey");
            status_str=@"BatteryFull";
            break;
        }
            
        default:{
            NSLog(@"UnknownKey");
            status_str=@"Unknown";
            break;
        }
    }
    _lblBatt_Status.text = [NSString stringWithFormat: @"%@", status_str];
    _lblBatt_percentage.text = [NSString stringWithFormat:  @"%0.0f",batLeft];
    
    NSLog(@"Battery status:%@",status_str);
    
    
    //Getting Current Latitude and longitude..
    NSObject *latitude = [NSString stringWithFormat:@"%.05f", locationManager.location.coordinate.latitude];
    NSObject *longitude = [NSString stringWithFormat:@"%.05f", locationManager.location.coordinate.longitude];
    NSObject *speed = [NSString stringWithFormat:@"%.02f" , locationManager.location.speed * 2.25];
    NSObject *direction = [NSString stringWithFormat:@"%.02f" , locationManager.location.course];
    
    //update the timestamp
    NSDate *timestamp = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //0000-00-00 00:00:00
    [dateFormatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
    _lblTimeStamp.text = [NSString stringWithFormat: @"%@", timestamp];
    
    NSLog(@"latitude,longitudes are >> %@, %@, %@", latitude, longitude, speed);
    //_locationlabel.text =  [NSString stringWithFormat:@"%f,%f",longitude,latitude];
    
    _lblStatus.text = @"testing...";
    _txtLat.text = [NSString stringWithFormat: @"%@", latitude];
    _txtLng.text = [NSString stringWithFormat: @"%@", longitude];
    _txtSpeed.text = [NSString stringWithFormat: @"%@", speed];
    _lbldirection.text = [NSString stringWithFormat:@"%@", direction];
    
    CTTelephonyNetworkInfo *networkInfo = [CTTelephonyNetworkInfo new];

    NSString *RadioAccessTechnology = [networkInfo currentRadioAccessTechnology];
    //if (RadioAccessTechnology != nil)
        NSLog(@"Current Radio Access Technology: %@", RadioAccessTechnology);

    // Lets findout the carrier info... //
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    
    // Get carrier name //
    NSString *carrierName = [carrier carrierName];
    NSLog(@"Carrier: %@", carrierName);
    
    // Get mobile country code //
    NSString *mcc = [carrier mobileCountryCode];
    NSLog(@"Mobile Country Code (MCC): %@", mcc);
    
    // Get mobile network code //
    NSString *mnc = [carrier mobileNetworkCode];
    NSLog(@"Mobile Network Code (MNC): %@", mnc);
    
    //---------------------//
    // UPdate Network data //
    //---------------------//
    _lblRadioAccessTechnology.text = [NSString stringWithFormat: @"%@", RadioAccessTechnology];
    _lblCarrier.text = [NSString stringWithFormat: @"%@", carrierName];
    _lblmcc.text = [NSString stringWithFormat: @"%@", mcc];
    _lblmnc.text = [NSString stringWithFormat: @"%@", mnc];
    
    //---------------------------------------------------------//
    // lets update the server and asked for permission to test //
    //---------------------------------------------------------//
    
    // update the images //
    _imgRedRock.hidden = YES;
    _imgOrangeRock.hidden = YES;
    _imgBlueRock.hidden = YES;
    _imgGreenRock.hidden = NO;
    //_lblStatus.text = @"monitoring...";
    _indStatus.hidden = YES;
    
}


#pragma mark - data testing methods
// this routine updates the test location to the server
-(void)UPdateTestResults {
    // Update the accelerometer graph view
    
    //if(!isPaused){
        NSObject *latitude = [NSString stringWithFormat:@"%.05f", locationManager.location.coordinate.latitude];
        NSObject *longitude = [NSString stringWithFormat:@"%.05f", locationManager.location.coordinate.longitude];
        NSObject *speedt = [NSString stringWithFormat:@"%.02f" , locationManager.location.speed * 2.25];
        
        //speedt = locationManager.location.speed * 2.25;
        
        _currentCoordinates = locationManager.location.coordinate;
        _gpsSpeed = [NSString stringWithFormat:@"%.02f" , locationManager.location.speed * 2.25];
        
        //NSLog(@"latitude,longitudes are >> %f, %f, %f", latitude, longitude, speed);
        //NSString *Speed_txt = [NSString stringWithFormat: @"%@", speedt];
        //NSString *Course_txt =[NSString stringWithFormat:@"%.04f", locationManager.location.course];
    
        CTTelephonyNetworkInfo *networkInfo = [CTTelephonyNetworkInfo new];
    
        NSString *RadioAccessTechnology = [networkInfo currentRadioAccessTechnology];

        // Lets findout the carrier info... //
        CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    
        // Get carrier name //
        NSString *carrierName = [carrier carrierName];

        // Get mobile country code //
        NSString *mcc = [carrier mobileCountryCode];
    
        // Get mobile network code //
        NSString *mnc = [carrier mobileNetworkCode];
    
        //---------------------//
        // UPdate Network data //
        //---------------------//
        _lblRadioAccessTechnology.text = [NSString stringWithFormat: @"%@", RadioAccessTechnology];
        _lblCarrier.text = [NSString stringWithFormat: @"%@", carrierName];
        _lblmcc.text = [NSString stringWithFormat: @"%@", mcc];
        _lblmnc.text = [NSString stringWithFormat: @"%@", mnc];
    
    
        //---------------------//
        // UPdate Network data //
        //---------------------//
        _txtLng.text = [NSString stringWithFormat: @"%@", longitude];
        _txtLat.text = [NSString stringWithFormat: @"%@", latitude];
        _txtSpeed.text = [NSString stringWithFormat: @"%@", speedt];
    
    
            //if((locationManager.location.speed * 2.25) > 5.0){
                NSLog(@"Speed %f ",(locationManager.location.speed * 2.25));
    
                //Add GCD code so that refresh managed properly
                dispatch_queue_t downloadQueue = dispatch_queue_create("Agent Post", NULL);

                _imgRedRock.hidden = YES;
                _imgOrangeRock.hidden = YES;
                _imgBlueRock.hidden = NO;
                _imgGreenRock.hidden = YES;
                _lblStatus.text = @"uploading...";
                _indStatus.hidden = NO;
                
                dispatch_async(downloadQueue, ^{
                     NSDictionary *postAgentID = [iTest
                                                  postAgentID: _currentCoordinates
                                                  box_id:ITEST_IMEI
                                                  speed:_txtSpeed.text
                                                  technology:_lblRadioAccessTechnology.text
                                                  carrier:_lblCarrier.text
                                                  mcc:_lblmcc.text
                                                  nmc:_lblmnc.text
                                                  batt_level:_lblBatt_percentage.text
                                                  batt_status:_lblBatt_Status.text
                                                  dir:_lbldirection.text];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //NSString *result_test = [postAgentID valueForKey:@"success"];
                        NSLog(@"success %@",[postAgentID valueForKey:@"success"]);
                        NSLog(@"test: %@",[postAgentID valueForKey:@"test"]);
                        
                        
                        if([[postAgentID valueForKey:@"test"] isEqual:@"yes"]){
                            //if the answer was to test then test
                            NSLog(@"success %@",postAgentID);
                            [self timeToTest];
                            
                        }else{
                            NSLog(@"failed %@",postAgentID);
                        }
                        

                        
                    });
                });  //dispatch_release(downloadQueue);
    
            //}//Speedtest...
        //}//filter
    //}//paused
}


#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // Remember for later the user's current location.
    CLLocation *userLocation = locations.lastObject;
    self.userCoordinate = userLocation.coordinate;
    
    //[manager stopUpdatingLocation]; // We only want one update.
    
    //manager.delegate = nil;         // We might be called again here, even though we
    // called "stopUpdatingLocation", so remove us as the delegate to be sure.
    
    // We have a location now, so start the search.
    //[self startSearch:self.searchBar.text];

    
    //sleep(1000);
    //[NSThread sleepForTimeInterval:1.0f];
    //[self performSelector:@selector(subscribe) withObject:self afterDelay:3.0 ];
    //NSLog(@"Got location %f,%f", newLocation.coordinate.latitude,   newLocation.coordinate.longitude);
    // NSLog(@"%@", [locations lastObject]);
    //[self UPdateTestResults];
    //[self updateLabel];
    _lblStatus.text = @"testing...";
    //Getting Current Latitude and longitude..
    NSObject *latitude = [NSString stringWithFormat:@"%.05f", locationManager.location.coordinate.latitude];
    NSObject *longitude = [NSString stringWithFormat:@"%.05f", locationManager.location.coordinate.longitude];
    NSObject *speed = [NSString stringWithFormat:@"%.02f" , locationManager.location.speed * 2.25];
    NSObject *direction = [NSString stringWithFormat:@"%.02f" , locationManager.location.course];
    //NSObject *timestamp = [NSString stringWithFormat:@"%@ mph" , locationManager.location.timestamp];
    
    NSDate *timestamp = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //0000-00-00 00:00:00
    [dateFormatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
    _lblTimeStamp.text = [NSString stringWithFormat: @"%@", timestamp];
    
    _txtLat.text = [NSString stringWithFormat: @"%@", latitude];
    _txtLng.text = [NSString stringWithFormat: @"%@", longitude];
    _txtSpeed.text = [NSString stringWithFormat: @"%@", speed];
    _lbldirection.text = [NSString stringWithFormat:@"%@", direction];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // report any errors returned back from Location Services
}

-(void)timeToTest{
    //-----------------------//
    // Do a simple ping test //
    //-----------------------//
    
    [SimplePingClient pingHostname:@"54.194.20.117"
                 andResultCallback:^(NSString *latency) {
                     NSLog(@"ping host: 54.194.20.117");
                     NSLog(@"your latency is: %@", latency ? latency : @"unknown");
                     _lblLatency.text = [NSString stringWithFormat: @"%@", latency];
                 }];
    
    //-----------------------//
    //Measure download speed //
    //-----------------------//
    [self downloadtest];
    
    //----------------------//
    //Measure Webpage speed //
    //----------------- ----//
    [self webspeedtest];
    
    //----------------------------//
    //now lets do a upload test //
    //----------------------------//
    [self uploadtest];
    //[self uploadImage:UIImageJPEGRepresentation(imageView.image, 1.0) filename:imageName];
    
}

-(void)postTheResults{
    
    dispatch_queue_t downloadQueue2 = dispatch_queue_create("result poster", NULL);
    dispatch_async(downloadQueue2, ^{
        NSDictionary *postResults =[iTest
                                    postResults: _currentCoordinates
                                    box_id:ITEST_IMEI
                                    speed:_txtSpeed.text
                                    dir:_lbldirection.text
                                    technology:_lblRadioAccessTechnology.text
                                    carrier:_lblCarrier.text
                                    mcc:_lblmcc.text
                                    nmc:_lblmnc.text
                                    batt_level:_lblBatt_percentage.text
                                    batt_status:_lblBatt_Status.text
                                    latency:_lblLatency.text
                                    webpage_time:_webpagespeed.text
                                    down_speed:_lblDownloadSpeed.text
                                    up_speed:_lblUploadSpeed.text];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"colour: %@",[postResults valueForKey:@"colour"]);
            //change background colour
            if([[postResults valueForKey:@"colour"] isEqual:@"red"]){
                //pantone 1787
                self.view.backgroundColor = [[UIColor alloc] initWithRed:0.956 green:0.212 blue:0.298 alpha:1];

                    AudioServicesPlaySystemSound(1053); //negative sound
                
                
            }else if([[postResults valueForKey:@"colour"] isEqual:@"amber"]){
                //pantone 108
                self.view.backgroundColor = [[UIColor alloc] initWithRed:0.996 green:0.859 blue:0 alpha:1];
                for (int i = 0; i < 30; i++){
                    AudioServicesPlaySystemSound(1054); //positive sound
                }
            }else if([[postResults valueForKey:@"colour"] isEqual:@"green"]){
                //pantone 375
                self.view.backgroundColor = [[UIColor alloc] initWithRed:0.569 green:0.788 blue:0.075 alpha:1];
            }
            
            if (postResults[@"success"]) {
                NSLog(@"postResults sucess %@",postResults);
            }else{
                NSLog(@"postResults failed %@",postResults);
            }
        });
    });  //dispatch_release(downloadQueue);
}

#pragma mark - webspeed
-(void)webspeedtest{
    CFTimeInterval startTime = CACurrentMediaTime();
    NSLog(@"read webpage : %.02f", startTime);
    //NSString *targetpage =[NSString stringWithFormat:@"http://www.cettestserver4.co.uk/kepler/kepler.html?%f",startTime];

    NSString *targetpage =[NSString stringWithFormat:@"http://www.cettestserver4.co.uk/kepler/kepler.html"];
    //NSString *targetpage =[NSString stringWithFormat:@"http://www.bbc.co.uk?%f",startTime];
    //NSString *targetpage =[NSString stringWithFormat:@"http://www.itestnet.co.uk/data/100MB.bin?%f",startTime];

    NSURL *keplersUrl = [NSURL URLWithString:targetpage];

    // Send a synchronous request
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:keplersUrl];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                     returningResponse:&response
                                                 error:&error];
    if (error == nil){
        // Parse data here
        CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
        NSLog(@"done webpage : %.02f", CACurrentMediaTime());
        NSLog(@"webpage: %@ : %.02f", keplersUrl, elapsedTime);
        _webpagespeed.text = [NSString stringWithFormat: @"%.05f", elapsedTime*100];
    }else{
        //page error
        NSLog(@"webpage error: %@", error);
        _webpagespeed.text = [NSString stringWithFormat: @"%@", error];
    }
}

#pragma mark - Ping

//@property (strong,nonatomic) NSDate *start;


#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma mark - download & upload tests

-(void)downloadtest{
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("result loader", NULL);
        dispatch_async(downloadQueue, ^{
            CFTimeInterval startTime2 = CACurrentMediaTime();
            NSLog(@"download : %.02f", startTime2);
            NSString *targetpage2 =[NSString stringWithFormat:@"http://www.itestnet.co.uk/data/10MB.bin?%f",startTime2];
    
            NSURL *keplersUrl2 = [NSURL URLWithString:targetpage2];
    
            // Send a synchronous request
            NSURLRequest *urlRequest2 = [NSURLRequest requestWithURL:keplersUrl2];
            NSURLResponse *response2 = nil;
            NSError *error2 = nil;
            NSData *data2 = [NSURLConnection sendSynchronousRequest:urlRequest2
                                          returningResponse:&response2
                                                      error:&error2];

            dispatch_async(dispatch_get_main_queue(), ^{
                if (error2 == nil){
                    // Parse data here
                    CFTimeInterval elapsedTime2 = CACurrentMediaTime() - startTime2;
                    NSString *dlspeed = [NSString stringWithFormat:@"%.0f",80000/elapsedTime2];
                    NSLog(@"dlspeed: %@ : %@", keplersUrl2, dlspeed);
                    _lblDownloadSpeed.text = [NSString stringWithFormat: @"%@", dlspeed];
                
                }else{
                    //page error
                    NSLog(@"download error: %@", error2);
                    _lblDownloadSpeed.text = [NSString stringWithFormat: @"%@", error2];
                }
                [self postTheResults];
        });
    });  //dispatch_release(downloadQueue);
}


-(void)uploadtest{
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("result loader", NULL);
    
    
    dispatch_async(downloadQueue, ^{
        
        CFTimeInterval startTime2 = CACurrentMediaTime();
        NSLog(@"upload : %.02f", startTime2);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]];
            
            // Specify that it will be a POST request
            request.HTTPMethod = @"POST";
            
            // This is how we set header fields
            [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            // Convert your data and set your request's HTTPBody property
            NSString *stringData = @"some data";
            NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
            request.HTTPBody = requestBodyData;
            
            // Create url connection and fire request
            NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            //NSURLRequest *urlRequest2 = [NSURLRequest requestWithURL:keplersUrl2];
            NSURLResponse *response2 = nil;
            NSError *error2 = nil;
            NSData *data2 = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&response2
                                                              error:&error2];
            
            if (error2 == nil){
                // Parse data here
                CFTimeInterval elapsedTime2 = CACurrentMediaTime() - startTime2;
                NSString *upspeed = [NSString stringWithFormat:@"%.0f",800/elapsedTime2];
                NSLog(@"ulspeed : %@", upspeed);
                _lblUploadSpeed.text = [NSString stringWithFormat: @"%@", upspeed];
                
            }else{
                //page error
                NSLog(@"download error: %@", error2);
                _lblUploadSpeed.text = [NSString stringWithFormat: @"%@", error2];
            }
            
        });
    });  //dispatch_release(downloadQueue);
    
}

-(BOOL)uploadFile:(NSData *)imageData filename:(NSString *)filename{
    
        NSString *urlString = @"http://www.itestnet.co.uk/scripts/upload_test.php";
        
        //NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n",filename]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        return ([returnString isEqualToString:@"OK"]);
    }
    
    
    //wait(1000);

@end

//
//  ViewController.m
//  BeaconReceiver
//
//  Created by Narongwate Sangsakul on 4/29/2557 BE.
//  Copyright (c) 2557 Narongwate Sangsakul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize location manager and set ourselves as the delegate
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"52362C17-76E1-404B-AFC6-95DE3B372CA1"];
    NSLog(@"UUID: %@",uuid);
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"com.goffity.test.ibeacon"];
    NSLog(@"myBeaconRegion: %@",self.myBeaconRegion);
    
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
    
    [self.locationManager requestStateForRegion:self.myBeaconRegion];
    
    self.myBeaconRegion.notifyEntryStateOnDisplay = YES;
    
    NSArray *locationServicesAuthStatuses = @[@"Not determined",@"Restricted",@"Denied",@"Authorized"];
    NSArray *backgroundRefreshAuthStatuses = @[@"Restricted",@"Denied",@"Available"];
    
    BOOL monitoringAvailable = [CLLocationManager isMonitoringAvailableForClass:[self.myBeaconRegion class]];
    NSLog(@"Monitoring available: %@", [NSNumber numberWithBool:monitoringAvailable]);
    
    int lsAuth = (int)[CLLocationManager authorizationStatus];
    NSLog(@"Location services authorization status: %@", [locationServicesAuthStatuses objectAtIndex:lsAuth]);
    
    int brAuth = (int)[[UIApplication sharedApplication] backgroundRefreshStatus];
    NSLog(@"Background refresh authorization status: %@", [backgroundRefreshAuthStatuses objectAtIndex:brAuth]);
    
    NSLog(@"Finish viewDidLoad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region { if (state == CLRegionStateInside){ NSLog(@"is in target region"); [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion]; }else{ NSLog(@"is out of target region"); }
    
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    self.statusLabel.text = @"No";
}

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    
    NSLog(@"locationManager");
    // Beacon found!
    self.statusLabel.text = @"Beacon found!";
    
    CLBeacon *foundBeacon = [beacons firstObject];
    
    // You can retrieve the beacon data from its properties
    NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    NSLog(@"UUID found: %@",uuid);
    
    NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    NSLog(@"major: %@",major);
    
    NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
    NSLog(@"minor: %@",minor);
}

@end

//
//  ViewController.h
//  BeaconReceiver
//
//  Created by Narongwate Sangsakul on 4/29/2557 BE.
//  Copyright (c) 2557 Narongwate Sangsakul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

//
//  ViewController.m
//  Motion
//
//  Created by Jay Versluis on 28/10/2015.
//  Copyright © 2015 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"
@import CoreMotion;

@interface ViewController ()
@property (strong, nonatomic) CMMotionActivityManager *manager;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *walkingLabel;
@property (strong, nonatomic) IBOutlet UILabel *runningLabel;
@property (strong, nonatomic) IBOutlet UILabel *cyclingLabel;
@property (strong, nonatomic) IBOutlet UILabel *drivingLabel;
@property (strong, nonatomic) IBOutlet UILabel *standingLabel;
@property (strong, nonatomic) IBOutlet UILabel *notSureLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CMMotionActivityManager *)manager {
    
    if (!_manager) {
        _manager = [[CMMotionActivityManager alloc]init];
    }
    return _manager;
}

- (IBAction)startTracking:(id)sender {
    
    // start tracking motion
    [self.manager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity * _Nullable activity) {
        
        // this block is called for every update
        [self updateMotionLabel:activity];
    }];
}

- (IBAction)stopTracking:(id)sender {
    
    // stop tracking motion events
    [self.manager stopActivityUpdates];
    [self resetLabels];
}

- (void)noMotionAvailable {
    
    // create an alert controller
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"No Motion Events" message:@"Looks like this device doesn't have motion tracking, probably because it doesn't have a motion co-processor. Sorry, skipper!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"What a shame" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    
    // and present it
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)updateMotionLabel:(CMMotionActivity *)activity {
    
    // what are we allegedly doing?
    
    // standing
    if (activity.stationary) {
        self.label1.text = @"You are standing still.";
        self.standingLabel.text = @"STANDING";
    } else {
        self.standingLabel.text = nil;
    }
    
    // walking
    if (activity.walking) {
        self.label1.text = @"You are walking.";
        self.walkingLabel.text = @"WALKING";
    } else {
        self.walkingLabel.text = nil;
    }
    
    // running
    if (activity.running) {
        self.label1.text = @"You are running.";
        self.runningLabel.text = @"RUNNING";
    } else {
        self.runningLabel.text = nil;
    }
    
    // driving
    if (activity.automotive) {
        self.label1.text = @"You're riding in a car";
        self.drivingLabel.text = @"DRIVING";
    } else {
        self.drivingLabel.text = nil;
    }
    
    // cycling
    if (activity.cycling) {
        self.label1.text = @"You're riding a bike!";
        self.cyclingLabel.text = @"CYCLING";
    } else {
        self.cyclingLabel.text = nil;
    }
    
    // in case it's unknown
    if (activity.unknown) {
        self.label1.text = @"I'm not sure what you're doing...";
        self.notSureLabel.text = @"UNKNOWN";
    } else {
        self.notSureLabel.text = nil;
    }
    
    // confidence label
    switch (activity.confidence) {
        case CMMotionActivityConfidenceLow:
            self.label3.text = @"I'm guessing here though...";
            break;
            
            case CMMotionActivityConfidenceMedium:
            self.label3.text = @"I'm pretty sure of it.";
            break;
            
            case CMMotionActivityConfidenceHigh:
            self.label3.text = @"I'm absolutely confident ;-)";
            break;
            
        default:
            self.label1.text = @"Gathering motion...";
            break;
    }
}

- (void)resetLabels {
    
    // reset labels
    self.label1.text = @"Press Start to begin\nMotion Tracking";
    self.label2.text = nil;
    self.label3.text = nil;
    
    self.walkingLabel.text = nil;
    self.runningLabel.text = nil;
    self.standingLabel.text = nil;
    self.notSureLabel.text = nil;
    self.cyclingLabel.text = nil;
    self.drivingLabel.text = nil;
}

@end

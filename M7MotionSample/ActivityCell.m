//
//  ActivityCell.m
//  M7MotionSample
//
//  Created by griffin-stewie on 2013/09/21.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)setActivity:(CMMotionActivity *)activity
{
    if (_activity == nil) {
        _activity = activity;
        
        self.motionTypeLabel.text = [self motionTypeTextFromActivity:_activity];
        self.startDateLabel.text = [[self dateFormatter] stringFromDate:activity.startDate];
        self.confidenceLabel.text = [self confidenceTextFromActivity:_activity];
    }
}

- (NSString *)motionTypeTextFromActivity:(CMMotionActivity *)activity
{
    BOOL result = NO;
    
    result = activity.stationary;
    if (result) {
        return @"stationary";
    }
    
    result = activity.walking;
    if (result) {
        return @"walking";
    }
    
    result = activity.running;
    if (result) {
        return @"running";
    }
    
    result = activity.automotive;
    if (result) {
        return @"automotive";
    }
    
    result = activity.unknown;
    if (result) {
        return @"unknown";
    }
    
    return @"Unknown";
}

- (NSString *)confidenceTextFromActivity:(CMMotionActivity *)activity
{
    switch (activity.confidence) {
        case CMMotionActivityConfidenceHigh:
            return NSLocalizedString(@"High", nil);
            break;
        case CMMotionActivityConfidenceMedium:
            return NSLocalizedString(@"Medium", nil);
            break;
        case CMMotionActivityConfidenceLow:
            return NSLocalizedString(@"Low", nil);
            break;
            
        default:
            return NSLocalizedString(@"Unknown", nil);
            break;
    }
}

- (NSDateFormatter *)dateFormatter
{
    static dispatch_once_t onceToken;
    static NSDateFormatter *_sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[NSDateFormatter alloc] init];
        [_sharedInstance setLocale:[NSLocale systemLocale]];
        [_sharedInstance setDateFormat:@"MM/dd HH:mm:ss"];
    });
    return _sharedInstance;
}

@end

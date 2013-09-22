//
//  FirstViewController.m
//  M7MotionSample
//
//  Created by griffin-stewie on 2013/09/20.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import "StepCounterViewController.h"

@interface StepCounterViewController ()
@property (nonatomic, strong) CMStepCounter *stepCounter;
@end

@implementation StepCounterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)startStopAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    __weak typeof(self) weakSelf = self;
    if ([[[button titleLabel] text] isEqualToString:@"Start"]) {
        if ([CMStepCounter isStepCountingAvailable]) {
            [self fadeAnimationVisible:NO];
            [self updateButton:button started:YES];
            self.stepCountLabel.text = @"0";
            self.stepCounter = [[CMStepCounter alloc] init];
            [self.stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue]
                                                     updateOn:3
                                                  withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
                                                      NSLog(@"%s %ld %@ %@", __PRETTY_FUNCTION__, numberOfSteps, timestamp, error);
                                                      weakSelf.stepCountLabel.text = [@(numberOfSteps) stringValue];
                                                  }];
        }
    } else {
        [self.stepCounter stopStepCountingUpdates];
        [self updateButton:button started:NO];
        
        NSDate *now = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:now];
        [comps setHour:0];
        NSDate *today = [gregorian dateFromComponents:comps];
        
        [self.stepCounter queryStepCountStartingFrom:today
                                                  to:now
                                             toQueue:[NSOperationQueue mainQueue]
                                         withHandler:^(NSInteger numberOfSteps, NSError *error) {
                                             NSLog(@"%s %ld %@", __PRETTY_FUNCTION__, numberOfSteps, error);
                                             [weakSelf fadeAnimationVisible:YES];
                                             weakSelf.totalStepsLabel.text = [@(numberOfSteps) stringValue];
                                         }];
    }
}

- (void)updateButton:(UIButton *)button started:(BOOL)isStarted
{
    NSString *title = @"Start";
    if (isStarted) {
        title = @"Stop";
    }
    
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)fadeAnimationVisible:(BOOL)visible
{
    self.totalStepsTitleLabel.hidden = !visible;
    self.totalStepsLabel.hidden = !visible;
    self.totalStepsTitleLabel.alpha = (CGFloat)!visible;
    self.totalStepsLabel.alpha = (CGFloat)!visible;
    [UIView animateKeyframesWithDuration:0.3
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  self.totalStepsTitleLabel.alpha = (CGFloat)visible;
                                  self.totalStepsLabel.alpha = (CGFloat)visible;
                              } completion:NULL];
}
@end

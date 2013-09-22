//
//  FirstViewController.h
//  M7MotionSample
//
//  Created by griffin-stewie on 2013/09/20.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepCounterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *stepCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalStepsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalStepsLabel;

- (IBAction)startStopAction:(id)sender;

@end

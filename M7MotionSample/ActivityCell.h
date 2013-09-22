//
//  ActivityCell.h
//  M7MotionSample
//
//  Created by griffin-stewie on 2013/09/21.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *motionTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *confidenceLabel;

@property (strong, nonatomic) CMMotionActivity *activity;

@end

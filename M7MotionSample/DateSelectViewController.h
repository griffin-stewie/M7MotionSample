//
//  DateSelectViewController.h
//  M7MotionSample
//
//  Created by Zushi Tatsuya on 2013/09/22.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateSelectViewController : UITableViewController
@property (nonatomic, strong, readonly) NSDate *fromDate;
@property (nonatomic, strong, readonly) NSDate *toDate;
@end

//
//  Logger.h
//  M7MotionSample
//
//  Created by griffin-stewie on 2013/09/22.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject
- (void)appendText:(NSString *)text;
- (void)writeToFile;
@end

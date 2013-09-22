//
//  Logger.m
//  M7MotionSample
//
//  Created by griffin-stewie on 2013/09/22.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import "Logger.h"

@interface Logger ( )
{
    dispatch_queue_t _serialQueue;
}
@property (atomic, strong) NSMutableString *logBuffer;
@property (atomic, strong) NSDate *startDate;
@end


@implementation Logger

- (dispatch_queue_t)serialQueue
{
    if (_serialQueue == NULL) {
        _serialQueue = dispatch_queue_create("net.cyan-stivy.logger", DISPATCH_QUEUE_SERIAL);
    }
    return _serialQueue;
}

- (void)appendText:(NSString *)text
{
    dispatch_sync([self serialQueue], ^{
        if ([self.logBuffer length] == 0) {
            self.logBuffer = [[NSMutableString alloc] init];
            self.startDate = [NSDate date];
        }
        
        [self.logBuffer appendFormat:@"%@\n", text];
    });
}

- (void)writeToFile
{
    dispatch_sync([self serialQueue], ^{
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale systemLocale]];
        [dateFormatter setDateFormat:@"yyyy_MM_dd__HH_mm_ss"];
        NSString *fileName = [[dateFormatter stringFromDate:self.startDate] stringByAppendingString:@".log"];
        NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
        
        NSError *error = nil;
        [self.logBuffer writeToURL:[NSURL fileURLWithPath:filePath]
                        atomically:YES
                          encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
            return ;
        }
        
        self.logBuffer = nil;
        self.startDate = nil;
    });
}
@end

//
//  RollbarKSCrashInstallation.m
//  Rollbar
//
//  Created by Ben Wong on 11/9/17.
//  Copyright © 2017 Rollbar. All rights reserved.
//

#import "RollbarKSCrashInstallation.h"
#import "RollbarKSCrashReportSink.h"
#import <KSCrash/KSCrashInstallation+Private.h>

@implementation RollbarKSCrashInstallation

+ (instancetype)sharedInstance {
    static RollbarKSCrashInstallation *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[RollbarKSCrashInstallation alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    return [super initWithRequiredProperties:[NSArray new]];
}

- (id<KSCrashReportFilter>)sink {
    return [[RollbarKSCrashReportSink alloc] init];
}

- (void)sendAllReports {
    [self sendAllReportsWithCompletion:NULL];
}

- (void)sendAllReportsWithCompletion:(KSCrashReportFilterCompletion)onCompletion {
    [super sendAllReportsWithCompletion:^(NSArray *filteredReports, BOOL completed, NSError *error) {
        if (completed && onCompletion) {
            onCompletion(filteredReports, completed, error);
        }
    }];
}

@end

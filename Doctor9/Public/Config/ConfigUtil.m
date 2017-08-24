//
//  ConfigUtil.m
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "ConfigUtil.h"

@implementation ConfigUtil

#pragma mark - MachineInfo
+ (NSString*)getSysVerison {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString*)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*)getAppBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}


#pragma mark - key & value
+ (NSString*)getVersion {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:VERSION_INFO_KEY];
}

+ (void)setVersion:(NSString *)version {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:version forKey:VERSION_INFO_KEY];
    [userDefaults synchronize];
}

@end

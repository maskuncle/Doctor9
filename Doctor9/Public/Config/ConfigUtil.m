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
+ (NSString*)getAppChannel {
    return @"acupoint";
}

+ (NSString*)getSysVerison {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString*)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*)getAppBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString*)getAppleDeviceID {
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [NSString stringWithFormat:@"I:%@", uuid];
}

#pragma mark - get some obj
+ (NSString *)getMyDataPath{
    NSString *canhePath = [self getDocumentDir];
    NSString *mydatePath = [canhePath stringByAppendingPathComponent:UserName];
    BOOL isDirectory = YES;
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if(![filemanager fileExistsAtPath:mydatePath isDirectory:&isDirectory]) {
        [filemanager createDirectoryAtPath:mydatePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return mydatePath;
}

+(NSString *)getDocumentDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *DocumentDir = [docDir stringByAppendingPathComponent:@"Doctor9/"];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    if(![filemanager fileExistsAtPath:DocumentDir isDirectory:&isDirectory]){
        [filemanager createDirectoryAtPath:DocumentDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"----canheDirBase = %@",DocumentDir);
    return DocumentDir;
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

+ (id)getADimg {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:ADIMG_DATE_STR];
}

+ (void)setADimg:(id)ADimg {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ADimg forKey:ADIMG_DATE_STR];
    [userDefaults synchronize];
}

@end

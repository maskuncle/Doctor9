//
//  ConfigUtil.h
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <Foundation/Foundation.h>

//key
#define UserName            @"10001001"         //[AppDelegate getUserItem].mUsername
#define VERSION_INFO_KEY    @"version_info"

@interface ConfigUtil : NSObject
//MachineInfo
+ (NSString*)getSysVerison;
+ (NSString*)getAppVersion;
+ (NSString*)getAppBuild;

//get action
+ (NSString *)getMyDataPath;
+ (NSString *)getDocumentDir;


//key - value
+ (NSString*)getVersion;
+ (void)setVersion:(NSString* )version;

@end

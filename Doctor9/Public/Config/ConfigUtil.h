//
//  ConfigUtil.h
//  Doctor9
//
//  Created by heguanjie on 17/8/24.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <Foundation/Foundation.h>

//key
#define VERSION_INFO_KEY    @"version_info"

@interface ConfigUtil : NSObject
+ (NSString*)getSysVerison;
+ (NSString*)getAppVersion;
+ (NSString*)getAppBuild;


+ (NSString*)getVersion;
+ (void)setVersion:(NSString* )version;

@end

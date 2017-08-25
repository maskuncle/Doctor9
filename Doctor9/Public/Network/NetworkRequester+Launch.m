//
//  NetworkRequester+Launch.m
//  Doctor9
//
//  Created by heguanjie on 17/8/25.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "NetworkRequester+Launch.h"

@implementation NetworkRequester (Launch)

+(void)getAppStartupAd:(CGFloat)width MainSreenH:(CGFloat)height success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[ConfigUtil getAppChannel] forKey:@"channel"];
    [parameters setObject:@"v3" forKey:@"v"];
    [parameters setObject:[NSString stringWithFormat:@"%f*%f",width, height] forKey:@"s"];
    [parameters setObject:[ConfigUtil getAppleDeviceID] forKey:@"dev"];
    
    [NetworkRequester getWithApi:@"ad/getStartup" parameters:parameters success:successBlock fail:failBlock];
}

+(void)down:(NSString *)api Local_:(NSString *)local completionHandler:(CompletionHandlerBlock)completionHandlerBlock{
    AFHTTPSessionManager *manager = [NetworkRequester AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    NSURL *url = [NSURL URLWithString:api];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:local];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completionHandlerBlock) {
            completionHandlerBlock(response,filePath,error);
        }
    }];
    
    //开始启动任务
    [task resume];
}

@end

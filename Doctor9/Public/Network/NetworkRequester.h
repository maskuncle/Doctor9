//
//  NetworkRequester.h
//  Doctor9
//
//  Created by heguanjie on 17/8/25.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

// 成功，失败 block
typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailBlock)(NSError *error);
//上传、下载的进程
typedef void(^ProgressBlock)(NSProgress * uploadProgress);
//下载地址
typedef NSURL *(^DestinationBlock)(NSURL * targetPath, NSURLResponse * response);
//下载完成
typedef void(^CompletionHandlerBlock)(NSURLResponse * response, NSURL * filePath, NSError * error);
//带Etag的返回
typedef void(^SuccessBlockWithHeader)(id responseObject,id headerDic);

@interface NetworkRequester : NSObject

+ (AFHTTPSessionManager *)AFHTTPSessionManager;
+ (NSString *)urlWithApi:(NSString *)api;

/*! AFNetworking GET -请求设置- 参数形式 */
+ (void)getWithApi:(NSString *)api parameters:(id)parameters success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/*! AFNetworking POST -请求设置- 参数形式 */
+ (void)postWithApi:(NSString *)api parameters:(id)parameters success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/*! AFNetworking POST -请求设置- json body形式 */
+ (void)postWithApi:(NSString *)api body:(id)body success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/*! AFNetworking PUT -请求设置- 参数形式 */
+ (void)putWithApi:(NSString *)api parameters:(id)parameters success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/*! AFNetworking PUT -请求设置- json body形式 */
+ (void)putWithApi:(NSString *)api body:(id)body success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/*! AFNetworking DELETE -请求设置 */
+ (void)deleteWithApi:(NSString *)api parameters:(id)parameters success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

#pragma mark - downLoad
+ (void)downLoadWithApi:(NSString *)api;
#pragma mark - upLoad
+ (void)upLoad1_WithApi:(NSString *)api parameters:(id)parameters imageName:(NSString *)imageName progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
+ (void)upLoad2_WithApi:(NSString *)api parameters:(id)parameters urlStr:(NSString *)urlStr progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

@end

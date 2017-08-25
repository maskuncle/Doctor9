//
//  NetworkRequester.m
//  Doctor9
//
//  Created by heguanjie on 17/8/25.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "NetworkRequester.h"

@implementation NetworkRequester
+ (AFHTTPSessionManager *)AFHTTPSessionManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //"允许碎片”设置为响应串行器
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.requestSerializer.timeoutInterval = 10;//超时时间
        [manager.requestSerializer setValue:@"APPHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"text/xml", nil];
    });
    
    return manager;
}

+ (NSString *)urlWithApi:(NSString *)api {
    return [NSString stringWithFormat:@"%@%@", MAIN_WEB_URL, api];
}

#pragma mark - get
+ (void)getWithApi:(NSString *)api parameters:(id)parameters success:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    AFHTTPSessionManager *manager = [NetworkRequester AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [manager GET:[NetworkRequester urlWithApi:api] parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"operation = %@, error = %@", task, error);
        if (failBlock) {
            failBlock(error);
        }
    }];
}

#pragma mark - post
+ (void)postWithApi:(NSString *)api parameters:(id)parameters success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    AFHTTPSessionManager *manager = [NetworkRequester AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    NSLog(@"--- parameters = %@",parameters);
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key = %@ and obj = %@", key, obj);
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [manager POST:[NetworkRequester urlWithApi:api] parameters:parameters constructingBodyWithBlock:NULL progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"operation = %@, error = %@", task, error);
        if (failBlock) {
            failBlock(error);
        }
    }];
}

+ (void)postWithApi:(NSString *)api body:(id)body success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    AFHTTPSessionManager *manager = [NetworkRequester AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setObject:@"application/json" forKey:@"Content-Type"];
    [headerDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key = %@ and obj = %@", key, obj);
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    NSLog(@"--- body = %@",body);
    NSURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:[NetworkRequester urlWithApi:api] parameters:body error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (failBlock) {
                failBlock(error);
            }
        } else {
            if (successBlock) {
                successBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
}

#pragma mark - put
+ (void)putWithApi:(NSString *)api parameters:(id)parameters success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    AFHTTPSessionManager *manager = [NetworkRequester AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    NSLog(@"--- parameters = %@",parameters);
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    //版本号
    [headerDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key = %@ and obj = %@", key, obj);
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    [manager PUT:[NetworkRequester urlWithApi:api] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"operation = %@, error = %@", task, error);
        if (failBlock) {
            failBlock(error);
        }
    }];
}

+ (void)putWithApi:(NSString *)api body:(id)body success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    AFHTTPSessionManager *manager = [NetworkRequester AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSLog(@"--- body = %@",body);
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    //版本号
    [headerDic setObject:@"application/json" forKey:@"Content-Type"];
    [headerDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key = %@ and obj = %@", key, obj);
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    NSURLRequest *request = [manager.requestSerializer requestWithMethod:@"PUT" URLString:[NetworkRequester urlWithApi:api] parameters:body error:nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (failBlock) {
                failBlock(error);
            }
        } else {
            if (successBlock) {
                successBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
}

#pragma mark - delete
+ (void)deleteWithApi:(NSString *)api parameters:(id)parameters success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    AFHTTPSessionManager *manager = [NetworkRequester AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    NSLog(@"--- parameters = %@",parameters);
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    //版本号
    [headerDic setObject:@"application/json" forKey:@"Content-Type"];
    [headerDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key = %@ and obj = %@", key, obj);
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    [manager DELETE:[NetworkRequester urlWithApi:api] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"operation = %@, error = %@", task, error);
        if (failBlock) {
            failBlock(error);
        }
    }];
}

#pragma mark - downLoad
//上传和下载（下面的代码）仅供参考，直接调用可能满足不了设置条件
+ (void)downLoadWithApi:(NSString *)api{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [NetworkRequester AFHTTPSessionManager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:[NetworkRequester urlWithApi:api]];
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
    }];
    
    //开始启动任务
    [task resume];
}

#pragma mark - upLoad
//第一种方法是通过工程中的UIImage文件进行上传
+ (void)upLoad1_WithApi:(NSString *)api parameters:(id)parameters imageName:(NSString *)imageName progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //2.上传文件
    [manager POST:[NetworkRequester urlWithApi:api] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        UIImage *image = [UIImage imageNamed:imageName];
        NSData *data = UIImagePNGRepresentation(image);
        //这个就是参数
        [formData appendPartWithFileData:data name:@"file" fileName:imageName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
        if (failBlock) {
            failBlock(error);
        }
    }];
}

//第二种是通过URL来获取路径，进入沙盒或者系统相册等等
+ (void)upLoad2_WithApi:(NSString *)api parameters:(id)parameters urlStr:(NSString *)urlStr progress:(ProgressBlock)progressBlock success:(SuccessBlock)successBlock fail:(FailBlock)failBlock{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //2.上传文件
    [manager POST:[NetworkRequester urlWithApi:api] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:urlStr] name:@"file" fileName:urlStr mimeType:@"application/octet-stream" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

@end

//
//  NetworkRequester+Launch.h
//  Doctor9
//
//  Created by heguanjie on 17/8/25.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "NetworkRequester.h"

@interface NetworkRequester (Launch)

+ (void)getAppStartupAd:(CGFloat)width MainSreenH:(CGFloat)height success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

+ (void)down:(NSString *)api Local_:(NSString *)local completionHandler:(CompletionHandlerBlock)completionHandlerBlock;

@end

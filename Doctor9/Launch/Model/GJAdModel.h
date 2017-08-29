//
//  GJAdModel.h
//  Doctor9
//
//  Created by heguanjie on 17/8/28.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "BaseModel.h"

@interface GJAdModel : BaseModel

/** 必传参数 广告图片的网络地址 */
@property (nonatomic, strong) NSString *img_url;
/** 必传参数 广告图片的链接地址 */
@property (nonatomic, strong) NSString *link_url;

/** 选传参数 广告标题和图片etag */
@property (nonatomic, strong) NSString *img_etag;
@property (nonatomic, strong) NSString *title;

@end

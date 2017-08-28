//
//  GJAdModel.h
//  Doctor9
//
//  Created by heguanjie on 17/8/28.
//  Copyright © 2017年 何冠颉. All rights reserved.
//

#import "BaseModel.h"

@interface GJAdModel : BaseModel

@property (nonatomic, strong) NSString *img_url;
@property (nonatomic, strong) NSString *link_url;
@property (nonatomic, strong) NSString *img_etag;
@property (nonatomic, strong) NSString *title;

@end

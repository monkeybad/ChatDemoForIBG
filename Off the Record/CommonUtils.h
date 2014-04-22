//
//  CommonUtils.h
//  Off the Record
//
//  Created by Lee Justin on 14-4-22.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

+ (void)uploadImage:(UIImage*)image withURL:(NSString*)url andCallback:(void (^)(BOOL isSucceed,id responseObj))resultBlk;

@end

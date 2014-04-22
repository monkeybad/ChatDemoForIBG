//
//  CommonUtils.m
//  Off the Record
//
//  Created by Lee Justin on 14-4-22.
//  Copyright (c) 2014年 Chris Ballinger. All rights reserved.
//

#import "CommonUtils.h"
#import "AFNetworking.h"

@implementation CommonUtils

+ (void)uploadImage:(UIImage*)image withURL:(NSString*)url andCallback:(void (^)(BOOL isSucceed,id responseObj))resultBlk
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"anonymous.jpg" mimeType:@"jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        if (resultBlk)
        {
            resultBlk(YES,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (resultBlk)
        {
            resultBlk(NO,nil);
        }
    }];
}

@end

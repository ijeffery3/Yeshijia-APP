//
//  DCWebImageManager.m
//  DCWebPicScrollView
//
//  Created by dengchen on 15/12/7.
//  Copyright © 2015年 name. All rights reserved.
//

#import "DCWebImageManager.h"

@interface DCWebImageManager ()

@property (nonatomic,copy) NSString *cachePath;

@property (nonatomic,strong) NSMutableDictionary *DownloadImageCount;

@end

@implementation DCWebImageManager

+ (instancetype)shareManager {
    
    static DCWebImageManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DCWebImageManager alloc] init];
    });
    
    return  instance;
}

#pragma mark downLoadImage

- (BOOL)LoadDiskCacheWithUrlString:(NSString *)urlSting {
    //取沙盒缓存
    NSData *data = [NSData dataWithContentsOfFile:[self.cachePath stringByAppendingPathComponent:urlSting.lastPathComponent]];
    
    if (data.length > 0 ) {
        
        UIImage *image = [UIImage imageWithData:data];
        
        if (image) {
            [self.webImageData setObject:image forKey:urlSting];
            return YES;
        }else {
            [[NSFileManager defaultManager] removeItemAtPath:[self.cachePath stringByAppendingPathComponent:urlSting.lastPathComponent] error:NULL];
        }
    }
    return NO;
}


- (void)downloadImageWithUrlString:(NSString *)urlSting {
    
    if ([self LoadDiskCacheWithUrlString:urlSting]) {
        return;
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlSting] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [self downLoadImagefinish:data
                                  url:urlSting
                                error:error
                             response:response];
            
        }] resume];
        
    }else {
            
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlSting]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            [self downLoadImagefinish:data
                                  url:urlSting
                                error:connectionError
                             response:response];
        }] ;
        
    }
}



- (void)downLoadImagefinish:(NSData *)data url:(NSString *)urlString error:(NSError *)error response:(NSURLResponse *)response{
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (error) {
        [self repeatDownLoadImage:urlString error:error];
        return ;
    }
    
    if (!image) {
        
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSString *errorData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"错误数据字符串信息:%@\nhttp statusCode(错误代码):%zd",errorData,res.statusCode] code:0 userInfo:nil];
        
        [self repeatDownLoadImage:urlString error:error];
        return ;
    }
    
    //                内存缓存
    [self.webImageData setObject:image forKey:urlString];
    //                沙盒缓存
    [data writeToFile:[self.cachePath stringByAppendingPathComponent:urlString.lastPathComponent] atomically:YES];
 
    
}

- (void)repeatDownLoadImage:(NSString *)urlString error:(NSError *)error{
    
    NSNumber *num = [self.DownloadImageCount objectForKey:urlString];
    NSInteger count = num ? [num integerValue] : 0;
    
    if (self.DownloadImageRepeatCount > count ) {
        
        [self.DownloadImageCount setObject:@(++count) forKey:urlString];
        [self downloadImageWithUrlString:urlString];
        
    }else {
        
        if (self.downLoadImageError) {
            self.downLoadImageError(error,urlString);
        }
    }
}



#pragma mark lazyload

- (NSMutableDictionary *)webImageData {
    if (!_webImageCache) {
        _webImageCache = [[NSMutableDictionary alloc] init];
    }
    return _webImageCache;
}

- (NSMutableDictionary *)DownloadImageCount {
    if (!_DownloadImageCount) {
        _DownloadImageCount = [NSMutableDictionary dictionary];
    }
    return _DownloadImageCount;
}

- (NSString *)cachePath {
    if (!_cachePath) {
        _cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    }
    return _cachePath;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
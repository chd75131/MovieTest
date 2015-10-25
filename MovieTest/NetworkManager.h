//
//  NetworkManager.h
//  MovieTest
//
//  Created by Der on 2015/10/22.
//  Copyright © 2015年 Der. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
@interface NetworkManager : NSObject{
    AFHTTPRequestOperationManager *manager;
}

+ (instancetype)shareManager;
/**
 *  搜尋電影api
 *
 *  @param keyword 搜尋的關鍵字
 *  @param aBlock  結果array
 */
- (void)searchWithKeyword:(NSString *)keyword result:(void (^)(NSArray * aResponse))aBlock;
- (void)cancelAllQuest;
@end

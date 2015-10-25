//
//  NetworkManager.m
//  MovieTest
//
//  Created by Der on 2015/10/22.
//  Copyright © 2015年 Der. All rights reserved.
//
#define BASEURL @"http://api.movies.io/movies"


#import "NetworkManager.h"

@implementation NetworkManager

+ (instancetype)shareManager{
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
- (id)init{
    self = [super init];
    if(self){
        manager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

#pragma mark - http request functions
- (void)searchWithKeyword:(NSString *)keyword result:(void (^)(NSArray * aResponse))aBlock{
    [manager GET:[BASEURL stringByAppendingString:[NSString stringWithFormat:@"/search?q=%@",keyword]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"suc");
        
        aBlock([responseObject objectForKey:@"movies"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"responseObject=%@",operation.responseObject);
        //NSLog(@"Error: %@", error);
    
    }];
}
- (void)cancelAllQuest{
    [manager.operationQueue cancelAllOperations];
}

@end

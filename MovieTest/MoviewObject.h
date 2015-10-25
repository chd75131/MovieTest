//
//  MoviewObject.h
//  MovieTest
//
//  Created by Der on 2015/10/22.
//  Copyright © 2015年 Der. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviewObject : NSObject

@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *year;
@property (nonatomic ,strong)NSString *rating;
@property (nonatomic, strong)NSArray *posters;

@end

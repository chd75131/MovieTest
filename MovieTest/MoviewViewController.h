//
//  MoviewViewController.h
//  MovieTest
//
//  Created by Der on 2015/10/22.
//  Copyright © 2015年 Der. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviewViewController : UIViewController{
    
    __weak IBOutlet UITableView *myTableview;
    NSMutableArray *moduleArr;
    __weak IBOutlet UISearchBar *mySearchBar;
}

@end

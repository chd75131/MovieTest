//
//  MoviewViewController.m
//  MovieTest
//
//  Created by Der on 2015/10/22.
//  Copyright © 2015年 Der. All rights reserved.
//

#import "MoviewViewController.h"
#import "NetworkManager.h"
#import "MoviewObject.h"
#import "MovieTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MoviewViewController ()

@end

@implementation MoviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [myTableview registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MovieTableViewCell"];
    if(!moduleArr)moduleArr = [[NSMutableArray alloc] init];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - PrivateFunc
- (void)questKeyword:(NSString*)keyword{
    [moduleArr removeAllObjects];
   // [NSCharacterSet ]
    [[NetworkManager  shareManager] searchWithKeyword:[keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] result:^(NSArray* result){
        [myTableview setHidden:NO];
        
        if(result){
            NSLog(@"result");
            for(NSDictionary *dic in result){
                MoviewObject *obj = [[MoviewObject alloc] init];
                obj.title = [dic objectForKey:@"title"];
                obj.year = [[dic objectForKey:@"year"] stringValue];
                obj.rating = [NSString stringWithFormat:@"%.01f",[[dic objectForKey:@"rating"] floatValue]];
                NSDictionary *urls = [[dic objectForKey:@"poster"] objectForKey:@"urls"];
                obj.posters = [urls allValues];
                [moduleArr addObject:obj];
            }
        }
        
        [myTableview reloadData];
    }];
}

#pragma mark - uisearchbar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchBar.text length]>0){
        [[NetworkManager shareManager] cancelAllQuest];
        [myTableview setHidden:YES];
        [self questKeyword:searchBar.text];
    }else{
        [myTableview setHidden:NO];
    }
}

#pragma mark - UITableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [moduleArr count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MovieTableViewCell";
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MoviewObject *obj = [moduleArr objectAtIndex:indexPath.row];
    
   // cell.textLabel.text = [NSString stringWithFormat:@"title:%@,year:%@,rating:%@",obj.title,obj.year,obj.rating];
    cell.titleLabel.text = obj.title;
    cell.yearLabel.text = obj.year;
    cell.ratingLabel.text = [NSString stringWithFormat:@"rating:%@",obj.rating];
    
    [cell.myImageview sd_setImageWithURL:[NSURL URLWithString:[obj.posters objectAtIndex:0]]];
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

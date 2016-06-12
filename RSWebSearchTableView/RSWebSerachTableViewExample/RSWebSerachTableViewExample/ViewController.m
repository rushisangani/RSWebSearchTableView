//
//  ViewController.m
//  RSWebSerachTableViewExample
//
//  Created by Rushi Sangani on 12/06/16.
//  Copyright © 2016 Rushi Sangani. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTableView];
}

#pragma mark- TableView Setup

-(void)configureTableView {
    
    __weak typeof(self) weakSelf = self;
    
    // setup tableView
    
    [self.tableView setupTableViewCellConfiguration:^(id cell, id object, NSIndexPath *indexPath) {
        [weakSelf setData:object forCell:cell atIndexPath:indexPath];
        
    } forCellIdentifier:@"cell"];
    
    
    // enable web search
    
    [self.tableView enableWebSearchWithPlaceHolder:@"Search by Name" andActionHandler:^(NSString *searchString) {
        
        /* API call for search string */
        
        [weakSelf getResultsForSearchString:searchString];
    }];
}

#pragma mark- Set data in cell

-(void)setData:(id)data forCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [data valueForKey:@"name"];
}

-(void)getResultsForSearchString:(NSString *)string {
    
    /* send request here */
    
    id response = nil;  /* get response here */
    
    [self didGetResponseFromServer:response];
}

#pragma mark- Success

-(void)didGetResponseFromServer:(id)response {
    
    NSMutableArray *array = response;   // get search results into array
    
    /* inform tableview about search results */
    
    [self.tableView didCompleteSearchWithCompletion:array];
}

#pragma mark- Failure

-(void)didFailToGetResults {
    
    /* inform tableview in failure */
    
    [self.tableView didFailToSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

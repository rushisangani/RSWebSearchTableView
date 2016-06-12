//
// RSWebSearchTableView.h
//
// Copyright (c) Rushi Sangani.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "RSTableViewDataSource.h"
#import "RSSearchBar.h"

@interface RSWebSearchTableView : UITableView

/* properties */

@property (nonatomic, strong) RSSearchBar *searchBar;                        // default search bar

@property (nonatomic, strong) RSTableViewDataSource *tableViewDataSource;    // DataSource for TableView

@property (nonatomic, strong) NSString *noResultFoundMessage;                // message to be shown when no data found

@property (nonatomic, strong) NSMutableArray *dataSourceArray;               // dataSource array for TableView

/* public method */

-(void)setupTableViewCellConfiguration:(UITableViewCellConfiguration)cellConfigurationBlock forCellIdentifier:(NSString *)cellIdentifier;

/* Web search method */

-(void)enableWebSearchWithPlaceHolder:(NSString *)placeHolderString andActionHandler:(void(^)(NSString *searchString))actionHandler;

/* search completion */

-(void)didCompleteSearchWithCompletion:(NSArray *)dataArray;

/* search failure */

-(void)didFailToSearch;


@end

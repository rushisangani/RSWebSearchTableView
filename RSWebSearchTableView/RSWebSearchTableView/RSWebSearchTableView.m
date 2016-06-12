//
// RSWebSearchTableView.m
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

#import "RSWebSearchTableView.h"

static NSString  *kDefaultNoResultFoundMessage = @"No result found.";

@interface RSWebSearchTableView () <UISearchBarDelegate>
{
    NSString *_noResultFoundMessage;
}
@property (nonatomic, strong) UILabel *lblNoResultFound;
@property (nonatomic, strong) NSString *searchPlaceHolder;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, copy) void(^webSearchActionHandler)(NSString *searchString);

@end

@implementation RSWebSearchTableView
@synthesize noResultFoundMessage = _noResultFoundMessage;

#pragma mark- Init

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialize];
}

-(void)initialize {
    
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin| UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    
    // hide empty cells
    self.tableFooterView = [UIView new];
    
    // add indicatorView
    [self addSubview:self.indicatorView];
    
    // set no result found label as background view
    [self setBackgroundView:self.lblNoResultFound];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

#pragma mark- Public methods

-(void)setupTableViewCellConfiguration:(UITableViewCellConfiguration)cellConfigurationBlock forCellIdentifier:(NSString *)cellIdentifier {
    
    self.tableViewDataSource = [[RSTableViewDataSource alloc] initWithArray:self.dataSourceArray cellIdentifer:cellIdentifier andCellConfiguration:cellConfigurationBlock];
    
    self.dataSource = self.tableViewDataSource;
}

-(void)didCompleteSearchWithCompletion:(NSArray *)dataArray {
    
    // stop animation when get result
    [self stopAnimation];
    
    // show no result found message if no data
    if(dataArray.count == 0 || dataArray == nil){
        self.lblNoResultFound.hidden = NO;
    }
    else{
        [self.dataSourceArray addObjectsFromArray:dataArray];
    }
    
    [self reloadData];
}

-(void)didFailToSearch {
    [self stopAnimation];
}

#pragma mark- Web search

-(void)enableWebSearchWithPlaceHolder:(NSString *)placeHolderString andActionHandler:(void (^)(NSString *))actionHandler {
    
    self.searchPlaceHolder = placeHolderString;
    self.webSearchActionHandler = actionHandler;
    
    [self addSearchBarWithPlaceHolder:self.searchPlaceHolder];
}

-(void)addSearchBarWithPlaceHolder:(NSString *)placeHolder {
    
    self.searchBar = [[RSSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kDefaultSearchBarHeight) placeHolder:placeHolder font:nil andTextColor:nil];

    self.searchBar.tintColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.9];
    self.searchBar.barTintColor = kSearchBarTintColor;

    self.searchBar.showsCancelButton = YES;
    self.searchBar.delegate = self;
    
    // add search bar to tableHeaderView
    self.tableHeaderView = self.searchBar;
}

#pragma mark- SearchBar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // remove previous data
    [self.dataSourceArray removeAllObjects];
    [self reloadData];
    
    // hide backgorund label when user is typing
    self.lblNoResultFound.hidden = YES;
    
    if(self.webSearchActionHandler){
        
        [self startAnimation];
        self.webSearchActionHandler(searchText);
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark- Custom methods

-(void)startAnimation {
    [self.indicatorView startAnimating];
}

-(void)stopAnimation {
    [self.indicatorView stopAnimating];
}

#pragma mark- Setter / Getter

-(NSMutableArray *)dataSourceArray{
    
    if(!_dataSourceArray){
        _dataSourceArray = [[NSMutableArray alloc] init];
    }
    return _dataSourceArray;
}

-(void)setNoResultFoundMessage:(NSString *)noResultFoundMessage {
    
    _noResultFoundMessage = noResultFoundMessage;
    self.lblNoResultFound.text = _noResultFoundMessage;
}

-(NSString *)noResultFoundMessage {
    
    if(!_noResultFoundMessage){
        _noResultFoundMessage = kDefaultNoResultFoundMessage;
    }
    return _noResultFoundMessage;
}

-(NSString *)searchPlaceHolder {
    
    if(!_searchPlaceHolder){
        _searchPlaceHolder = @"Search";
    }
    return _searchPlaceHolder;
}

-(UILabel *)lblNoResultFound {
    
    if(!_lblNoResultFound){
        
        _lblNoResultFound = [[UILabel alloc] initWithFrame:self.frame];
        _lblNoResultFound.text = self.noResultFoundMessage;
        _lblNoResultFound.font = [UIFont systemFontOfSize:16];
        _lblNoResultFound.textAlignment = NSTextAlignmentCenter;
        _lblNoResultFound.numberOfLines = 0;
        _lblNoResultFound.hidden = YES;
    }
    return _lblNoResultFound;
}

-(UIActivityIndicatorView *)indicatorView {
    
    if(!_indicatorView){
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}

@end

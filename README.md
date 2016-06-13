# RSWebSearchTableView

A **TableView** with search functionality using API.

**RSWebSearchTableView** with searchBar as a headerView manages all the stuff related to search using API with minimum effort required. No need to write code for creating UITableView and UISearchBar.


![Alt text](/Images/image1.png?raw=true "Alert 1")


## Features

- Enable search in UITableView itself, no need to write code in ViewController.
- Get searched results using delegate method.
- Customizable searchBar.
- Customizable Label when "No Result found".


## How To Use

### RSWebSearchTableView

```objective-c
#pragma mark- TableView Setup

-(void)configureTableView {

    __weak typeof(self) weakSelf = self;

    /* setup tableView */

    [self.tableView setupTableViewCellConfiguration:^(id cell, id object, NSIndexPath *indexPath) {
        
        // set data for TableViewCell

    } forCellIdentifier:@"cell"];


    /* enable web search and specify placeHolder  */

    [self.tableView enableWebSearchWithPlaceHolder:@"Search by Name" andActionHandler:^(NSString *searchString) {

        /* API call for search string */

        [weakSelf getResultsForSearchString:searchString];
    }];
}

-(void)getResultsForSearchString:(NSString *)string {

    /* send request here */

    id response = nil;  /* get response here */

    [self didGetResponseFromServer:response];
}

#pragma mark- Success

-(void)didGetResponseFromServer:(id)response {

    NSMutableArray *array = response;   /* get search results into array */

    /* inform tableview about search results and pass dataArray */

    [self.tableView didCompleteSearchWithCompletion:array];
}

#pragma mark- Failure

-(void)didFailToGetResults {

    /* inform tableview in failure */

    [self.tableView didFailToSearch];
}

#pragma mark- UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    /* get selected object here */
    id selectedObject = [self.tableView.dataSourceArray objectAtIndex:indexPath.row];
}

```

## License

RSWebSearchTableView is released under the MIT license. See LICENSE for details.

//
//  SearchController.h
//  Flickreel
//
//  Created by Austris Landmanis on 16/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "SVPullToRefresh.h"

@interface SearchController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *fetchedSearchResults;

@property (weak, nonatomic) NSNumber *fetchedSearchResultsPage;
@property (weak, nonatomic) NSNumber *fetchedSearchResultsNextPage;
@property (weak, nonatomic) NSNumber *fetchedSearchResultsTotalPages;

@property (nonatomic) BOOL queryInProgress;
@property (weak, nonatomic) NSNumber *nextResultsPage;
@property (weak, nonatomic) NSNumber *lastResultsPage;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

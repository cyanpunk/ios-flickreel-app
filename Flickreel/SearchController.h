//
//  SearchController.h
//  Flickreel
//
//  Created by Austris Landmanis on 16/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"

@interface SearchController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *fetchedSearchResults;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

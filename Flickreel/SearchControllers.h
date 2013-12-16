//
//  SearchController.h
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"
//#import "SuProgress.h"
#import "JDStatusBarNotification.h"
#import "UIViewController+MMDrawerController.h"



@interface SearchControllers : UITableViewController <UIScrollViewDelegate, UISearchBarDelegate, UITableViewDataSource>


#pragma mark - SearchController objects

@property (strong, nonatomic) NSArray *fetchedSearchResults;


#pragma mark - SearchController outlets

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;



@end

//
//  SearchController.m
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import "SearchControllers.h"



@implementation SearchControllers

#pragma mark - SearchController sythesized properties
@synthesize fetchedSearchResults = _fetchedSearchResults;


#pragma mark - SearchController methods

- (void)fetchSearchResults:(NSString *)searchText
{
    NSString *URLString = [[NSString alloc] initWithFormat:@"https://api.themoviedb.org/3/search/movie?query=%@&api_key=207f4a1ca51c8dd2327e5130992bb0b5", searchText];
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *requestURL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    // Set operation outcome logic
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self setFetchedSearchResults:[responseObject objectForKey:@"results"]];
         
         // Check if results contains data
         if ([[self fetchedSearchResults] count] != 0)
         {

         }
         else
         {

         }
         
         [[self tableView] reloadData];
         
         //[JDStatusBarNotification dismissAnimated:YES];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self emptySearchResults];
     }
     ];
    
    // Assign progress to fetch operation
    //[self SuProgressForAFHTTPRequestOperation:operation];
    
    // Start the fetch operation
    //[JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [operation start];
}

- (void)emptySearchResults
{
    [self setFetchedSearchResults:nil];
    [[self tableView] reloadData];
    [JDStatusBarNotification dismissAnimated:YES];
}


#pragma mark - UIViewController methods

// Controller initialization
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // do
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    [self setSearchBar:searchBar];
    
    // Set UISearchBar delegation
    [[self searchBar] setDelegate:self];
    
    // Set UITableView delegation
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];

    [self.navigationItem setTitleView:[self searchBar]];
    
//    [JDStatusBarNotification setDefaultStyle:^JDStatusBarStyle*(JDStatusBarStyle *style) {
//        
//        // advanced properties
//        style.animationType = JDStatusBarAnimationTypeFade;
//        
//        return style;
//    }];
    
//    UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    swipeUpGestureRecognizer.cancelsTouchesInView = NO;
//    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.tableView addGestureRecognizer:swipeUpGestureRecognizer];
//    
//    UISwipeGestureRecognizer *swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    swipeDownGestureRecognizer.cancelsTouchesInView = NO;
//    swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
//    [self.tableView addGestureRecognizer:swipeDownGestureRecognizer];
//    
//    UISwipeGestureRecognizer *swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    swipeLeftGestureRecognizer.cancelsTouchesInView = NO;
//    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.tableView addGestureRecognizer:swipeLeftGestureRecognizer];
//    
//    UISwipeGestureRecognizer *swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    swipeRightGestureRecognizer.cancelsTouchesInView = NO;
//    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.tableView addGestureRecognizer:swipeRightGestureRecognizer];
//    
//    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    [self.tableView addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Do
}

- (void)viewDidAppear:(BOOL)animated
{
    [self openKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self dismissKeyboard];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (void)viewDidUnload
{
    [self dismissKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UISearchBar methods

- (void)openKeyboard
{
    [[self searchBar] becomeFirstResponder];
}

- (void)dismissKeyboard
{
    [[self searchBar] resignFirstResponder];
}

#pragma mark - UIScrollView Delegation methods

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self dismissKeyboard];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self dismissKeyboard];
}


#pragma mark - UISearchBar Delegation methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [JDStatusBarNotification showWithStatus:@"Search in progress..."];
    [self fetchSearchResults:[self.searchBar text]];
    [self dismissKeyboard];
}


#pragma mark - UITableView Delegation methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self fetchedSearchResults] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Movie";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *results = [[self fetchedSearchResults] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[results objectForKey:@"title"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissKeyboard];
    NSLog(@"Did select row at index path: %@", indexPath);
}


@end

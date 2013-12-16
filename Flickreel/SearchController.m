//
//  SearchController.m
//  Flickreel
//
//  Created by Austris Landmanis on 16/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import "SearchController.h"

@implementation SearchController

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
    //[JDStatusBarNotification dismissAnimated:YES];
}

- (void)openKeyboard
{
    [[self searchBar] becomeFirstResponder];
}

- (void)dismissKeyboard
{
    [[self searchBar] resignFirstResponder];
}

#pragma mark - UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self searchBar] setDelegate:self];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self openKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UISearchBar Delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    //[JDStatusBarNotification showWithStatus:@"Search in progress..."];
    [self fetchSearchResults:[self.searchBar text]];
    [self dismissKeyboard];
}


#pragma mark - UITableView Delegate methods

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

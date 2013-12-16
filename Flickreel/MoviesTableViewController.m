//
//  MoviesTableViewController.m
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "ShowMovieViewController.h"

#import "Movie.h"


@implementation MoviesTableViewController

@synthesize fethcedResultsController = _fethcedResultsController;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError * error = nil;
    if (![[self fethcedResultsController] performFetch:&error])
    {
        NSLog(@"Error! %@", error);
        abort();
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - View controller navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
    if ([[segue identifier] isEqualToString:@"addMovie"])
    {
        AddMovieViewController * amvc = (AddMovieViewController *)[segue destinationViewController];
        
        [amvc setDelegate:self];
        
        Movie * newMovie = (Movie *)[NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:[self managedObjectContext]];
        
        [amvc setCurrentMovie:newMovie];
    }
    else if ([[segue identifier] isEqualToString:@"showMovie"])
    {
        ShowMovieViewController * smvc = (ShowMovieViewController *)[segue destinationViewController];
        
        NSIndexPath * indexPath = [[self tableView] indexPathForSelectedRow];
        
        
        Movie * selectedMovie = (Movie *)[[self fethcedResultsController] objectAtIndexPath:indexPath];
        [smvc setCurrentMovie:selectedMovie];
    }
}

#pragma mark - Add Movie view controller delegate

- (void)addMovieViewControllerDidSave
{
    NSManagedObjectContext * managedObjectContext = [self managedObjectContext];
    
    NSError * error;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Error! %@", error);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addMovieViewControllerDidCancel:(Movie *)movieToDelete
{
    NSManagedObjectContext * managedObjectContext = [self managedObjectContext];
    [managedObjectContext deleteObject:movieToDelete];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Table view data source

- (NSFetchedResultsController *)fethcedResultsController
{
    if (_fethcedResultsController != nil)
    {
        return _fethcedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Movie" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"releaseDate" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fethcedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"releaseDate" cacheName:nil];
    
    [_fethcedResultsController setDelegate:self];
    
    return _fethcedResultsController;
}

#pragma mark - Fetched results view controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView * tableView = [self tableView];
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeUpdate:
            {
                Movie * changedMovie = [[self fethcedResultsController] objectAtIndexPath:indexPath];
                UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
                [[cell textLabel] setText:[changedMovie title]];
            }
            break;
        
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    UITableView * tableView = [self tableView];
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

#pragma mark - Table view delegate
   
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fethcedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self fethcedResultsController] sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[[self fethcedResultsController] sections] objectAtIndex:section] name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"movieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Movie * movie = [[self fethcedResultsController] objectAtIndexPath:indexPath];
    
    [[cell textLabel] setText:[movie title]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObjectContext * managedObjectContext = [self managedObjectContext];
        Movie * movieToDelete = [[self fethcedResultsController] objectAtIndexPath:indexPath];
        
        [managedObjectContext deleteObject:movieToDelete];
        
        NSError * error;
        if (![managedObjectContext save:&error])
        {
            NSLog(@"Error! %@", error);
        }
    }
}

#pragma mark - Warning delegate

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

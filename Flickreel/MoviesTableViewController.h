//
//  MoviesTableViewController.h
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddMovieViewController.h"

@interface MoviesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, AddMovieViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController * fethcedResultsController;

@end

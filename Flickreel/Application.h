//
//  Application.h
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NavigationController.h"

//#import "MoviesTableViewController.h"
//#import "DrawerController.h"
#import "SearchController.h"



@interface Application : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) DrawerController *drawerController;
//@property (strong, nonatomic) UINavigationController *navigationController;
//@property (strong, nonatomic) MoviesTableViewController *moviesController;
//@property (strong, nonatomic) SearchController *searchController;

@property (strong, nonatomic) NavigationController *navigationController;
@property (strong, nonatomic) SearchController *searchController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

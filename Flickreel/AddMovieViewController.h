//
//  AddMovieViewController.h
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Movie.h"

@protocol AddMovieViewControllerDelegate;


@interface AddMovieViewController : UIViewController

@property (weak, nonatomic) id <AddMovieViewControllerDelegate> delegate;

@property (strong, nonatomic) Movie * currentMovie;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *releaseDateTextField;

- (IBAction)cancelNewMovie:(id)sender;
- (IBAction)saveNewMovie:(id)sender;

@end

@protocol AddMovieViewControllerDelegate

- (void)addMovieViewControllerDidSave;
- (void)addMovieViewControllerDidCancel:(Movie *)movieToDelete;

@end
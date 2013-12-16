//
//  AddMovieViewController.m
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import "AddMovieViewController.h"
#import "Movie.h"

@interface AddMovieViewController ()

@end

@implementation AddMovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self titleTextField] setText:[[self currentMovie] title]];
    
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    [[self releaseDateTextField] setText:[dateFormat stringFromDate:[[self currentMovie] releaseDate]]];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelNewMovie:(id)sender
{
    [[self delegate] addMovieViewControllerDidCancel:[self currentMovie]];
}

- (IBAction)saveNewMovie:(id)sender
{
    [[self currentMovie] setTitle:[[self titleTextField] text]];
    
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    [[self currentMovie] setReleaseDate:[dateFormat dateFromString:[[self releaseDateTextField] text]]];
    
    [[self delegate] addMovieViewControllerDidSave];
}

@end

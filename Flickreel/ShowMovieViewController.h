//
//  ShowMovieViewController.h
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Movie.h"

@interface ShowMovieViewController : UIViewController

@property (strong, nonatomic) Movie * currentMovie;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;

@end

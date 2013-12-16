//
//  Movie.h
//  Flickreel
//
//  Created by Austris Landmanis on 08/12/13.
//  Copyright (c) 2013 Austris Landmanis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSDate *releaseDate;

@end

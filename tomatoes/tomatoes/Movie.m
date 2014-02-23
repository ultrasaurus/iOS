//
//  Movie.m
//  tomatoes
//
//  Created by Aaron Carambula on 2/20/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *) dictionary {
  self = [super init];
  
  self.title = dictionary[@"title"];
  self.posterUrl = [dictionary valueForKeyPath:@"posters.detailed"];
  
  return self;

}

+ (NSMutableArray *)fakeMovies {
  NSMutableArray *movies = [[NSMutableArray alloc] init];
  
  NSDictionary *lego =
  @{@"title": @"Lego Movie",
    @"posters" : @{@"detailed" : @"…"}};
  Movie *movie = [[Movie alloc] initWithDictionary:lego];
  [movies addObject:movie];
  
  NSDictionary *lastNight =
  @{@"title": @"About Last Night",
    @"posters" : @{@"detailed" : @"…"}};
  movie = [[Movie alloc] initWithDictionary:lastNight];
  [movies addObject:movie];

  return movies;
}

@end
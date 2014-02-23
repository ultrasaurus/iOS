//
//  Movie.h
//  tomatoes
//
//  Created by Aaron Carambula on 2/20/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) int runtimeMinutes;
@property (nonatomic, strong) NSDate *releaseDate;
@property (nonatomic, strong) NSString *actors;
@property (nonatomic, strong) NSString *posterUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)fakeMovies;

@end

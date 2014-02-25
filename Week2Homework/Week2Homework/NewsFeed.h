//
//  NewsFeed.h
//  Week2Homework
//
//  Created by Aaron Carambula on 2/24/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsFeed : NSObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *timeStamp;
@property (strong, nonatomic) NSAttributedString *story;
@property (strong, nonatomic) NSURL *profilePicURL;

- (id)initWithDictionary:(NSDictionary *)feedDictionary;
+ (NSMutableArray *)feedWithArray:(NSMutableArray *)feedArray;
+ (NSMutableArray *)fakeFeedArray;

@end

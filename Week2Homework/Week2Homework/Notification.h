//
//  Notification.h
//  CodePathWeek2
//
//  Created by Aaron Carambula on 2/22/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

@property (nonatomic, strong) NSAttributedString *notifText;
@property (nonatomic, strong) NSString *timeStamp;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSURL *userProfilePicURL;

@property (nonatomic, strong) UIImage *notifIconImage;

- (id)initWithDictionary:(NSDictionary *)notifDictionary;
+ (NSArray *)notifsWithArray:(NSArray *)notifArray;
+ (NSArray *)fakeNotifications;

@end

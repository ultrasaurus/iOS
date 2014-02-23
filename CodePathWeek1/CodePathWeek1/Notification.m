//
//  Notification.m
//  CodePathWeek2
//
//  Created by Aaron Carambula on 2/22/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "Notification.h"

@implementation Notification

- (id)initWithDictionary:(NSDictionary *)notifDictionary {
  self = [super init];
  if (self){
    self.notifText = notifDictionary[@"notifText"];
    self.notifIcon = notifDictionary[@"notifIcon"];
    self.timeStamp = notifDictionary[@"timeStamp"];
    self.userID = notifDictionary[@"userID"];
    self.userProfilePicURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=320", self.userID];
  }
  
  return self;
}

+ (NSArray *)notifsWithArray:(NSArray *)notifArray {
  NSMutableArray *notifs = [[NSMutableArray alloc] init];
  
  for (NSDictionary *dictionary in notifArray) {
    Notification *notif = [[Notification alloc] initWithDictionary:dictionary];
    [notifs addObject:notif];
  }
  
  return notifs;
}

+ (NSArray *)fakeNotifications{
  NSArray *fakeNotificationsDictionaries =
  @[
    @{@"notifText" : @"Mark Zuckerberg liked your post.",
      @"notifIcon" : @"like",
      @"timeStamp" : @"Just now",
      @"userID" : @"4"},
    @{@"notifText" : @"Blaise DiPersia liked your post.",
      @"notifIcon" : @"like",
      @"timeStamp" : @"5 minutes ago",
      @"userID" : @"blaise"}
    ];
  return [Notification notifsWithArray:fakeNotificationsDictionaries];

}

@end

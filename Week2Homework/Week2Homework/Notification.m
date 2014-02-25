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
    self.userID = notifDictionary[@"userID"];
    NSString *profilePicURLString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=320", self.userID];
    self.userProfilePicURL = [NSURL URLWithString:profilePicURLString];
    
    NSString *unstyledNotifText = notifDictionary[@"notifText"];
    NSString *styledNotifText = [self styledHTMLwithHTML:unstyledNotifText];
    self.notifText = [self attributedStringWithHTML:styledNotifText];
    
    
    NSString *notifIcon = notifDictionary[@"notifIcon"];
    NSString *notifIconName = [[NSString alloc] initWithFormat:@"icon-%@-16px.png", notifIcon];
    self.notifIconImage = [UIImage imageNamed:notifIconName];
    
    self.timeStamp = notifDictionary[@"timeStamp"];
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

+ (NSMutableArray *)fakeNotifications{
  NSMutableArray *fakeNotificationsDictionaries =
  @[
    @{@"notifText" : @"<span class='medium'>Mark Zuckerberg</span> liked your post.",
      @"notifIcon" : @"like",
      @"timeStamp" : @"Just now",
      @"userID" : @"4"},
    @{@"notifText" : @"<span class='medium'>Blaise DiPersia</span> liked your post.",
      @"notifIcon" : @"like",
      @"timeStamp" : @"5 minutes ago",
      @"userID" : @"blaise"},
    @{@"notifText" : @"<span class='medium'>Matej Hrescak</span> is nearby.",
      @"notifIcon" : @"nearby",
      @"timeStamp" : @"13 minutes ago",
      @"userID" : @"hrescak"},
    @{@"notifText" : @"<span class='medium'>Jonathon Toon</span> posted in <span class='medium'>iOS Bootcamp for Designers</span>: \"My work here is done.\"",
      @"notifIcon" : @"group-apple",
      @"timeStamp" : @"24 minutes ago",
      @"userID" : @"jonathontoon"},
    @{@"notifText" : @"<span class='medium'>Kyle Meyer</span> commented on your photo: \"This is the Oakland location, right?\"",
      @"notifIcon" : @"comment",
      @"timeStamp" : @"9 hours ago",
      @"userID" : @"kpmeyer"},
    @{@"notifText" : @"<span class='medium'>Matej Hrescak</span> is nearby.",
      @"notifIcon" : @"nearby",
      @"timeStamp" : @"13 minutes ago",
      @"userID" : @"hrescak"},
    @{@"notifText" : @"<span class='medium'>Jonathon Toon</span> posted in <span class='medium'>iOS Bootcamp for Designers</span>: \"My work here is done.\"",
      @"notifIcon" : @"group-apple",
      @"timeStamp" : @"24 minutes ago",
      @"userID" : @"jonathontoon"},
    @{@"notifText" : @"<span class='medium'>Kyle Meyer</span> commented on your photo: \"This is the Oakland location, right?\"",
      @"notifIcon" : @"comment",
      @"timeStamp" : @"9 hours ago",
      @"userID" : @"kpmeyer"}
    ];
  return [Notification notifsWithArray:fakeNotificationsDictionaries];

}

- (NSString *)styledHTMLwithHTML:(NSString *)HTML {
  NSString *style = @"<meta charset=\"UTF-8\"><style> body { font-family: 'HelveticaNeue'; font-size: 14px; line-height: 16px; } .medium {font-family: 'HelveticaNeue-Medium'; }</style>";
  
  return [NSString stringWithFormat:@"%@%@", style, HTML];
}

- (NSAttributedString *)attributedStringWithHTML:(NSString *)HTML {
  NSDictionary *options = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType };
  return [[NSAttributedString alloc] initWithData:[HTML dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:NULL error:NULL];
}

@end

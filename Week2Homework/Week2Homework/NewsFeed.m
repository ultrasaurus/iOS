//
//  NewsFeed.m
//  Week2Homework
//
//  Created by Aaron Carambula on 2/24/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "NewsFeed.h"

@implementation NewsFeed

- (id)initWithDictionary:(NSDictionary *)feedDictionary {
  self = [super init];
  if (self) {
    self.userID = feedDictionary[@"userID"];
    self.userName = feedDictionary[@"userName"];
    self.timeStamp = feedDictionary[@"timeStamp"];
    NSString *unstyledStoryText = feedDictionary[@"story"];
    NSString *styledStoryText = [self styledHTMLwithHTML:unstyledStoryText];
    self.story = [self attributedStringWithHTML:styledStoryText];

    NSString *profilePicURLString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=320", self.userID];
    self.profilePicURL = [NSURL URLWithString:profilePicURLString];
  }
  return self;
}

+ (NSMutableArray *)feedWithArray:(NSMutableArray *)feedArray{
  NSMutableArray *stories = [[NSMutableArray alloc] init];
  for (NSDictionary *dictionary in feedArray){
    NewsFeed *story = [[NewsFeed alloc] initWithDictionary:dictionary];
    [stories addObject:story];
  }
  return stories;
}

+ (NSMutableArray *)fakeFeedArray{
  NSMutableArray *fakeFeedDictionaries =
  @[
    @{@"userID":@"4",
      @"userName":@"Mark Zuckerberg",
      @"timeStamp":@"Just now",
      @"story":@"lulz. <span class=\"medium\">Matej</span>, put that cookie down!"
      },
    @{@"userID":@"blaise",
      @"userName":@"Blaise DiPersia",
      @"timeStamp":@"3 minutes ago",
      @"story":@"This is where I talk about my feelings. <span class=\"medium\">Facebook</span> is an amazing place."
      },
    @{@"userID":@"kpmeyer",
      @"userName":@"Kyle Meyer",
      @"timeStamp":@"42 minutes ago",
      @"story":@"A german designer did all of the branding and posters for <span class=\"medium\">Umami Bar</span> but I can't remember his name for the life of me. Anyone?."
      },
    @{@"userID":@"blaise",
      @"userName":@"Blaise DiPersia",
      @"timeStamp":@"3 minutes ago",
      @"story":@"This is where I talk about my feelings. <span class=\"medium\">Facebook</span> is an amazing place."
      }
  ];
  return [NewsFeed feedWithArray:fakeFeedDictionaries];
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

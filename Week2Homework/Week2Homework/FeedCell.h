//
//  FeedCell.h
//  Week2Homework
//
//  Created by Aaron Carambula on 2/25/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell

@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UILabel *timeStamp;
@property (strong, nonatomic) UILabel *storyText;
@property (strong, nonatomic) UIImageView *profilePic;

@end

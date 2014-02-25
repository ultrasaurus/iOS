//
//  FeedViewController.m
//  Week2Homework
//
//  Created by Aaron Carambula on 2/24/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedCell.h"
#import "NewsFeed.h"
#import "UIImageView+AFNetworking.h"

@interface FeedViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *stories;

@end

@implementation FeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"News Feed";

      self.stories = [NewsFeed fakeFeedArray];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  [self.view addSubview:self.tableView];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  [self.tableView registerClass:[FeedCell class] forCellReuseIdentifier:@"FeedCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private tableView Methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  FeedCell *feedCell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
  NewsFeed *story = self.stories[indexPath.row];
  
  feedCell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  [feedCell.profilePic setImageWithURL:story.profilePicURL];
  feedCell.userName.text = story.userName;
  feedCell.timeStamp.text = story.timeStamp;
  feedCell.storyText.attributedText = story.story;
  [feedCell.storyText sizeToFit];
  return feedCell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 200;
}

@end

//
//  MoviesViewController.m
//  tomatoes
//
//  Created by Aaron Carambula on 2/20/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "MoviesViewController.h"
#import "Movie.h"

@interface MoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *movies;
@property (strong, nonatomic) NSMutableArray *expanded;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    self.movies = [Movie fakeMovies];
      
//      self.expanded = [@[@NO], @[@NO]];
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//  self.tableView.rowHeight = 100;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

  Movie *movie = self.movies[indexPath.row];
  cell.textLabel.text = movie.title;
  cell.textLabel.numberOfLines = 0;
  
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
//  self.expanded = !self.expanded;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if(indexPath.row == 0) {
    return 80;
  }else{
    return 120;
  }
}

@end

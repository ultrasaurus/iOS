//
//  AppDelegate.m
//  Week2Homework
//
//  Created by Aaron Carambula on 2/22/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "AppDelegate.h"
#import "NotificationsViewController.h"
#import "FeedViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  UIColor *fbBar = [UIColor colorWithRed:(61/255.0) green:(95/255.0) blue:(152/255.0) alpha:1];
  NSDictionary *navAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
  

  NotificationsViewController *nvc = [[NotificationsViewController alloc] init];
  UINavigationController *nvcNavController = [[UINavigationController alloc] initWithRootViewController:nvc];
  
  [[UINavigationBar appearance] setTitleTextAttributes:navAttributes];
  nvcNavController.navigationBar.barTintColor = fbBar;
  nvcNavController.navigationBar.tintColor = [UIColor whiteColor];
  nvcNavController.navigationBar.barStyle =UIBarStyleBlackTranslucent;
  
  FeedViewController *fvc = [[FeedViewController alloc] init];
  UINavigationController *fvcNavController = [[UINavigationController alloc] initWithRootViewController:fvc];

  fvcNavController.navigationBar.barTintColor = fbBar;
  fvcNavController.navigationBar.tintColor = [UIColor whiteColor];
  fvcNavController.navigationBar.barStyle =UIBarStyleBlackTranslucent;
  

  
  UITabBarController *tabBarController = [[UITabBarController alloc] init];
  
  tabBarController.viewControllers = [NSArray arrayWithObjects:
                                      fvcNavController,
                                      nvcNavController,
                                      nil];
  
  [[UITabBar appearance] setTintColor:[UIColor colorWithRed:86/255.0 green:148/255.0 blue:253/255.0 alpha:1]];
  [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];

  fvcNavController.tabBarItem = [[UITabBarItem alloc]
                                 initWithTitle:NSLocalizedString(@"News Feed", @"News Feed")
                                 image:[UIImage imageNamed:@"i_tab_newsfeed.png"]
                                 tag:3];
  nvcNavController.tabBarItem = [[UITabBarItem alloc]
                                 initWithTitle:NSLocalizedString(@"Notifications", @"Notifications")
                                 image:[UIImage imageNamed:@"i_tab_notifications.png"]
                                 tag:3];
  
  self.window.rootViewController = tabBarController;

  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

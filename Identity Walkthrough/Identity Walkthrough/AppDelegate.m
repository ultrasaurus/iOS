//
//  AppDelegate.m
//  Identity Walkthrough
//
//  Created by Aaron Carambula on 2/13/14.
//  Copyright (c) 2014 Aaron Carambula. All rights reserved.
//

#import "AppDelegate.h"
#import "PeopleViewController.h"
#import "ProfileViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    // Override point for customization after application launch.
  
  PeopleViewController *peopleVC = [[PeopleViewController alloc] init];
  UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:peopleVC];
  self.window.rootViewController = nvc;
  nvc.navigationBar.barTintColor = [UIColor colorWithRed:(61/255.0) green:(95/255.0) blue:(152/255.0) alpha:1];
  nvc.navigationBar.tintColor = [UIColor whiteColor];
  
  NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];

  [[UINavigationBar appearance] setTitleTextAttributes:attributes];


  UITabBarController *tabBarController = [[UITabBarController alloc] init];
  
  UIViewController *controller1 = [[PeopleViewController alloc] init];
  UIViewController *controller2 = [[ProfileViewController alloc] init];
  
  tabBarController.viewControllers = [NSArray arrayWithObjects:
                                      controller1,
                                      controller2,
                                      nil];
  
  // set as the root window
  [self.window addSubview:[tabBarController view]];

//  self.window.rootViewController = tabBarController;

  
  
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

//
//  AppDelegate.m
//  Sqlite
//
//  Created by Nirav on 9/1/16.
//  Copyright © 2016 Nirav. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
//Database start
#import "DBController.h"
#import "VIdbConfig.h"
//Database end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    sqlite3 *db1;
    if (sqlite3_open([[self.databaseURL path] UTF8String], &db1) == SQLITE_OK) {
        const char* key = [@"temp" UTF8String];
        sqlite3_key(db1, key, (int)strlen(key));
        if (sqlite3_exec(db1, (const char*) "SELECT count(*) FROM sqlite_master;", NULL, NULL, NULL) == SQLITE_OK) {
            NSLog(@"Password is correct, or a new database has been initialized");
        } else {
            NSLog(@"Incorrect password!");
        }
        sqlite3_close(db1);
    }
    
    db = [VIDatabase databaseWithName:kDBName];
    if (![db open])
    {
        NSLog(@"Could not open db.");
    }
    else
    {
        NSLog(@"Open db.");
        [db createtable];
    }
    
    /** Insert values in user table **/
    [[DBController sharedinstence] insertUserWhileLoop:1];
    
    /** Retrive values from user table **/
    [[DBController sharedinstence] getUser:1 self:self];
    
    //Below code is to navigate view once app is lode first time
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    ViewController *objView=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *objNav=[[UINavigationController alloc]initWithRootViewController:objView];
    self.window.rootViewController = objNav;
    [self.window makeKeyAndVisible];
    
    //Set style of statusbar for all screens
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    return YES;
}

#pragma mark - DB encrypt

- (NSURL *)databaseURL
{
    NSArray *URLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *directoryURL = [URLs firstObject];
    NSURL *databaseURL = [directoryURL URLByAppendingPathComponent:kDBName];
    return  databaseURL;
}

- (BOOL)databaseExists {
    BOOL exists = NO;
    NSError *error = nil;
    exists = [[self databaseURL] checkResourceIsReachableAndReturnError:&error];
    if (exists == NO && error != nil)
    {
        NSLog(@"Error checking availability of database file: %@", error);
    }
    return exists;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

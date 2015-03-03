//
//  AppDelegate.m
//  CBLSample
//
//  Created by Danil Nikiforov on 02.03.15.
//  Copyright (c) 2015 Danil. All rights reserved.
//

#import "AppDelegate.h"
#import <CouchbaseLite/CouchbaseLite.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    return YES;
}

+ (CBLDatabase *)database{
    NSError* error;
    CBLManager  * manager  = [CBLManager sharedInstance];
    CBLDatabase* db = [manager databaseNamed:@"db-name" error: &error];
    return db;
}

@end

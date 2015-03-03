//
//  AppDelegate.h
//  CBLSample
//
//  Created by Danil Nikiforov on 02.03.15.
//  Copyright (c) 2015 Danil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBLDatabase;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (CBLDatabase *) database;

@end


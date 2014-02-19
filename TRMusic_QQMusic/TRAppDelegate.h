//
//  TRAppDelegate.h
//  TRMusic_QQMusic
//
//  Created by forever on 14-2-19.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

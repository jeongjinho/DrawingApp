//
//  AppDelegate.h
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 1. 24..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


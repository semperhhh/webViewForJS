//
//  AppDelegate.h
//  WebViewAndJS
//
//  Created by zhangpenghui on 2018/11/28.
//  Copyright © 2018年 zph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


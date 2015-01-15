//
//  AppDelegate.h
//  puzzle
//
//  Created by zhuang chaoxiao on 14-11-28.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//


/*
 http://blog.csdn.net/nyh1006/article/details/41948777
 */

#import <UIKit/UIKit.h>


#define DEVICE_VER    ([[[UIDevice currentDevice] systemVersion] floatValue])

#define DEVICE_VER_7  (((DEVICE_VER >=7.0) && (DEVICE_VER <8.0)) ?YES:NO)
#define DEVICE_VER_8  (((DEVICE_VER >=8.0) && (DEVICE_VER <9.0)) ?YES:NO)
#define DEVICE_VER_OVER_7 ((DEVICE_VER >=7.0)?YES:NO)

#define ADMOB_ID  @"ca-app-pub-3058205099381432/8591538347"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


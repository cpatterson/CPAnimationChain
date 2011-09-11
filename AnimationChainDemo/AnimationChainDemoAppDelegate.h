//
//  AnimationChainDemoAppDelegate.h
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnimationChainDemoViewController;

@interface AnimationChainDemoAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet AnimationChainDemoViewController *viewController;

@end

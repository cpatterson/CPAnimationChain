//
//  AnimationChainDemoViewController.h
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationChainDemoViewController : UIViewController 
@property (nonatomic, retain) IBOutlet UIImageView *frog;
@property (nonatomic, retain) IBOutlet UIView *alertView;

- (IBAction)animateButtonTapped:(id)sender;
- (IBAction)dismissAlertView;

@end

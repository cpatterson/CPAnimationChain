//
//  AnimationChainDemoViewController.h
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationChainDemoViewController : UIViewController {
	UIImageView *frog;
}

@property (nonatomic, retain) IBOutlet UIImageView *frog;

- (IBAction)animateButtonTapped:(id)sender;

@end

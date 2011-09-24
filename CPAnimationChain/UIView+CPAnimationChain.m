//
//  UIView+CPAnimationChain.m
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

#import "UIView+CPAnimationChain.h"
#import "CPAnimationChain.h"
#import "CPAnimationLink.h"

@implementation UIView (UIView_CPAnimationChain)

-(void)animateWithChain:(CPAnimationChain*)chain
{
	[chain animateView:self];
}

-(void)animateWithLink:(CPAnimationLink*)link
{
	link.view = self;
	[link animate];
}

@end

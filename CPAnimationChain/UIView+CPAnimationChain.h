//
//  UIView+CPAnimationChain.h
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

#include "CPAnimationChain.h"

@interface UIView (CPAnimationChain)

-(void)animateWithChain:(CPAnimationChain*)chain;
-(void)animateWithLink:(CPAnimationLink*)link;

@end

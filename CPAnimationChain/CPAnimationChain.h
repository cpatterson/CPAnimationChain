//
//  CPAnimationChain.h
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CPAnimationLink;

@interface CPAnimationChain : NSObject
{
	NSMutableArray*	_links;
	UIView*			_view;
}
@property (nonatomic, readonly) NSArray* links;
@property (nonatomic, assign)	UIView*	 view;

+(CPAnimationChain*)chain;
+(CPAnimationChain*)chainWithLink:(CPAnimationLink*)link;
+(CPAnimationChain*)chainWithLinkArray:(NSArray*)linkArray;
+(CPAnimationChain*)chainWithLinks:(CPAnimationLink*)firstLink, ... NS_REQUIRES_NIL_TERMINATION;

-(NSInteger)length;
-(CPAnimationLink*)linkAtIndex:(NSInteger)index;
-(CPAnimationLink*)firstLink;
-(CPAnimationLink*)lastLink;
-(void)insertLink:(CPAnimationLink*)link atIndex:(NSInteger)index;
-(void)addLink:(CPAnimationLink*)link;
-(void)removeLink:(CPAnimationLink*)link;

-(void)animateView:(UIView*)view;

@end

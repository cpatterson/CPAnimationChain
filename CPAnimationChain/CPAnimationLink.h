//
//  CPAnimationLink.h
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

@class CPAnimationChain;

typedef void(^CPLinkAnimationBlock)(void);
typedef void(^CPLinkCompletionBlock)(BOOL finished);

@interface CPAnimationLink : NSObject <NSCopying>
{
	// parameters passed to UIView animateWithDuration:animations:completion:
	NSTimeInterval			_duration;
	NSTimeInterval			_delay;
	UIViewAnimationOptions	_options;
	CPLinkAnimationBlock	_animation;
	CPLinkCompletionBlock	_completion;
	CPAnimationLink*		_nextLink;
	UIView*					_view;
}
@property (nonatomic) NSTimeInterval			duration;
@property (nonatomic) NSTimeInterval			delay;
@property (nonatomic) UIViewAnimationOptions	options;
@property (copy) CPLinkAnimationBlock			animation;
@property (copy) CPLinkCompletionBlock			completion;
@property (nonatomic, retain) UIView*			view;

- (void)animate;

@end

@interface CPFadeLink : CPAnimationLink
@property (nonatomic) CGFloat alpha;
+(CPFadeLink*)fadeWithDuration:(NSTimeInterval)dur alpha:(CGFloat)alpha;
@end

@interface CPScaleByLink : CPAnimationLink
@property (nonatomic) CGFloat scale;
+(CPScaleByLink*)scaleWithDuration:(NSTimeInterval)dur by:(CGFloat)scale;
@end

@interface CPScaleToLink : CPAnimationLink
@property (nonatomic) CGFloat scale;
+(CPScaleToLink*)scaleWithDuration:(NSTimeInterval)dur to:(CGFloat)scale;
@end

@interface CPMoveByLink : CPAnimationLink
@property (nonatomic) CGPoint delta;
+(CPMoveByLink*)moveWithDuration:(NSTimeInterval)dur by:(CGPoint)d;
@end

@interface CPMoveToLink : CPAnimationLink
@property (nonatomic) CGPoint destination;
+(CPMoveToLink*)moveWithDuration:(NSTimeInterval)dur to:(CGPoint)dest;
@end

@interface CPRotateByLink : CPAnimationLink
@property (nonatomic) CGFloat angle;
+(CPRotateByLink*)rotateWithDuration:(NSTimeInterval)dur by:(CGFloat)angle;
@end

@interface CPRotateToLink : CPAnimationLink
@property (nonatomic) CGFloat angle;
+(CPRotateToLink*)rotateWithDuration:(NSTimeInterval)dur to:(CGFloat)angle;
@end

@interface CPRotate360Link : CPAnimationLink
+(CPRotate360Link*)rotateWithDuration:(NSTimeInterval)dur;
@end

@interface CPAndLink : CPAnimationLink
@property (nonatomic, retain) NSMutableArray* links;
+(CPAndLink*)andLinks:(CPAnimationLink*)firstLink, ... NS_REQUIRES_NIL_TERMINATION;
-(void)addLink:(CPAnimationLink*)link;
-(void)removeLink:(CPAnimationLink*)link;
@end



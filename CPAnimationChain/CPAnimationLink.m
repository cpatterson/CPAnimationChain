//
//  CPAnimationLink.m
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

#import "CPAnimationLink.h"
#import "CPAnimationChain.h"

@implementation CPAnimationLink

@synthesize duration=_duration;
@synthesize delay=_delay;
@synthesize options=_options;
@synthesize animation=_animation;
@synthesize completion=_completion;
@synthesize view=_view;

- (void)initAnimation
{
	// Subclasses must override
	self.animation	= ^{};
}

- (id)init
{
    self = [super init];
    if (self) 
	{
        // Init to one second of animating nothing.
		self.duration	= 1.0;
		self.delay		= 0.0;
		self.options	= 0;
		self.completion	= ^(BOOL finished){
//			NSLog(@"%@ completed", NSStringFromClass([self class]));
		};
		[self initAnimation];
    }
    
    return self;
}

- (void)animate
{
	[UIView animateWithDuration:self.duration
						  delay:self.delay
						options:self.options
					 animations:self.animation
					 completion:^(BOOL finished) {
						 self.completion(finished);
						 if (_nextLink)
							 [_nextLink animate];
					 }];
}

-(void)propCopyTo:(CPAnimationLink*)link
{
	link.duration	= self.duration;
	link.delay		= self.delay;
	link.options	= self.options;
	link.animation	= self.animation;
	link.completion = self.completion;
}

-(id)copyWithZone:(NSZone *)zone
{
	CPAnimationLink* copy = [[CPAnimationLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

@end

#pragma mark -

@implementation CPFadeLink

@synthesize alpha=_alpha;

+(CPFadeLink*)fadeWithDuration:(NSTimeInterval)dur alpha:(CGFloat)alpha
{
	CPFadeLink* fadeLink = [[[CPFadeLink alloc] init] autorelease];
	fadeLink.duration = dur;
	fadeLink.alpha = alpha;
	return fadeLink;
}

- (void)initAnimation
{
	self.animation	= ^{
		self.view.alpha = self.alpha;
	};
}

-(void)propCopyTo:(CPFadeLink*)link
{
	[super propCopyTo:link];
	link.alpha = self.alpha;
}

-(id)copyWithZone:(NSZone *)zone
{
	CPFadeLink* copy = [[CPFadeLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

@end

#pragma mark -

@implementation CPScaleByLink

@synthesize scale=_scale;

+(CPScaleByLink*)scaleWithDuration:(NSTimeInterval)dur by:(CGFloat)scale
{
	CPScaleByLink* scaleBy = [[[CPScaleByLink alloc] init] autorelease];
	scaleBy.duration = dur;
	scaleBy.scale = scale;
	return scaleBy;
}

- (void)initAnimation
{
	self.animation	= ^{
		self.view.transform = CGAffineTransformScale(self.view.transform, self.scale, self.scale);
	};
}

-(void)propCopyTo:(CPScaleByLink*)link
{
	[super propCopyTo:link];
	link.scale = self.scale;
}

-(id)copyWithZone:(NSZone *)zone
{
	CPScaleByLink* copy = [[CPScaleByLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

@end

#pragma mark -

@implementation CPScaleToLink

@synthesize scale=_scale;

+(CPScaleToLink*)scaleWithDuration:(NSTimeInterval)dur to:(CGFloat)scale
{
	CPScaleToLink* scaleTo = [[[CPScaleToLink alloc] init] autorelease];
	scaleTo.duration = dur;
	scaleTo.scale = scale;
	return scaleTo;
}

- (void)initAnimation
{
	self.animation	= ^{
		self.view.transform = CGAffineTransformMakeScale(self.scale, self.scale);
	};
}

-(void)propCopyTo:(CPScaleToLink*)link
{
	[super propCopyTo:link];
	link.scale = self.scale;
}

-(id)copyWithZone:(NSZone *)zone
{
	CPScaleToLink* copy = [[CPScaleToLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

@end

#pragma mark -

@implementation CPMoveByLink

@synthesize delta=_delta;

+(CPMoveByLink*)moveWithDuration:(NSTimeInterval)dur by:(CGPoint)delta
{
	CPMoveByLink* moveBy = [[[CPMoveByLink alloc] init] autorelease];
	moveBy.duration = dur;
	moveBy.delta = delta;
	return moveBy;
}

- (void)initAnimation
{
	self.animation	= ^{
		self.view.center = CGPointMake(self.view.center.x + self.delta.x, 
									   self.view.center.y + self.delta.y);
	};
}

-(void)propCopyTo:(CPMoveByLink*)link
{
	[super propCopyTo:link];
	link.delta = self.delta;
}

-(id)copyWithZone:(NSZone *)zone
{
	CPMoveByLink* copy = [[CPMoveByLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

@end

#pragma mark -

@implementation CPMoveToLink

@synthesize destination=_destination;

+(CPMoveToLink*)moveWithDuration:(NSTimeInterval)dur to:(CGPoint)dest
{
	CPMoveToLink* moveTo = [[[CPMoveToLink alloc] init] autorelease];
	moveTo.duration = dur;
	moveTo.destination = dest;
	return moveTo;
}

- (void)initAnimation
{
	self.animation	= ^{
		self.view.center = self.destination;
	};
}

-(void)propCopyTo:(CPMoveToLink*)link
{
	[super propCopyTo:link];
	link.destination = self.destination;
}

-(id)copyWithZone:(NSZone *)zone
{
	CPMoveToLink* copy = [[CPMoveToLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

@end

#pragma mark -

@implementation CPRotateByLink

@synthesize angle=_angle;

+(CPRotateByLink*)rotateWithDuration:(NSTimeInterval)dur by:(CGFloat)angle
{
	CPRotateByLink* rotateBy = [[[CPRotateByLink alloc] init] autorelease];
	rotateBy.duration = dur;
	rotateBy.angle	= angle;
	return rotateBy;
}

- (void)initAnimation
{
	self.animation	= ^{
		self.view.transform = CGAffineTransformRotate(self.view.transform, self.angle);
	};
}

-(void)propCopyTo:(CPRotateByLink*)link
{
	[super propCopyTo:link];
	link.angle = self.angle;
}

-(id)copyWithZone:(NSZone *)zone
{
	CPRotateByLink* copy = [[CPRotateByLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

@end

#pragma mark -

@implementation CPRotateToLink

@synthesize angle=_angle;

+(CPRotateToLink*)rotateWithDuration:(NSTimeInterval)dur to:(CGFloat)angle
{
	CPRotateToLink* rotateTo = [[[CPRotateToLink alloc] init] autorelease];
	rotateTo.duration = dur;
	rotateTo.angle	= angle;
	return rotateTo;
}

- (void)initAnimation
{
	self.animation	= ^{
		self.view.transform = CGAffineTransformMakeRotation(self.angle);
	};
}

-(void)propCopyTo:(CPRotateToLink*)link
{
	[super propCopyTo:link];
	link.angle = self.angle;
}

-(id)copyWithZone:(NSZone *)zone
{
	CPRotateToLink* copy = [[CPRotateToLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

@end

#pragma mark -

@interface CPRotate360Link ()
@property (nonatomic, retain) CPAnimationChain* chain;
@end

@implementation CPRotate360Link

@synthesize chain=_chain;

+(CPRotate360Link*)rotateWithDuration:(NSTimeInterval)dur
{
	CPRotate360Link* rotate360 = [[[CPRotate360Link alloc] init] autorelease];
	rotate360.duration = dur;
	return rotate360;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		CPRotateByLink* rotateBy = [CPRotateByLink rotateWithDuration:self.duration/4 by:-M_PI_2];
		rotateBy.options = UIViewAnimationOptionCurveLinear;
		self.chain = [CPAnimationChain chainWithLinks:
					  rotateBy,
					  rotateBy,
					  rotateBy,
					  rotateBy,
					  nil];
	}
	return self;
}

-(void)setDuration:(NSTimeInterval)dur
{
	[super setDuration:dur];
	[self.chain.links enumerateObjectsUsingBlock:^(id link, NSUInteger idx, BOOL *stop) {
		[(CPRotateByLink*)link setDuration:dur/4];
	}];
}

-(void)propCopyTo:(CPRotate360Link*)link
{
	[super propCopyTo:link];
	link.chain = [CPAnimationChain chainWithLinkArray:self.chain.links];
}

-(id)copyWithZone:(NSZone *)zone
{
	CPRotate360Link* copy = [[CPRotate360Link alloc] init];
	[self propCopyTo:copy];
	return copy;
}

-(void)animate
{
	CPAnimationLink* lastLink = [self.chain lastLink];
	CPLinkCompletionBlock prevCompletion = lastLink.completion;
	lastLink.completion = ^(BOOL finished) {
		prevCompletion(finished);
		if (_nextLink)
			[_nextLink animate];
	};
	[self.chain animateView:self.view];
}

@end

#pragma mark -

@implementation CPAndLink

@synthesize links=_links;

+(CPAndLink*)andLinks:(CPAnimationLink*)firstLink, ... 
{
	CPAndLink* andLink = [[[CPAndLink alloc] init] autorelease];
	
	va_list args;
	va_start(args, firstLink);
	CPAnimationLink* link = firstLink;
	while (link)
	{
		[andLink addLink:link];
		link = va_arg(args, CPAnimationLink*);
	}
	va_end(args);
	
	return andLink;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		self.links = [NSMutableArray array];
	}
	return self;
}

-(void)propCopyTo:(CPAndLink*)link
{
	[super propCopyTo:link];
	link.links = [NSMutableArray arrayWithArray:self.links];
}

-(id)copyWithZone:(NSZone *)zone
{
	CPAndLink* copy = [[CPAndLink alloc] init];
	[self propCopyTo:copy];
	return copy;
}

-(void)addLink:(CPAnimationLink*)link
{
	[self.links addObject:link];
	[link setView:self.view];
}

-(void)removeLink:(CPAnimationLink*)link
{
	NSInteger index = [self.links indexOfObject:link];
	if (index != NSNotFound)
	{
		[link setView:nil];
		[self.links removeObject:link];
	}
}

-(void)setView:(UIView *)view
{
	[super setView:view];
	[self.links enumerateObjectsUsingBlock:^(id link, NSUInteger idx, BOOL *stop) {
		[(CPAnimationLink*)link setView:view];
	}];
}

-(void)animate
{
	CPAnimationLink* longestLink = nil;
	for (CPAnimationLink* thisLink in self.links)
	{
		if (longestLink == nil || thisLink.duration > longestLink.duration)
			longestLink = thisLink;
	};
	CPLinkCompletionBlock prevCompletion = longestLink.completion;
	longestLink.completion = ^(BOOL finished) {
		prevCompletion(finished);
		if (_nextLink)
			[_nextLink animate];
	};
	
	[self.links enumerateObjectsUsingBlock:^(id link, NSUInteger idx, BOOL *stop) {
		[(CPAnimationLink*)link animate];
	}];
}

@end

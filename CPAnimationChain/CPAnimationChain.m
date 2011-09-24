//
//  CPAnimationChain.m
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 E-gineering, LLC. All rights reserved.
//

#import "CPAnimationChain.h"
#import "CPAnimationLink.h"

// CPAnimationLink methods visible only to CPAnimationChain

@interface CPAnimationLink (Chaining)
@property (nonatomic, retain) CPAnimationLink*	nextLink;
@end

@implementation CPAnimationLink (Chaining)

- (CPAnimationLink*)nextLink
{
	return _nextLink;
}

- (void)setNextLink:(CPAnimationLink *)newNextLink
{
	if (newNextLink)
		[newNextLink retain];
	if (_nextLink)
		[_nextLink release];
	
	_nextLink = newNextLink;
}

@end

#pragma mark -

@implementation CPAnimationChain

#pragma mark -
#pragma mark Class factory methods

+(CPAnimationChain*)chain
{
	return [[[CPAnimationChain alloc] init] autorelease];
}

+(CPAnimationChain*)chainWithLink:(CPAnimationLink*)link
{
	CPAnimationChain* chain = [CPAnimationChain chain];
	[chain addLink:link];
	return chain;
}

+(CPAnimationChain*)chainWithLinkArray:(NSArray*)linkArray
{
	CPAnimationChain* chain = [CPAnimationChain chain];
	for (CPAnimationLink* link in linkArray)
		[chain addLink:link];
	return chain;
}

+(CPAnimationChain*)chainWithLinks:(CPAnimationLink*)firstLink, ... // nil-terminated
{
	CPAnimationChain* chain = [CPAnimationChain chain];

	va_list args;
	va_start(args, firstLink);
	CPAnimationLink* link = firstLink;
	while (link)
	{
		[chain addLink:link];
		link = va_arg(args, CPAnimationLink*);
	}
	va_end(args);
	
	return chain;
}


#pragma mark -
#pragma mark Instance methods

@synthesize links=_links;
@synthesize view=_view;

- (id)init
{
    self = [super init];
    if (self) 
	{
        // Initialization code here.
		_links = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
	[_links release];
	[super dealloc];
}

- (void)setView:(UIView *)newView
{
	if (newView)
		[newView retain];
	
	if (_view)
		[_view release];
	
	_view = newView;
	
	for (CPAnimationLink* link in _links)
		[link setView:newView];
}

-(NSInteger)length
{
	return [_links count];
}

-(CPAnimationLink*)linkAtIndex:(NSInteger)index
{
	CPAnimationLink* link = nil;
	
	if (index >= 0 && index < [self length])
		link = [_links objectAtIndex:index];
	
	return link;
}

-(CPAnimationLink*)firstLink
{
	return [self linkAtIndex:0];
}

-(CPAnimationLink*)lastLink
{
	return [self linkAtIndex:[self length]-1];
}

-(BOOL)containsLink:(CPAnimationLink*)link
{
	return [_links containsObject:link];
}

-(void)insertLink:(CPAnimationLink*)link atIndex:(NSInteger)index
{
	if ([self containsLink:link])
		link = [link copy];
	
	CPAnimationLink* prevLink = [self linkAtIndex:index-1];
	CPAnimationLink* nextLink = [self linkAtIndex:index];
	
	[_links insertObject:link atIndex:index];
	
	if (prevLink)
		[prevLink setNextLink:link];
	
	[link setNextLink:nextLink];
	[link setView:self.view];
}

-(void)addLink:(CPAnimationLink*)link
{
	[self insertLink:link atIndex:[self length]];
}

-(void)removeLink:(CPAnimationLink*)link
{
	NSInteger index = [_links indexOfObject:link];
	if (index != NSNotFound)
	{
		CPAnimationLink* prevLink = [self linkAtIndex:index-1];
		CPAnimationLink* nextLink = [self linkAtIndex:index+1];
		
		[link setView:nil];
		[_links removeObject:link];
		
		if (prevLink)
			[prevLink setNextLink:nextLink];
	}
}

-(void)animateView:(UIView *)v
{
	self.view = v;
	[[self firstLink] animate];
}
@end

//
//  AnimationChainDemoViewController.m
//  AnimationChainDemo
//
//  Created by Chris Patterson on 9/11/11.
//  Copyright 2011 Chris Patterson. All rights reserved.
//

#import "AnimationChainDemoViewController.h"
#import "UIView+CPAnimationChain.h"
#import "CPAnimationChain.h"
#import "CPAnimationLink.h"

@implementation AnimationChainDemoViewController

@synthesize frog=_frog;
@synthesize alertView=_alertView;

#pragma mark -
#pragma mark NSObject methods

- (void)dealloc 
{
    [_frog release];
	[_alertView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController methods

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[self setFrog:nil];
	[self setAlertView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)animateButtonTapped:(id)sender
{
	UIButton* button = (UIButton*)sender;
	
	CPAnimationChain* chain = nil;
	CGPoint origin = self.frog.center;
	CGRect frame = self.frog.superview.bounds;
	switch (button.tag) 
	{
		case 1: // Fade In
			self.frog.alpha = 0.0;
			chain = [CPAnimationChain chainWithLink:[CPFadeLink fadeWithDuration:1.0 alpha:1.0]];
			break;
			
		case 2: // Fade Out
			self.frog.alpha = 1.0;
			chain = [CPAnimationChain chainWithLink:[CPFadeLink fadeWithDuration:1.0 alpha:0.0]];
			break;
			
		case 3: // Fade Out then In
			self.frog.alpha = 1.0;
			chain = [CPAnimationChain chainWithLinks:
					 [CPFadeLink fadeWithDuration:1.0 alpha:0.0],
					 [CPFadeLink fadeWithDuration:1.0 alpha:1.0],
					 nil];
			break;
			
		case 4: // Expand
			self.frog.transform = CGAffineTransformMakeScale(0.01, 0.01);
			chain = [CPAnimationChain chainWithLink:[CPScaleToLink scaleWithDuration:1.0 to:1.0]];
			break;
			
		case 5: // Shrink
			self.frog.transform = CGAffineTransformIdentity;
			chain = [CPAnimationChain chainWithLink:[CPScaleToLink scaleWithDuration:1.0 to:0.001]];
			break;
			
		case 6: // Expand then Shrink 25%
			self.frog.transform = CGAffineTransformMakeScale(0.01, 0.01);
			chain = [CPAnimationChain chainWithLinks:
					 [CPScaleToLink scaleWithDuration:1.0 to:1.0],
					 [CPScaleToLink scaleWithDuration:0.5 to:0.8],
					 nil];
			break;
			
		case 7: // Fade In then Shrink 50%
			self.frog.alpha = 0.0;
			self.frog.transform = CGAffineTransformIdentity;
			chain = [CPAnimationChain chainWithLinks:
					 [CPFadeLink fadeWithDuration:1.0 alpha:1.0],
					 [CPScaleToLink scaleWithDuration:1.0 to:0.5],
					 nil];
			break;
			
		case 8:	// Shrink 75% then Move Around then Expand
			self.frog.alpha = 1.0;
			self.frog.transform = CGAffineTransformIdentity;
			CGPoint upperLeft = CGPointMake(origin.x/4, origin.y/4);
			CGPoint lowerRight = CGPointMake(frame.size.width - origin.x/4, frame.size.height - origin.y/4);
			CGPoint lowerLeft = CGPointMake(upperLeft.x, lowerRight.y);
			chain = [CPAnimationChain chainWithLinks:
					 [CPScaleToLink scaleWithDuration:1.0 to:0.25],
					 [CPMoveToLink moveWithDuration:1.0 to:upperLeft],
					 [CPMoveToLink moveWithDuration:1.0 to:lowerRight],
					 [CPMoveToLink moveWithDuration:1.0 to:lowerLeft],
					 [CPMoveToLink moveWithDuration:1.0 to:origin],
					 [CPScaleToLink scaleWithDuration:1.0 to:1.0],
					 nil];
			break;
		
		case 9: // Expand & Rotate 360deg (2pi rad)
			self.frog.alpha = 1.0;
			self.frog.transform = CGAffineTransformMakeScale(0.01, 0.01);
			chain = [CPAnimationChain chainWithLinks:
					 [CPScaleToLink scaleWithDuration:1.0 to:1.0],
					 [CPRotate360Link rotateWithDuration:1.0], 
					 nil];
			break;
			
		case 10: // Rotate 360, then Expand AND Fade Out (at the same time)
			self.frog.alpha = 1.0;
			self.frog.transform = CGAffineTransformMakeScale(0.5, 0.5);
			chain = [CPAnimationChain chainWithLinks:
					 [CPRotate360Link rotateWithDuration:1.0], 
					 [CPAndLink andLinks:
					  [CPScaleByLink scaleWithDuration:1.0 by:2.0],
					  [CPFadeLink fadeWithDuration:1.0 alpha:0.0],
					  nil],
					 nil];
			break;
			
		case 11: // Expand AND Move
			self.frog.alpha = 1.0;
			CGPoint start = CGPointMake(self.frog.frame.size.width/20, self.frog.frame.size.height/20);
			self.frog.transform = CGAffineTransformMakeScale(0.1, 0.1);
			self.frog.center = start;
			CGPoint end = CGPointMake(frame.size.width - start.x, frame.size.height - start.y);
			chain = [CPAnimationChain chainWithLinks:
					 [CPAndLink andLinks:
					  [CPScaleByLink scaleWithDuration:1.0 by:10.0],
					  [CPMoveToLink moveWithDuration:1.0 to:origin],
					  nil],
					 [CPAndLink andLinks:
					  [CPScaleByLink scaleWithDuration:1.0 by:0.1],
					  [CPMoveToLink moveWithDuration:1.0 to:end],
					  nil],
					 [CPAndLink andLinks:
					  [CPScaleByLink scaleWithDuration:1.0 by:10.0],
					  [CPMoveToLink moveWithDuration:1.0 to:origin],
					  nil],
					 nil];
			break;
		
		case 12: // UIAlertView
			{
				UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Real Alert"
																message:@"Compare the animation of this alert view to the one generated by alertChain below."
															   delegate:nil
													  cancelButtonTitle:@"OK"
													  otherButtonTitles:nil] autorelease];
				[alert show];
			}
			return;
			
		case 13: // CPAlertChain
			self.alertView.transform = CGAffineTransformMakeScale(0.7, 0.7);
			self.alertView.alpha = 0.0;
			[self.alertView animateWithChain:[CPAnimationChain alertChain]];
			return;
			
		default:
			break;
	}
	[self.frog animateWithChain:chain];
}

- (IBAction)dismissAlertView
{
	[self.alertView animateWithLink:[CPFadeLink fadeWithDuration:0.15 alpha:0.0]];
}

@end

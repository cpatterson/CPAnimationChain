# CPAnimationChain: simple chained animations for iOS

This project started out with an idea. I wanted an easier, more declarative way to chain together simple animations on a UIView in iOS. Although the new iOS 4 block-based UIView methods animateWithDuration:animations:... make life much simpler than the older UIView beginAnimation/commitAnimation methods, I still wished for something simpler.

## The Old Way

Say you wanted one of your views to fade in then zoom (scale) out from half its size, to 110% of its size, then shrink slightly back to its normal 100% full size, sort of like the way alert views appear to "pop" out of the screen when they appear. Using pre-iOS 4 SDKs, you would write code that looked like this:

`
	- (IBAction)showFakeAlertView
	{
		self.alertView.transform = CGAffineTransformMakeScale(0.7, 0.7);
		self.alertView.alpha = 0.0;
		
		[UIView beginAnimations:@"fakeAlertAnimation" context:nil];
		[UIView setAnimationDuration:0.15];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(fakeAlertAnimationStep2)];
		
		self.alertView.alpha = 1.0;
		self.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
		
		[UIView commitAnimations];
	}
	
	- (void)fakeAlertAnimationStep2
	{
		[UIView beginAnimations:@"fakeAlertAnimation2" context:nil];
		[UIView setAnimationDuration:0.15];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(fakeAlertAnimationStep3)];
		
		self.alertView.transform = CGAffineTransformMakeScale(0.95, 0.95);
		
		[UIView commitAnimations];
	}
	
	- (void)fakeAlertAnimationStep3
	{
		[UIView beginAnimations:@"fakeAlertAnimation3" context:nil];
		[UIView setAnimationDuration:0.15];
		
		self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
		
		[UIView commitAnimations];
	}

`

Ugh. Lots of replicated code in separate methods that could be spread out throughout your source file.

## The iOS 4 Way (Blocks to the Rescue)

Things got better with the official introduction of blocks in iOS 4. At least you could encapsulate all your animations in a single method...

`
	- (IBAction)showFakeAlertView
	{
		self.alertView.transform = CGAffineTransformMakeScale(0.7, 0.7);
		self.alertView.alpha = 0.0;
		[UIView animateWithDuration:0.15 animations:^(void) {
			 self.alertView.alpha = 1.0;
			 self.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
		 } 
		 completion:^(BOOL finished) {
			 [UIView animateWithDuration:0.15 animations:^(void) {
				  self.alertView.transform = CGAffineTransformMakeScale(0.95, 0.95);
			  } 
			  completion:^(BOOL finished) {
				  [UIView animateWithDuration:0.15 animations:^(void) {
					   self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
				   }];
			  }];
		 }];
	}
`

## The CPAnimationChain Way

I wanted something simpler still. I imagine a set of reusable building blocks of animation, or "chains" of reusable animation "links". Using the CPAnimationChain library, you can simply write:

`
	- (IBAction)showFakeAlertView
	{
		self.alertView.transform = CGAffineTransformMakeScale(0.7, 0.7);
		self.alertView.alpha = 0.0;
		CPAnimationChain* chain = [CPAnimationChain chainWithLinks:
				[CPAndLink andLinks:
				 [CPScaleToLink scaleWithDuration:0.15 to:1.05],
				 [CPFadeLink fadeWithDuration:0.15 alpha:1.0],
				 nil],
				[CPScaleToLink scaleWithDuration:0.15 to:0.95],
				[CPScaleToLink scaleWithDuration:0.15 to:1.0],
				nil];
		[self.alertView animateWithChain:chain];
	}
`

...or, more simply still, using a prefabricated animation chain class:

`
	- (IBAction)showFakeAlertView
	{
		self.alertView.transform = CGAffineTransformMakeScale(0.7, 0.7);
		self.alertView.alpha = 0.0;
		[self.alertView animateWithChain:[CPAnimationChain alertChain]];
	}
`

Ahhh, that's more like it. A simple class I can call anywhere, anytime, to replicate a given animation sequence.


TransitionBug
=============

This project demonstrates an apparent bug in iOS8 betas.  

Run the project with Xcode 6. It should present a simple interface for pushing on new modal controllers, and then dismissing them. 

The transition animation runs by sliding off the current controller to reveal a new one underneath.  

In iOS8, the animation fails, although it succeeds in iOS7. This is because, in iOS8, the `viewForKey:` method always returns `nil` for the currently presented view in a modal transition. In iOS7, you instead use the `.view` property on the view controller. If you try this in iOS8, the view hierarchy will be broken following dismissal.

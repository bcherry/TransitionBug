//
//  BCViewController.m
//  TransitionBug
//
//  Created by Ben Cherry on 8/8/14.
//  Copyright (c) 2014 Ben Cherry. All rights reserved.
//

#import "BCViewController.h"
#import "BCTransition.h"

@interface BCViewController ()

@property (nonatomic, strong) BCTransition *transition;

@end

@implementation BCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.transition = [BCTransition new];

    self.view.backgroundColor = [self generateBackgroundColor];

    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    presentButton.tintColor = [UIColor blackColor];
    [presentButton setTitle:@"Present" forState:UIControlStateNormal];
    [presentButton sizeToFit];
    presentButton.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    [presentButton addTarget:self action:@selector(tappedPresent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];

    if (self.presentingViewController) {
        UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
        dismissButton.tintColor = [UIColor blackColor];
        [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
        [dismissButton sizeToFit];
        dismissButton.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
        [dismissButton addTarget:self action:@selecto	r(tappedDismiss:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dismissButton];
    }
}

- (void)tappedPresent:(id)sender
{
    BCViewController *vc = [BCViewController new];
    vc.transitioningDelegate = self.transition;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)tappedDismiss:(id)sender
{
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIColor *)generateBackgroundColor
{
    NSArray *colors = @[[UIColor redColor], [UIColor whiteColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor], [UIColor yellowColor]];
    UIColor *color = colors[(NSUInteger)arc4random_uniform((unsigned int)[colors count])];

    if (self.presentingViewController && [self.presentingViewController.view.backgroundColor isEqual:color]) {
        return [self generateBackgroundColor];
    }

    return color;
}


@end

//
//  TutorialPageViewController.m
//  Cilent
//
//  Created by Steven Stewart on 10/12/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import "TutorialPageViewController.h"

@interface TutorialPageViewController ()

@end

@implementation TutorialPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appState = [AppState getInstance];
    
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageController.view.frame = CGRectMake(0, 0, appState.screenWidth, appState.screenHeight-100);
    [self.view setBackgroundColor:[UIColor colorWithRed:.4f green:.89f blue:.8f alpha:1.0f]];
    pageController.dataSource = self;
    TutorialChildViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
    [pageController didMoveToParentViewController:self];
    
    btnGetStarted = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [[self view] addSubview:btnGetStarted];
    [btnGetStarted setBackgroundColor:[UIColor darkGrayColor]];
    [btnGetStarted setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnGetStarted setTitle:@"Get Started" forState:UIControlStateNormal];
    [btnGetStarted.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:20]];
    btnGetStarted.clipsToBounds = YES;
    btnGetStarted.layer.cornerRadius = 20.0f;
    btnGetStarted.frame = CGRectMake(10, appState.screenHeight-90, appState.screenWidth-20, 80);
    [btnGetStarted addTarget:self action:@selector(getStartedButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)getStartedButtonPressed
{
    MapViewController *mapViewController = [[MapViewController alloc] init];
    [[self navigationController] pushViewController:mapViewController animated:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [(TutorialChildViewController *)viewController index];
    if (index == 0)
    {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [(TutorialChildViewController *)viewController index];
    index++;
    if (index == 5)
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (TutorialChildViewController *)viewControllerAtIndex:(NSUInteger)index
{
    TutorialChildViewController *childViewController = [[TutorialChildViewController alloc] init];
    childViewController.index = index;
    return childViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    // The number of items reflected in the page indicator.
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    // The selected item reflected in the page indicator.
    return 0;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

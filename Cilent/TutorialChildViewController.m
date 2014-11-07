//
//  TutorialChildViewController.m
//  Cilent
//
//  Created by Steven Stewart on 10/12/14.
//  Copyright (c) 2014 Maaz Kamani. All rights reserved.
//

#import "TutorialChildViewController.h"

@interface TutorialChildViewController ()

@end

@implementation TutorialChildViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:.4f green:.89f blue:.8f alpha:1.0f]];
    
    self.lblScreenNumber = [[UILabel alloc] init];
    self.lblScreenNumber.textColor = [UIColor blackColor];
    self.lblScreenNumber.text = [NSString stringWithFormat:@"Screen %d", self.index+1];
    [self.lblScreenNumber setFont:[UIFont fontWithName:@"ArialMT" size:25]];
    [self.view addSubview:self.lblScreenNumber];
    self.lblScreenNumber.frame = CGRectMake(20, 30, 200, 30);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

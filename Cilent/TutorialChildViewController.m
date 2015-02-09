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
    
    self.lblPageText = [[UILabel alloc] init];
    self.lblPageText.textColor = [UIColor whiteColor];
    self.lblPageText.text = [NSString stringWithFormat:@"Screen %d", self.index+1];
    self.lblPageText.numberOfLines = 0; //multiline
    self.lblPageText.lineBreakMode = NSLineBreakByWordWrapping;
    [self.lblPageText setFont:[UIFont fontWithName:@"ArialMT" size:20]];
    self.lblPageText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lblPageText];
    self.lblPageText.frame = CGRectMake(15, self.view.frame.size.height-250, self.view.frame.size.width-15, 100);
    
    switch (self.index)
    {
        case 0:
            self.lblPageText.text = @"your local aware assistant";
            break;
        case 1:
            self.lblPageText.text = @"Find Locations\nYou can search for locations or mark your current location";
            break;
        case 2:
            self.lblPageText.text = @"Save to your 'Places'\nBuild a list of locations where you want to be reminded to switch your phone to silent";
            break;
        case 3:
            self.lblPageText.text = @"Get Notifications\nWhen you enter a saved location, you'll receive a push notification to silence your phone";
            break;
    }
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

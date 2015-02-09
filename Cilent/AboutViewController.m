//
//  AboutViewController.m
//  Cilent
//
//  Created by Steven Stewart on 1/11/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppState* appState = [AppState getInstance];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"About";
    UIBarButtonItem* btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popThisViewController)];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIView* vBackground = [[UIView alloc] initWithFrame:appState.screenRect];
    vBackground.backgroundColor = [ViewUtil colorWithHexString:@"3FCCE5"];
    [self.view addSubview:vBackground];
}

-(void)popThisViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

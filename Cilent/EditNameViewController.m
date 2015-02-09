//
//  EditNameViewController.m
//  Cilent
//
//  Created by Steven Stewart on 1/10/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import "EditNameViewController.h"

@interface EditNameViewController ()

@end

@implementation EditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppState* appState = [AppState getInstance];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Change Name";
    UIBarButtonItem* btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popThisViewController)];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(savePlaceName)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    UIView* vBackground = [[UIView alloc] initWithFrame:appState.screenRect];
    vBackground.backgroundColor = [ViewUtil colorWithHexString:@"3FCCE5"];
    [self.view addSubview:vBackground];
    
    UIView* vTextBackground = [ViewUtil getRoundedBox:10 :74 :appState.screenWidth-20 :40 :[UIColor whiteColor] :4.0f :false];
    [self.view addSubview:vTextBackground];
    
    UITextField* tfName = [ViewUtil getTextField:20 :74 :appState.screenWidth-40 :40 :[UIColor whiteColor] :0.0f];
    tfName.delegate = self;
    tfName.text = self.place.name;
    self.tempName = self.place.name;
    [self.view addSubview:tfName];
    
}

-(void)savePlaceName
{
    self.place.name = self.tempName;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popThisViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Text Field Delegate methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString
{
    self.tempName = [textField.text stringByReplacingCharactersInRange:range withString:replacementString];
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES]; //Dismiss keyboard
//    [self searchButtonPressed];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  MyPlacesViewController.m
//  Cilent
//
//  Created by Steven Stewart on 1/10/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import "MyPlacesViewController.h"

@interface MyPlacesViewController ()

@end

@implementation MyPlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appState = [AppState getInstance];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Locations";
    UIBarButtonItem* btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(popThisViewController)];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIView* vBackground = [[UIView alloc] initWithFrame:appState.screenRect];
    vBackground.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:vBackground];
    
    tblvPlaces = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, appState.screenWidth, appState.screenHeight-64)];
    tblvPlaces.delegate = self;
    tblvPlaces.dataSource = self;
    tblvPlaces.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblvPlaces.backgroundColor = [UIColor clearColor];
    tblvPlaces.alwaysBounceVertical = NO;
    [self.view addSubview:tblvPlaces];
}

- (void)viewDidAppear:(BOOL)animated
{
    [tblvPlaces reloadData];
}

-(void)popThisViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Tableview dataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSMutableArray*)[appState getMyPlaces]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[PlaceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Place* place = [((NSMutableArray*)[appState getMyPlaces]) objectAtIndex:indexPath.row];
    cell.lblName.text = place.name;
    
    return cell;
}
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    Place* selectedPlace = (Place*)[[appState getMyPlaces] objectAtIndex:indexPath.row];
    
    EditLocation *editLocation = [[EditLocation alloc] init];
    editLocation.place = selectedPlace;
    [[self navigationController] pushViewController:editLocation animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

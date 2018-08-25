//
//  DSParksTableViewController.m
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import "DSParksTableViewController.h"
#import "DSParkTableViewCell.h"

NSString *const DSParkTableViewCellIdentifier = @"DSParkTableViewCellIdentifier";

@interface DSParksTableViewController ()

@end

@implementation DSParksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[DSParkTableViewCell class] forCellReuseIdentifier:DSParkTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:DSParkTableViewCellIdentifier];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [NSString stringWithFormat:@"%li", (long)indexPath.row];
}
@end

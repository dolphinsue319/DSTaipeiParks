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

@interface DSParksTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DSParksTableViewController

-(void)loadView
{
    [super loadView];
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    UIImage *image = [UIImage imageNamed:@"parkSample"];
    _backgroundImageView.image = image;
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerClass:[DSParkTableViewCell class] forCellReuseIdentifier:DSParkTableViewCellIdentifier];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [self.view insertSubview:_backgroundImageView belowSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 100 : 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"title";
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
    view.isAccessibilityElement = NO;
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.textColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:DSParkTableViewCellIdentifier];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 0 : UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [NSString stringWithFormat:@"%li-%li", (long)indexPath.section, (long)indexPath.row];
}
@end

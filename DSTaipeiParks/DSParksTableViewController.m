//
//  DSParksTableViewController.m
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import "DSParksTableViewController.h"
#import "DSParkTableViewCell.h"
#import "DSParksTableViewControlViewModel.h"
#import "DSLoadingTableViewCell.h"
#import "DSPark.h"

const float kBackgroundImageHeight = 100;
const float kDefaultCellHeight = 44;

@interface DSParksTableViewController ()<UITableViewDelegate, UITableViewDataSource, DSParksTableViewControlViewModelDelegate>
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DSParksTableViewControlViewModel *viewModel;
@end

@implementation DSParksTableViewController

-(void)loadView
{
    [super loadView];
    
    _viewModel = [[DSParksTableViewControlViewModel alloc] init];
    _viewModel.delegate = self;
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kBackgroundImageHeight)];
    UIImage *image = [UIImage imageNamed:@"parkSample"];
    _backgroundImageView.image = image;
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = kDefaultCellHeight;
    
    _tableView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_tableView];
    [self.view insertSubview:_backgroundImageView belowSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_viewModel.parks.count == 0) {
        [_viewModel fetchParks];
    }
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
    return section == 0 ? kBackgroundImageHeight : kDefaultCellHeight;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"title";
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.textColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _viewModel.isMoreParks ? _viewModel.parks.count + 1 : _viewModel.parks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [tableView dequeueReusableCellWithIdentifier:@"DSInvisibleCell"];
            break;
        case 1: {
            if (_viewModel.isMoreParks && indexPath.row == _viewModel.parks.count) {
                DSLoadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DSLoadingCell"];
                [cell.indicatorView startAnimating];
                return cell;
            }
            DSParkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DSParkTableViewCell"];
            DSPark *park = [_viewModel parkAtIndex:indexPath.row];
            [cell configureParkName:park.parkName introduction:park.introduction];
            return cell;
            break;
        }
        default:
            break;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"InvisibleCell"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 0 : UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[DSLoadingTableViewCell class]]) {
        [_viewModel fetchParks];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)parksTableViewModelDidUpdateParks:(DSParksTableViewControlViewModel *)viewModel
{
    [_tableView reloadData];
}

-(void)parksTableViewModelDidFetchFailed:(DSParksTableViewControlViewModel *)viewModel
{
    
}

@end

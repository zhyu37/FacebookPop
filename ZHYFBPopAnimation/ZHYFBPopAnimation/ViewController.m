//
//  ViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/26.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ViewController.h"
#import "ZHYSpringAnimationViewController.h"
#import "ZHYDecayAnimationViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableDictionary *animationDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"PopAnimation";
    
    [self setupDate];
    
    [self setupUI];
}

- (void)setupDate
{
    [self.animationDict setObject:[[NSArray alloc] initWithObjects:@"Spring Animation", @"Decay Animation", @"Basic Animation", @"Property Animation", nil] forKey:@"Animation"];
    [self.animationDict setObject:[[NSArray alloc] initWithObjects:@"Popup & Decay Move", @"Fly In", @"Transform", nil] forKey:@"Usage"];
    
    [self.array addObject:@"Animation"];
    [self.array addObject:@"Usage"];
}

- (void)setupUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *group = self.animationDict[self.array[section]];
    return group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *group = self.animationDict[self.array[indexPath.section]];
    cell.textLabel.text = group[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.array[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     ZHYSpringAnimationViewController *springVC = [[ZHYSpringAnimationViewController alloc] init];
    ZHYDecayAnimationViewController *decayVC = [[ZHYDecayAnimationViewController alloc] init];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:springVC animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:decayVC animated:YES];
                break;
    
            default:
                break;
        }
    } else {
        
    }
    
}

#pragma mark - getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (NSMutableDictionary *)animationDict
{
    if (!_animationDict) {
        _animationDict = [NSMutableDictionary dictionary];
    }
    return _animationDict;
}

@end


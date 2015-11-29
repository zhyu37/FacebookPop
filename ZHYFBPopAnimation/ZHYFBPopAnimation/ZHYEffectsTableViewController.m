//
//  ZHYEffectsTableViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/29.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ZHYEffectsTableViewController.h"

@interface ZHYEffectsTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ZHYEffectsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDate];
    
    [self setupUI];
}

- (void)setupDate
{
    
}

- (void)setupUI
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.frame = self.view.frame;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ZHYEffectsTableViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - getters and setters 

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

@end

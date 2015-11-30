//
//  ZHYPropertyViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/29.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ZHYPropertyViewController.h"
#import <POP/POP.h>

@interface ZHYPropertyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSString * animationType;
@property (nonatomic) NSArray * animationTypes;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZHYPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setupInit];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"效果" style:UIBarButtonItemStyleDone target:self action:@selector(effectsClick)];
}

- (void)effectsClick
{
    //所有可选动画类型
    self.animationTypes = @[kCAMediaTimingFunctionLinear,
                            kCAMediaTimingFunctionEaseIn,
                            kCAMediaTimingFunctionEaseOut,
                            kCAMediaTimingFunctionEaseInEaseOut,
                            kCAMediaTimingFunctionDefault];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.tableView];
}

- (void)setupInit
{
    //初始化 动画类型
    self.animationType = kCAMediaTimingFunctionEaseInEaseOut;
    
    //view 的初始化
    [self setupAnimationView];
    
    //添加动画
    [self performAnimation];
}

- (void)setupAnimationView
{
    self.numberLabel.text = @"0";
    self.numberLabel.frame = CGRectMake(0, 200, 300, [UIScreen mainScreen].bounds.size.width);
    self.numberLabel.font = [UIFont fontWithName:@"Arial" size:90];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.numberLabel];
}

-(void)performAnimation
{
    [self.numberLabel pop_removeAllAnimations];
    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.duration = 10.0;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:self.animationType];
    NSLog(@"Animation type is %@",self.animationType);
    
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
        // read value
        prop.readBlock = ^(id obj, CGFloat values[]) {
            values[0] = [[obj description] floatValue];
        };
        // write value
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            [obj setText:[NSString stringWithFormat:@"%.2f",values[0]]];
        };
        // dynamics threshold
        prop.threshold = 0.01;
    }];
    
    anim.property = prop;
    
    anim.fromValue = @(0.0);
    anim.toValue = @(100.0);
    
    [self.numberLabel pop_addAnimation:anim forKey:@"counting"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animationTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ZHYEffectsTableViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.animationTypes[indexPath.row];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.animationType = self.animationTypes[indexPath.row];
    [self.tableView removeFromSuperview];
    [self setupAnimationView];
    [self performAnimation];
}

#pragma mark - getters and setters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
    }
    return _numberLabel;
}

@end

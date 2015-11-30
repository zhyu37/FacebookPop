//
//  ZHYBaseViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/29.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ZHYBaseViewController.h"
#import <POP/POP.h>

@interface ZHYBaseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSString * animationType;
@property (nonatomic) NSArray * animationTypes;

@property (nonatomic) CALayer * popView;
@property (nonatomic, strong) UIImageView *animationImage;
@property (nonatomic) BOOL animated;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZHYBaseViewController

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
    
    
    [self.view.layer addSublayer:self.popView];
    
    //添加动画
    [self performAnimation];
}

- (void)setupAnimationView
{
    [self.popView pop_removeAllAnimations];
    self.popView = [CALayer layer];
    //清除 跟新数据之后之前的图像
    [self.animationImage removeFromSuperview];
    //动画的view
    self.animationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image-1"]];
    //只能用绝对位置  不能用相对位置
    self.animationImage.frame = CGRectMake(150, 150, 50, 50);
    
    self.popView = self.animationImage.layer;
    [self.view.layer addSublayer:self.popView];
}

-(void)performAnimation
{
    [self.popView pop_removeAllAnimations];
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    if (self.animated) {
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }else{
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
    }
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:self.animationType];
    
    self.animated = !self.animated;
    
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            
            [self performAnimation];
        }
    };
    
    [self.popView pop_addAnimation:anim forKey:@"Animation"];
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

@end

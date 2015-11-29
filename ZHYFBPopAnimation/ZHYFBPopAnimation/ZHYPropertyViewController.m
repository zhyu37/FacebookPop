//
//  ZHYPropertyViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/29.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ZHYPropertyViewController.h"

@interface ZHYPropertyViewController ()

@property (nonatomic) NSString * animationType;
@property (nonatomic) NSArray * animationTypes;

@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation ZHYPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setupInit];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupInit
{
    //所有可选动画类型
    self.animationTypes = @[kCAMediaTimingFunctionLinear,
                            kCAMediaTimingFunctionEaseIn,
                            kCAMediaTimingFunctionEaseOut,
                            kCAMediaTimingFunctionEaseInEaseOut,
                            kCAMediaTimingFunctionDefault];
    
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

#pragma mark - getters 

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
    }
    return _numberLabel;
}

@end

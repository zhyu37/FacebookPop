//
//  ZHYBaseViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/29.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ZHYBaseViewController.h"

@interface ZHYBaseViewController ()

@property (nonatomic) NSString * animationType;
@property (nonatomic) NSArray * animationTypes;

@property (nonatomic) CALayer * popView;
@property (nonatomic, strong) UIImageView *animationImage;
@property (nonatomic) BOOL animated;

@end

@implementation ZHYBaseViewController

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

@end

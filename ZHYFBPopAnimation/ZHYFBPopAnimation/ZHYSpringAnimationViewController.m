//
//  ZHYSpringAnimationViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/26.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

/**
 *  弹簧动画是Bezier曲线无法表述的，PopSpringAnimation便是专门用来实现弹簧动画的。
 *
 *  @param nonatomic
 *
 *  @return 
 */

#import "ZHYSpringAnimationViewController.h"

@interface ZHYSpringAnimationViewController ()<POPAnimationDelegate>

@property (nonatomic) NSString * animationType;
@property (nonatomic) NSArray * animationTypes;

@property (nonatomic) CALayer * popView;
@property (nonatomic, strong) UIImageView *animationImage;
@property (nonatomic) BOOL animated;

@end

@implementation ZHYSpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setupInit];
    
}

- (void)setupInit
{
    //所有可选动画类型
    self.animationTypes = @[kPOPLayerBackgroundColor,kPOPLayerBounds,kPOPLayerOpacity,kPOPLayerPosition,kPOPLayerRotation,kPOPLayerScaleXY,kPOPLayerSize,kPOPLayerTranslationXY,kPOPLayerRotationX, kPOPLayerRotationY];
    
    //初始化 动画类型
    self.animationType = kPOPLayerScaleXY;
    
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
    [self setAnimationWithBounciness:self.BouncinessSlider.value andSpeed:self.SpeedSlider.value];
}

-(void)setAnimationWithBounciness:(CGFloat)bounciness andSpeed:(CGFloat)speed
{
    
    [self.popView pop_removeAllAnimations];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:self.animationType];
    
    [ZHYAnimationManager springObject:self.popView configAnimation:anim WithType:self.animationType andAnimated:self.animated];
    
    self.animated = !self.animated;
    anim.springBounciness = bounciness;
    anim.springSpeed = speed;
    
    if (self.FrictionSwitch.isOn) {
        anim.dynamicsFriction = self.FrictionSlider.value;
    }
    
    if (self.TensionSwitch.isOn) {
        anim.dynamicsTension = self.TensionSlider.value;
    }
    
    if (self.MassSwitch.isOn) {
        anim.dynamicsMass = self.MassSlider.value;
    }
    
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            
            [self performAnimation];
        }
    };
    
    [self.popView pop_addAnimation:anim forKey:@"Animation"];
    
}

//变量的改变
- (IBAction)sliderChange:(id)sender {
    [self setupAnimationView];
    [self performAnimation];
}
@end

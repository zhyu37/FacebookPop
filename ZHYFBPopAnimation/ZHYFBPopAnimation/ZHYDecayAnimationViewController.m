//
//  ZHYDecayAnimationViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/28.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ZHYDecayAnimationViewController.h"

@interface ZHYDecayAnimationViewController ()

@property (nonatomic) NSString * animationType;
@property (nonatomic) NSArray * animationTypes;

//@property (nonatomic) CALayer * popView;
@property (nonatomic, strong) UIImageView *animationImage;
@property (nonatomic) BOOL animated;

@end

@implementation ZHYDecayAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setupInit];
    
    //添加动画
    [self performAnimation];
}
- (void)setupInit
{
    //所有可选动画类型
    self.animationTypes = @[kPOPLayerBackgroundColor,kPOPLayerBounds,kPOPLayerOpacity,kPOPLayerPosition, kPOPLayerPositionX ,kPOPLayerRotation,kPOPLayerScaleXY,kPOPLayerSize,kPOPLayerTranslationXY,kPOPLayerRotationX, kPOPLayerRotationY];
    
    //初始化 动画类型
    self.animationType = kPOPLayerPositionX;
    
    //动画的view
    self.animationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image-1"]];
    //只能用绝对位置  不能用相对位置
    self.animationImage.frame = CGRectMake(0, 0, 50, 50);
    
    //view 的初始化
    [self setupAnimationView];
    
    [self.view addSubview:self.animationImage];
    
}

- (void)setupAnimationView
{
    [self.animationImage.layer pop_removeAllAnimations];
    //
    self.animationImage.layer.position = CGPointMake(0, 180);
    self.animated = NO;

}

-(void)performAnimation
{
    
    [self.animationImage.layer pop_removeAllAnimations];
    
    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:self.animationType];
    
    [ZHYAnimationManager decayObject:self.animationImage.layer configAnimation:anim WithType:self.animationType andAnimated:self.animated andVelocitySlider:self.VelocitySlider];
    
    
    anim.deceleration = self.DeclerationSlider.value;
    
    self.animated = !self.animated;
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            
            [self performAnimation];
        }
    };
    
    
    [self.animationImage.layer pop_addAnimation:anim forKey:@"Animation"];
}

- (IBAction)sliderChange:(id)sender {
    [self setupAnimationView];
    [self performAnimation];
}
@end

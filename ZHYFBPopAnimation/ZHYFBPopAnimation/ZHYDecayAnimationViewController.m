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
    [self hideTableView];
    
    
}

- (void)setupAnimationView
{
    [self.animationImage.layer pop_removeAllAnimations];
    self.animationImage.layer.opacity = 1.0;
    self.animationImage.layer.transform = CATransform3DIdentity;
    [self.animationImage.layer setMasksToBounds:YES];
    [self.animationImage.layer setBackgroundColor:[UIColor colorWithRed:0.16 green:0.72 blue:1.0 alpha:1.0].CGColor];
    [self.animationImage.layer setCornerRadius:25.0f];
    [self.animationImage setBounds:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    self.animationImage.layer.position = CGPointMake(self.view.center.x, 180.0);
    self.animated = NO;
    
    
    
    
//    self.popView = [CALayer layer];
//    //清除 跟新数据之后之前的图像
//    [self.animationImage removeFromSuperview];
//    
//    
//    self.popView = self.animationImage.layer;
//    [self.view.layer addSublayer:self.popView];
//    self.animated = NO;

}

-(void)hideTableView
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.window.center.x, -1000.0)];
    [self.animationImage pop_addAnimation:anim forKey:@"AnimationHide"];
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self setupAnimationView];
            [self performAnimation];
        }
    };
}

-(void)performAnimation
{
//    [self hideTableView];
    
    [self.animationImage.layer pop_removeAllAnimations];
    
    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:self.animationType];
    
    [PDAnimationManager decayObject:self.animationImage.layer configAnimation:anim WithType:self.animationType andAnimated:self.animated andVelocitySlider:self.VelocitySlider];
    
    
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

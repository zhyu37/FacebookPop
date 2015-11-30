//
//  ZHYFlyIn.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/30.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ZHYFlyIn.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ZHYAnimationManager.h"
#import <POP/POP.h>

@interface ZHYFlyIn ()

@property (nonatomic, strong) UIView *animationImage;
@property (nonatomic) BOOL animated;

@end

@implementation ZHYFlyIn

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setupInit];
    
    //添加动画
    [self performAnimation];

}

- (void)setupInit
{
    //动画的view
//   不能使用uiimageView
    self.animationImage = [[UIView alloc] init];
    //只能用绝对位置  不能用相对位置
    self.animationImage.frame = CGRectMake(0, 0, 50, 50);
    
    //view 的初始化
    [self setupAnimationView];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.animationImage addGestureRecognizer:pan];
    
    [self.view addSubview:self.animationImage];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            [self.animationImage.layer pop_removeAllAnimations];
            
            CGPoint translation = [pan translationInView:self.view];
            
            CGPoint center = self.animationImage.center;
            center.x += translation.x;
            center.y += translation.y;
            self.animationImage.center = center;
            
            [pan setTranslation:CGPointZero inView:self.animationImage];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
            CGPoint velocity = [pan velocityInView:self.view];
            [self addDecayPositionAnimationWithVelocity:velocity];
            break;
        }
            
        default:
            break;
    }
}

-(void)addDecayPositionAnimationWithVelocity:(CGPoint)velocity
{
    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    anim.velocity = [NSValue valueWithCGPoint:CGPointMake(velocity.x, velocity.y)];
    
    
    anim.deceleration = 0.998;
    
    [self.animationImage.layer pop_addAnimation:anim forKey:@"AnimationPosition"];
}

- (void)setupAnimationView
{
    [self.animationImage.layer pop_removeAllAnimations];
    //
    for (CAShapeLayer *layer in self.animationImage.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    self.animationImage.layer.opacity = 0.0;
//    if ([self.animationType isEqualToString:@"TRANSFORM"]) {
//        self.animationImage.layer.opacity = 1.0;
//    }
    self.animationImage.layer.transform = CATransform3DIdentity;
    [self.animationImage.layer setMasksToBounds:YES];
    [self.animationImage.layer setBackgroundColor:[UIColor colorWithRed:0.16 green:0.72 blue:1.0 alpha:1.0].CGColor];
    [self.animationImage.layer setCornerRadius:25.0f];
    [self.animationImage setBounds:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    self.animationImage.layer.position = CGPointMake(self.view.center.x, 180.0);
    
}

-(void)performAnimation
{
//    [self.animationImage pop_removeAllAnimations];
//    
//    [self.animationImage.layer setCornerRadius:5.0f];
//    [self.popCircle setBounds:CGRectMake(0.0f, 0.0f, 160.0f, 230.0f)];
//    CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(-M_PI_4/8.0);
//    [self.popCircle.layer setAffineTransform:rotateTransform];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.springBounciness = 6;
    anim.springSpeed = 10;
    anim.fromValue = @-200;
    anim.toValue = @(self.view.center.y);
    
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];

    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = 0.25;
    opacityAnim.toValue = @1.0;
    
    POPBasicAnimation *rotationAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnim.beginTime = CACurrentMediaTime() + 0.1;
    rotationAnim.duration = 0.3;
    rotationAnim.toValue = @(0);
    
    [self.animationImage.layer pop_addAnimation:anim forKey:@"AnimationScale"];
    [self.animationImage.layer pop_addAnimation:opacityAnim forKey:@"AnimateOpacity"];
    [self.animationImage.layer pop_addAnimation:rotationAnim forKey:@"AnimateRotation"];

}


- (IBAction)animationClick:(id)sender {
    
    [self setupAnimationView];
    [self performAnimation];
}
@end

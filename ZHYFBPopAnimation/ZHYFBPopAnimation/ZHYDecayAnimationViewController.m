//
//  ZHYDecayAnimationViewController.m
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/28.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

/**
 *  基于Bezier曲线无法描述Decay Aniamtion，用于衰减动画。
 *
 *  @param nonatomic
 *
 *  @return
 */

#import "ZHYDecayAnimationViewController.h"
#import "ZHYAnimationManager.h"

@interface ZHYDecayAnimationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSString * animationType;
@property (nonatomic) NSArray * animationTypes;

//@property (nonatomic) CALayer * popView;
@property (nonatomic, strong) UIImageView *animationImage;
@property (nonatomic) BOOL animated;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZHYDecayAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setupInit];
    
    //添加动画
    [self performAnimation];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"效果" style:UIBarButtonItemStyleDone target:self action:@selector(effectsClick)];
}

- (void)effectsClick
{
    //所有可选动画类型
    self.animationTypes = @[kPOPLayerBackgroundColor,kPOPLayerBounds,kPOPLayerOpacity,kPOPLayerPosition, kPOPLayerPositionX ,kPOPLayerRotation,kPOPLayerScaleXY,kPOPLayerSize,kPOPLayerTranslationXY,kPOPLayerRotationX, kPOPLayerRotationY];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.tableView];
}

- (void)setupInit
{
    
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
    self.animationImage.layer.position = CGPointMake(160, 180);
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

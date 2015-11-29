//
//  ZHYDecayAnimationViewController.h
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/28.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHYDecayAnimationViewController;
@protocol ZHYDecayAnimationViewControllerDelegate <NSObject>

@optional
- (void)ZHYDecayAnimationViewController:(ZHYDecayAnimationViewController *)ZHYDecayAnimationViewController WithArray:(NSMutableArray *)array;

@end

@interface ZHYDecayAnimationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *VelocitySlider;
@property (weak, nonatomic) IBOutlet UISlider *DeclerationSlider;

- (IBAction)sliderChange:(id)sender;

@property (nonatomic, assign) id<ZHYDecayAnimationViewControllerDelegate> delegate;

@end

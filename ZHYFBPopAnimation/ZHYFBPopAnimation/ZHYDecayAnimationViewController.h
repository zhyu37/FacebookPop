//
//  ZHYDecayAnimationViewController.h
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/28.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHYDecayAnimationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *VelocitySlider;
@property (weak, nonatomic) IBOutlet UISlider *DeclerationSlider;

- (IBAction)sliderChange:(id)sender;

@end

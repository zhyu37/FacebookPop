//
//  ZHYSpringAnimationViewController.h
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/26.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHYSpringAnimationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *BouncinessSlider;
@property (weak, nonatomic) IBOutlet UISlider *SpeedSlider;
@property (weak, nonatomic) IBOutlet UISlider *TensionSlider;
@property (weak, nonatomic) IBOutlet UISlider *FrictionSlider;
@property (weak, nonatomic) IBOutlet UISlider *MassSlider;

@property (weak, nonatomic) IBOutlet UISwitch *FrictionSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *TensionSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *MassSwitch;
- (IBAction)sliderChange:(id)sender;

@end

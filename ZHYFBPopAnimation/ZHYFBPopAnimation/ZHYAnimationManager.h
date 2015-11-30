//
//  ZHYAnimationManager.h
//  ZHYFBPopAnimation
//
//  Created by 张昊煜 on 15/11/29.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <POP/POP.h>
#import <UIKit/UIKit.h>
#import "ZHYAnimationManager.h"

@interface ZHYAnimationManager : NSObject

+(void)springObject:(CALayer*)layer configAnimation:(POPPropertyAnimation *)animation WithType:(NSString *)type andAnimated:(BOOL)animated;

+(void)decayObject:(CALayer*)layer configAnimation:(POPDecayAnimation *)animation WithType:(NSString *)type andAnimated:(BOOL)animated andVelocitySlider:(UISlider *)slider;


@end

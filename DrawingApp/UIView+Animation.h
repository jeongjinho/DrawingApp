//
//  UIView+Animation.h
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 3..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, AnimationDirection){
    LeftDirection = 0,
    RightDirection = 1,
    TopDirection = 2,
    BottomDirection = 3
};
@interface UIView(Animaition) <UIViewControllerAnimatedTransitioning>
- (void)hideAnimationForDirection:(AnimationDirection)direction range:(CGFloat)range;
- (void)showAnimationForDirection:(AnimationDirection)direction range:(CGFloat)range;

- (UIImage *)pb_takeSnapshot;
@end

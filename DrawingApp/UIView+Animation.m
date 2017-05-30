//
//  UIView+Animation.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 3..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "UIView+Animation.h"



//typedef void(^AnimationHandler)(AnimationDirection direction);
@implementation UIView(Animaition)



//AnimationHandler ainimation =^void (AnimationDirection direction){
//
//};

- (void)showAnimationForDirection:(AnimationDirection)direction range:(CGFloat)range{
    CGRect rect = self.frame;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    switch (direction) {
            
        case BottomDirection:{
        
            [UIView animateWithDuration:0.3 animations:^{
                NSLog(@"%lf",rect.size.height);
                [self setFrame:CGRectMake(rect.origin.x,rect.size.height, rect.size.width, rect.size.height)];
            }];
         
        }
            
            break;
        case TopDirection:{
           
            [UIView animateWithDuration:0.3 animations:^{
               [self setFrame:CGRectMake(rect.origin.x, -rect.size.height,rect.size.width,rect.size.height)];
               
            }];
            break;
        }
        case LeftDirection:{
        
            [UIView animateWithDuration:0.3 animations:^{
                
                [self setFrame:CGRectMake(rect.origin.x-rect.size.width, rect.origin.y,rect.size.width,rect.size.height)];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)hideAnimationForDirection:(AnimationDirection)direction range:(CGFloat)range{
    CGRect rect = self.frame;
  
      self.translatesAutoresizingMaskIntoConstraints =YES;
    switch (direction) {
            
        case TopDirection:{
            
            [UIView animateWithDuration:0.3 animations:^{
              
               
                [self setFrame:CGRectMake(rect.origin.x,-rect.size.height, rect.size.width,rect.size.height)];
            }];
            
           
        }
            break;
        case BottomDirection:{
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [self setFrame:CGRectMake(rect.origin.x, rect.origin.y + rect.size.height+range,rect.size.width, rect.size.height)];
            }];
        }
            
            break;
        case RightDirection:{
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [self setFrame:CGRectMake(rect.origin.x+rect.size.width,rect.origin.y,rect.size.width, rect.size.height)];
            }];
            break;
        }
        default:
            break;
    }
    
}

- (UIImage *)pb_takeSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
     UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * container = transitionContext.containerView;
    
    toVC.view.alpha = 0.0;
    [container addSubview:toVC.view];
  //  container.addSubview(toViewController.view)
    
    [UIView animateWithDuration:0.5 animations:^{
        
        toVC.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{

    return 0.5;
}

@end

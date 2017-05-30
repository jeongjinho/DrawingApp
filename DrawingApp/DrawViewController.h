//
//  DrawViewController.h
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 2..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawViewController : UIViewController

@property CGPoint lastPoint;
@property  CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property CGFloat brush;
@property CGFloat opacity;
@property BOOL mouseSwiped;
@end

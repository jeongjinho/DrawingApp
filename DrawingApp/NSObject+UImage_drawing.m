//
//  NSObject+UImage_drawing.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 5. 19..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "NSObject+UImage_drawing.h"

@implementation NSObject (UImage_drawing)



+ (UIImage *)initializeWiteImage:(CGRect) rect{

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = [[UIImage alloc]init];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
     NSLog(@"%@",image);
    UIGraphicsEndImageContext();
   
    return image;
}
@end

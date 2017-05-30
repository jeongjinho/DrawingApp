//
//  DrawNavigationBarButton.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 2..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "DrawNavigationBarButton.h"

@implementation DrawNavigationBarButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];

}


@end

//
//  ThickSlider.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 2..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "ThickSlider.h"

@implementation ThickSlider


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
  
   
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setThumbImage:[UIImage imageNamed:@"SliderButton"] forState:UIControlStateNormal];
    UIImage *sliderLeftTrackImage = [[UIImage imageNamed:@"SliderStretchBar"] stretchableImageWithLeftCapWidth:15.0 topCapHeight:0.0];
    UIImage *sliderRightTrackImage = [[UIImage imageNamed:@"SliderBaseBar"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:15.0];
    [self setMinimumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
    [self setMaximumTrackImage:sliderRightTrackImage forState:UIControlStateNormal];
}

@end

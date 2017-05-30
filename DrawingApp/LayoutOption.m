//
//  LayoutOption.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 6..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "LayoutOption.h"

@implementation LayoutOption


+ (instancetype)sharedLaoutOptions{
    
    static LayoutOption *layoutOptions = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        layoutOptions  =[[self alloc]init];
        
    });
    return layoutOptions;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.options = [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil];
        
    }
    return self;
}
- (void)showingOptionsSetting:(ShowingView)options{
    NSNumber *optionNumber;
    if (options ==0) {
        optionNumber = [NSNumber numberWithInteger:0];
        [self.options replaceObjectAtIndex:0 withObject:optionNumber];
    }
    if ((options&ShowingViewForMore) !=0) {
        optionNumber = [NSNumber numberWithInteger:1];
        [self.options replaceObjectAtIndex:1 withObject:optionNumber];
        
    }
    if ((options&ShowingViewForLayer) !=0) {
        optionNumber = [NSNumber numberWithInteger:1];
         [self.options replaceObjectAtIndex:2 withObject:optionNumber];
    }
    if ((options&ShowingViewForPecilSelect) !=0) {
        optionNumber = [NSNumber numberWithInteger:1];
        [self.options replaceObjectAtIndex:3 withObject:optionNumber];
        
    }
}

- (void)hidingOptionsSetting:(HidingView)options{
    NSNumber *optionNumber;
    
    if ((options&ShowingViewForMore) !=0) {
        optionNumber = [NSNumber numberWithInteger:0];
       [self.options replaceObjectAtIndex:1 withObject:optionNumber];
    }
    if ((options&ShowingViewForLayer) !=0) {
        optionNumber = [NSNumber numberWithInteger:0];
        [self.options replaceObjectAtIndex:2 withObject:optionNumber];

    }
    if ((options&ShowingViewForPecilSelect) !=0) {
        optionNumber = [NSNumber numberWithInteger:0];
        [self.options replaceObjectAtIndex:3 withObject:optionNumber];
        
    }
}
- (BOOL)isEnableDrawing{

    for (NSInteger i=0;i<self.options.count; i++) {
        
        if([self.options[i] isEqual:@1]){
        
            return NO;
        }
    }
    return YES;
}
@end

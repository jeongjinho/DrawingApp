//
//  LayoutOption.h
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 6..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_OPTIONS (NSInteger,ShowingView)  {
    ShowingViewForNone   = 0,
    ShowingViewForLayer  = 1 << 0,
    ShowingViewForMore   = 1 << 1,
    ShowingViewForPecilSelect = 1<< 2
    
};

typedef NS_OPTIONS (NSInteger,HidingView)  {
    HidingViewForLayer  = 1 << 0,
    HidingViewForMore   = 1 << 1,
    HidingViewForPencilSelect = 1 << 2
};



@interface LayoutOption : NSObject
@property (strong,nonatomic)NSMutableArray *options;
+ (instancetype)sharedLaoutOptions;
- (void)showingOptionsSetting:(ShowingView)options;
- (void)hidingOptionsSetting:(HidingView)options;
- (BOOL)isEnableDrawing;
@end

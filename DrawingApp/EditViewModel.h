//
//  EditViewModel.h
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^completerHandler)(void);
@interface EditViewModel : NSObject
@property NSMutableArray *layerViewArray;

+ (instancetype)sharedLayer;
- (void)initialEditViewModel;
- (void)addLayerView:(completerHandler)handler;
- (void)updateLayoutView:(UIImage *)img handler:(completerHandler)handler;
@end

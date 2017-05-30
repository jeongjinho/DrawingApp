//
//  DataModel.h
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 1. 25..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
+ (instancetype)sharedData;
+ (NSArray *)loadForSubjectImage;
@end

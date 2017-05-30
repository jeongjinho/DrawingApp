//
//  DataModel.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 1. 25..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

+ (NSArray *)loadForSubjectImage{
    
    NSArray *subjectTitlesArray=@[@"ocean",@"cityView",@"animal",@"flower",@"lifeStyle"];
    NSLog(@"ㄴㅇㄴㅁㅇ%ld",subjectTitlesArray.count);
    
    return subjectTitlesArray;
    
}

+ (instancetype)sharedData{
    
    static DataModel *datObject = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        datObject  =[[self alloc]init];
        
    });
    return datObject;
}

@end

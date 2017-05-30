//
//  EditViewModel.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "EditViewModel.h"
@interface EditViewModel()

@end
@implementation EditViewModel

+ (instancetype)sharedLayer{
    
    static EditViewModel *layerObject = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        layerObject  =[[self alloc]init];
        
    });
    return layerObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initialEditViewModel];
    }
    return self;
}

- (void)initialEditViewModel{

    UIImage *firstView = [[UIImage alloc]init];
   // firstView.backgroundColor = [UIColor clearColor];
    self.layerViewArray =[[NSMutableArray alloc]init];
    [self.layerViewArray  addObject:firstView];
    
}
- (void)addLayerView:(completerHandler)handler{

    UIImage *newView = [[UIImage alloc]init];

    [self.layerViewArray addObject:newView];
    handler();
    [[NSNotificationCenter defaultCenter] postNotificationName:AddLayerNotification object:nil];
}


- (void)updateLayoutView:(UIImage *)img handler:(completerHandler)handler{
    
    NSLog(@"뷰갯수 : %lu",(unsigned long)self.layerViewArray.count);
    [self.layerViewArray replaceObjectAtIndex:self.layerViewArray.count-1 withObject:img];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:updateLayerNotification object:nil];
}


- (void)deleteLayerViewForIndex:(UIView *)seletedView{

    for (UIView *view in self.layerViewArray) {
        
        if([seletedView isEqual:view]){
         [self.layerViewArray removeObject:view];
            
        }
        
       
    }
   
    NSLog(@"선택한뷰가 없습니다.");
}


@end

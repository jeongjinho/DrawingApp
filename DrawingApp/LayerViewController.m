
//
//  LayerViewController.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 6..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "LayerViewController.h"
#import "UIView+Animation.h"
#import "LayerCollectionViewCell.h"
@interface LayerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *layerCollectionView;

@property (weak, nonatomic) IBOutlet UIView *layerScrollCotentView;
@property (weak, nonatomic) IBOutlet UIButton *basicCanvasLayerButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.layerCollectionView.delegate = self;
    self.layerCollectionView.dataSource = self;
    [EditViewModel sharedLayer];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatingView:)
                                                 name:updateLayerNotification
                                               object:nil];
}
- (void)updatingView:(NSNotification *)noti{

    if ([noti.name isEqualToString:updateLayerNotification]) {
        
        
        [self.layerCollectionView reloadData];
    }
    

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"갯수%ld",[EditViewModel sharedLayer].layerViewArray.count);
    return  [EditViewModel sharedLayer].layerViewArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath%ld",indexPath.row);
    LayerCollectionViewCell *layerCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"LayerCell" forIndexPath:indexPath];
    if([EditViewModel sharedLayer].layerViewArray.count==indexPath.row){
    [layerCell.backgroundImageView setImage:[UIImage imageNamed:@"backButton"]];
  
    } else{
    
      [layerCell.backgroundImageView setImage:[EditViewModel sharedLayer].layerViewArray[indexPath.row]];
        
    }
    return layerCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if([EditViewModel sharedLayer].layerViewArray.count<=indexPath.row){
        
        [[EditViewModel sharedLayer]addLayerView:^{
            
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:[[EditViewModel sharedLayer].layerViewArray count] - 1 inSection:0];
            [self.layerCollectionView insertItemsAtIndexPaths:@[indexPath]];
        
        }];
        
    }
   
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

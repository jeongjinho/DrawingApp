//
//  DrawViewController.m
//  DrawingApp
//
//  Created by 진호놀이터 on 2017. 2. 2..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

#import "DrawViewController.h"
#import "UIView+Animation.h"
#import "NSObject+UImage_drawing.h"
@interface DrawViewController ()<UIGestureRecognizerDelegate,UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIView *moreNavigationView;
@property (weak, nonatomic) IBOutlet UIImageView *canvasImaeView;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *currentColorButton;
@property (weak, nonatomic) IBOutlet UIView *recordingNavigationView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *canvasTapGesture;
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *pencilSelectView;
//@property (strong,nonatomic) UIView *colorView;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (strong,nonatomic) UIImageView *drawingImageView;



@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.transitioningDelegate = self;
    [self initializeAttribute];
}

- (void)initializeAttribute{

    self.tabBarController.tabBar.hidden = YES;
    [self.recordingNavigationView hideAnimationForDirection:TopDirection range:0];
    
    [self.canvasTapGesture addTarget:self action:@selector(tapInImageView:)];
    self.canvasTapGesture.delegate = self;
    self.canvasTapGesture.numberOfTapsRequired = 1;
    [self.canvasImaeView setUserInteractionEnabled:YES];
    [self.layerView hideAnimationForDirection:RightDirection range:0];
    [self.pencilSelectView hideAnimationForDirection:BottomDirection range:self.toolView.frame.size.height+40];
     [[LayoutOption sharedLaoutOptions] showingOptionsSetting:ShowingViewForNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addLayerView:)
                                                 name:AddLayerNotification
                                               object:nil];
  //  [[EditViewModel sharedLayer] initialEditViewModel];
   
    self.drawingImageView = [[UIImageView alloc]initWithFrame:self.canvasImaeView.frame];
    self.drawingImageView.image = [[UIImage alloc]init];
   
    _red = 0/255.0;
    _green = 0/255.0;
    _blue = 0/255.0;
    _brush = 3.0;
    _opacity = 1;
}
//layer noti
- (void)addLayerView:(NSNotification *)noti{

    if([noti.name isEqualToString:AddLayerNotification]){
    

        UIImageView *addedImageView = [[UIImageView alloc]init];
        addedImageView.image = [EditViewModel sharedLayer].layerViewArray.lastObject;
        [addedImageView setFrame:self.canvasImaeView.frame];
        addedImageView.tag  =[EditViewModel sharedLayer].layerViewArray.count;
        [self.canvasImaeView addSubview:addedImageView];
    
    }
}



- (IBAction)touchUpInsideMoreButton:(id)sender {
    
    [self.recordingNavigationView showAnimationForDirection:BottomDirection range:0];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if([[LayoutOption sharedLaoutOptions] isEnableDrawing] == YES){
    
        [self.moreNavigationView hideAnimationForDirection:TopDirection range:0];
        [self.toolView hideAnimationForDirection:BottomDirection range:0];
        
        
        
    }
   
   
    [ self.canvasImaeView.subviews.lastObject setNeedsDisplay];
    
    if(self.canvasImaeView.subviews.lastObject == nil){
    
        self.drawingImageView = self.canvasImaeView;
    } else {
    
          self.drawingImageView=self.canvasImaeView.subviews.lastObject;
    }
  

    _mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    _lastPoint = [touch locationInView:self.view];
  

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

  [self.canvasImaeView.subviews.lastObject setNeedsDisplay];
    
       _mouseSwiped = YES;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
       UIGraphicsBeginImageContext(self.view.frame.size);
    
    
    [ self.drawingImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue,1);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
     self.drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // [self.tempDrawImage setAlpha:_opacity];
    
    [ self.drawingImageView setNeedsDisplay];

    UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
    
    


}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if(self.toolView.translatesAutoresizingMaskIntoConstraints ==YES){
        
        [self.moreNavigationView showAnimationForDirection:BottomDirection range:0];
     [self.toolView showAnimationForDirection:TopDirection range:0];
      
        
        [self.view setNeedsDisplay];
                if(!_mouseSwiped) {
            [self touchesBegan:touches withEvent:event];
            UIGraphicsBeginImageContext(self.view.frame.size);
           
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brush);
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, _opacity);
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            CGContextFlush(UIGraphicsGetCurrentContext());
       
            UIGraphicsEndImageContext();
        }
        
        UIGraphicsBeginImageContext( self.drawingImageView.frame.size);
        [ self.drawingImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
     
         self.drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.view setNeedsDisplay];
        
        UIGraphicsEndImageContext();
    }

}
//animation
- (void)tapInImageView:(UITapGestureRecognizer*)tapGesture {
    
    if([tapGesture.view isKindOfClass:[UIImageView class]]){
    
        if(self.toolView.translatesAutoresizingMaskIntoConstraints ==YES){
            
            [self.moreNavigationView showAnimationForDirection:BottomDirection range:0];
            [self.toolView showAnimationForDirection:TopDirection range:0];
           
          
        }
      else{
        
              [self.moreNavigationView hideAnimationForDirection:TopDirection range:0];
              [self.toolView hideAnimationForDirection:BottomDirection range:0];

        }
    }
}

- (IBAction)touchInsidePencilButton:(id)sender {
    
    if(self.pencilSelectView.translatesAutoresizingMaskIntoConstraints ==YES){
        
        [self.pencilSelectView showAnimationForDirection:TopDirection range:self.toolView.frame.size.height+40];
        
        
        [[LayoutOption sharedLaoutOptions] showingOptionsSetting:ShowingViewForPecilSelect];
        
    } else {
        
        [self.pencilSelectView hideAnimationForDirection:BottomDirection range:self.toolView.frame.size.height+40];
        
        [[LayoutOption sharedLaoutOptions] hidingOptionsSetting:HidingViewForPencilSelect];
    }

    
}

- (IBAction)touchUpInsidelayerButton:(id)sender {
    
    if(self.layerView.translatesAutoresizingMaskIntoConstraints ==YES){
    
        [self.layerView showAnimationForDirection:LeftDirection range:0];
        
        NSLog(@"%@",self.drawingImageView.image);
        [[EditViewModel sharedLayer] updateLayoutView:self.drawingImageView.image handler:nil];
        
        [[LayoutOption sharedLaoutOptions] showingOptionsSetting:ShowingViewForLayer];

    } else {
        
        [self.layerView hideAnimationForDirection:RightDirection range:0];
       
          [[LayoutOption sharedLaoutOptions] hidingOptionsSetting:HidingViewForLayer];
          }
    
}
- (IBAction)BrushSizeValueChanged:(id)sender {
    UISlider * slider = sender ;
    
    self.brush = slider.value;
    
    
}

- (IBAction)touchUpInsideColorVIew:(id)sender {
    self.colorView.layer.cornerRadius = self.colorView.frame.size.height / 2;
          [UIView transitionWithView:self.colorView duration:2 options:UIViewAnimationOptionTransitionNone animations:^{
              self.colorView.transform = CGAffineTransformMakeScale(self.view.frame.size.width,self.view.frame.size.height);

       // self.colorView.transform = CGAffineTransformIdentity;
    } completion:nil];
     
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

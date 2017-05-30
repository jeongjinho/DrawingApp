#import "ViewController.h"
#import "SubjectCollectionViewCell.h"
@interface ViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *navigationBarImageView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIImageView *CenterImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *subjectTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property  CGPoint standardOffset;
@property CGFloat currentAlpha;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    
}

- (void)initialize{
    self.navigationController.navigationBar.hidden = YES;
    self.mainScrollView.delegate = self;
    self.subjectTableView.delegate = self;
    self.subjectTableView.dataSource = self;
    self.subjectTableView.backgroundColor = [UIColor clearColor];
    
    self.standardOffset =CGPointMake(0, _CenterImageView.frame.size.height- _navigationView.frame.size.height);
    self.currentAlpha = 0.0f;
    [self.navigationView setAlpha:_currentAlpha];
    [self.navigationBarImageView setAlpha:_currentAlpha];
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"%ld",[DataModel loadForSubjectImage].count);
    return [DataModel loadForSubjectImage].count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SubjectCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath
                                      ];
    cell.subjectItemImageView.image = [UIImage imageNamed:[DataModel loadForSubjectImage][indexPath.row]];
    return cell;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 테이블뷰가 터치받고
    
    if(scrollView == _subjectTableView){
        //오프셋저장
        CGPoint offset = _subjectTableView.contentOffset;
        //만약 1.5배빠르니 1.5를오프셋에 곱했는데 이게 이미지에서 네비바를뺀 기준높이보다 작거나 같을때까지 스크롤가능
        NSLog(@"스탠드%lf",_subjectTableView.contentOffset.y);
        NSLog(@"백%lf",_mainScrollView.contentOffset.y);
        if (_subjectTableView.contentOffset.y*1.50f<=_standardOffset.y) {
            //속도높이고
            offset.y = offset.y * 1.50f;
            //저장
            [_mainScrollView setContentOffset:offset animated:NO];
            
            if(_navigationView.alpha >= 0.0f){
                
                [self.navigationView setAlpha:_currentAlpha];
                [self.navigationBarImageView setAlpha:_currentAlpha];
                _currentAlpha -=0.1f;
            }
            //높다면 네비바에 하단걸치게 기준 오프셋적용
        } else if(_subjectTableView.contentOffset.y*1.50f>=_standardOffset.y){
            
            [self.mainScrollView setContentOffset:_standardOffset];
            
            if(_navigationView.alpha <= 0.5f){
                
                [self.navigationView setAlpha:_currentAlpha];
                [self.navigationBarImageView setAlpha:_currentAlpha];
                _currentAlpha +=0.1f;
            }
        }
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

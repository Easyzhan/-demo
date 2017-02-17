//
//  ViewController.m
//  放大图片
//
//  Created by Zin_戦 on 16/11/20.
//  Copyright © 2016年 Zin_戦. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


//设置放大后图片的宽高，为了省时间，偷了下懒，建议最好结合实际做下运算
#define BIG_IMG_WIDTH  325
#define BIG_IMG_HEIGHT 325

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *seeImage;

@end

@implementation ViewController
UIView *background;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    ZYSpreadButton *zb1 = [[ZYSpreadButton alloc] initWithBackgroundImage:[UIImage imageNamed:@"click"] highlightImage:[UIImage imageNamed:@"clock_highlight"]position:CGPointMake(0, 0)];
//    
//    ZYSpreadSubButton *sb = [[ZYSpreadSubButton alloc] initWithBackgroundImage:[UIImage imageNamed:@"powerButton"] highlightImage:[UIImage imageNamed:@"powerButton_highlight"] clickedBlock:^(int index, UIButton *sender) {
//        
//    }];
//    
//    
//    zb1.subButtons = [NSArray arrayWithObjects:sb,sb, nil];
    
//    [self.view addSubview:zb1];
    
    
    //允许用户交互
    _seeImage.userInteractionEnabled = YES;
    //添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_seeImage addGestureRecognizer:tapGesture];
}
//点击图片后的方法(即图片的放大全屏效果)
- (void) tapAction{
    //创建一个黑色背景
    //初始化一个用来当做背景的View。我这里为了省时间计算，宽高直接用的5s的尺寸
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    background = bgView;
    [bgView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bgView];
    
    //创建显示图像的视图
    //初始化要显示的图片内容的imageView（这里位置继续偷懒...没有计算）
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
    //要显示的图片，即要放大的图片
    [imgView setImage:[UIImage imageNamed:@"屏幕快照 2016-11-19 下午4.46.45 (2)"]];
    [bgView addSubview:imgView];
    
    imgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [imgView addGestureRecognizer:tapGesture];
    
    [self shakeToShow:imgView];//放大过程中的动画,可以给背景添加动画也可以给img添加动画
}
-(void)closeView{
    [background removeFromSuperview];
    
    
}
//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
}
@end

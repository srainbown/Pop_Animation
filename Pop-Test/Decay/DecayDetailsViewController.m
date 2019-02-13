//
//  DecayDetailsViewController.m
//  Pop-Test
//
//  Created by mac on 13/02/2019.
//  Copyright © 2019 Woodsoo. All rights reserved.
//

#import "DecayDetailsViewController.h"

@interface DecayDetailsViewController () <POPAnimationDelegate>

@property (nonatomic, strong) UIImageView *image;

@end

@implementation DecayDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -- 懒加载
- (UIImageView *)image{
    if (_image == nil) {
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(137.5, 150, 100, 100)];
        [self.view addSubview:_image];
        _image.layer.masksToBounds = YES;
        _image.layer.cornerRadius = 50;
        _image.backgroundColor = [UIColor orangeColor];
        _image.userInteractionEnabled = YES;
    }
    return _image;
}

- (void)setSpringType:(NSString *)springType{
    if ([springType isEqualToString:SpringType_kPOPLayerPosition]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self.image addGestureRecognizer:pan];
    }
}

#pragma mark -- 点击事件
-(void)handlePan:(UIPanGestureRecognizer *)pan{
//    [self.image.layer pop_removeAllAnimations];
    //拖拽
    CGPoint translation = [pan translationInView:self.view];
    pan.view.center = CGPointMake(pan.view.center.x + translation.x
                                  ,pan.view.center.y + translation.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
    //拖拽动作结束
    if (pan.state == UIGestureRecognizerStateEnded) {
        //计算出移动速度
        CGPoint velocity = [pan velocityInView:self.view];
        //衰减动画
        POPDecayAnimation *pop = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        pop.delegate = self;
        //设置速度动画
        pop.velocity = [NSValue valueWithCGPoint:velocity];
        [self.image.layer pop_addAnimation:pop forKey:@"kPOPLayerPosition"];
    }

}



@end

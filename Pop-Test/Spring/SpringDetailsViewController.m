//
//  SpringDetailsViewController.m
//  Pop-Test
//
//  Created by mac on 11/02/2019.
//  Copyright © 2019 Woodsoo. All rights reserved.
//

#import "SpringDetailsViewController.h"

@interface SpringDetailsViewController ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, assign) BOOL isOpened;
@property (nonatomic, assign) CGRect hidePosition;
@property (nonatomic, assign) CGRect showPosition;
@property (nonatomic, strong) UIView *popView;

@end

@implementation SpringDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isOpened = NO;
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
    if ([springType isEqualToString:SpringType_kPOPLayerSize]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kPOPLayerSize_imageTapClick)];
        [self.image addGestureRecognizer:tap];
    }else if([springType isEqualToString:SpringType_kPOPLayerPosition]){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kPOPLayerPosition_imageTapClick)];
        [self.image addGestureRecognizer:tap];
    }else if ([springType isEqualToString:SpringType_kPOPLayerPositionY]){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(showPop)];
        _popView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 64, 0, 0)];
        [self.view addSubview:_popView];
        _popView.backgroundColor = [UIColor redColor];
        _showPosition = CGRectMake(SCREEN_WIDTH-100, 64, 100, 100);
        _hidePosition = _popView.frame;
    }

    
}

#pragma mark -- 动画事件
-(void)kPOPLayerSize_imageTapClick{
    POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    CGRect rect = self.image.frame;
    if (rect.size.width == 100) {
        pop.toValue = [NSValue valueWithCGSize:CGSizeMake(200, 200)];
        self.image.layer.cornerRadius = 100;
    }else{
        pop.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
        self.image.layer.cornerRadius = 50;
    }
    // 振幅 可以设置的范围是0-20，默认为4。值越大振动的幅度越大
    pop.springBounciness = 20;
    // 速度 可以设置的范围是0-20，默认为12.值越大速度越快，结束的越快
    pop.springSpeed = 5;
    [self.image.layer pop_addAnimation:pop forKey:@"kPOPLayerSize"];
}

-(void)kPOPLayerPosition_imageTapClick{
    POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    CGPoint point = self.image.center;
    if (point.y == 200) {
        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, 500)];
    }else{
        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, 200)];
    }
    pop.springSpeed = 20.0;
    pop.springBounciness = 20.0;
    [self.image pop_addAnimation:pop forKey:@"kPOPLayerPosition"];
}

-(void)showPop{
    if (_isOpened) {
        [self hidePop];
        return;
    }
    _isOpened = YES;
    POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    pop.fromValue = [NSValue valueWithCGRect:_hidePosition];
    pop.toValue = [NSValue valueWithCGRect:_showPosition];
    pop.springSpeed = 20.0;
    pop.springBounciness = 15.0;
    [_popView pop_addAnimation:pop forKey:@"kPOPViewFrame"];
}

-(void)hidePop{
    POPBasicAnimation *pop = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    pop.fromValue = [NSValue valueWithCGRect:_showPosition];
    pop.toValue = [NSValue valueWithCGRect:_hidePosition];
    [_popView pop_addAnimation:pop forKey:@"kPOPViewFrame"];
    _isOpened = NO;
}

















@end

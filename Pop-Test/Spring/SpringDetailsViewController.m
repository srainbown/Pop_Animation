//
//  SpringDetailsViewController.m
//  Pop-Test
//
//  Created by mac on 11/02/2019.
//  Copyright © 2019 Woodsoo. All rights reserved.
//

/*
 NSString * const kPOPLayerBackgroundColor = @"backgroundColor";  //背景色
 NSString * const kPOPLayerBounds = @"bounds";  //坐标
 NSString * const kPOPLayerCornerRadius = @"cornerRadius";  //圆形 值越大,角就越圆
 NSString * const kPOPLayerBorderWidth = @"borderWidth";  //边框宽度
 NSString * const kPOPLayerBorderColor = @"borderColor";  //边框色
 NSString * const kPOPLayerOpacity = @"opacity"; //透明度
 NSString * const kPOPLayerPosition = @"position"; //位置 position是相对于屏幕的
 NSString * const kPOPLayerPositionX = @"positionX";
 NSString * const kPOPLayerPositionY = @"positionY";
 NSString * const kPOPLayerRotation = @"rotation"; //旋转
 NSString * const kPOPLayerRotationX = @"rotationX";
 NSString * const kPOPLayerRotationY = @"rotationY";
 NSString * const kPOPLayerScaleX = @"scaleX"; //缩放系数
 NSString * const kPOPLayerScaleXY = @"scaleXY"; //XY缩放系数
 NSString * const kPOPLayerScaleY = @"scaleY"; //Y缩放系数
 NSString * const kPOPLayerSize = @"size";  //大小
 NSString * const kPOPLayerSubscaleXY = @"subscaleXY";
 NSString * const kPOPLayerSubtranslationX = @"subtranslationX";
 NSString * const kPOPLayerSubtranslationXY = @"subtranslationXY";
 NSString * const kPOPLayerSubtranslationY = @"subtranslationY";
 NSString * const kPOPLayerSubtranslationZ = @"subtranslationZ";
 NSString * const kPOPLayerTranslationX = @"translationX"; //X轴平移量
 NSString * const kPOPLayerTranslationXY = @"translationXY"; //XY轴平移量
 NSString * const kPOPLayerTranslationY = @"translationY"; //Y轴平移量
 NSString * const kPOPLayerTranslationZ = @"translationZ"; //Z轴平移量
 NSString * const kPOPLayerZPosition = @"zPosition";  //遮挡属性
 NSString * const kPOPLayerShadowColor = @"shadowColor"; //设置阴影
 NSString * const kPOPLayerShadowOffset = @"shadowOffset"; //阴影偏移
 NSString * const kPOPLayerShadowOpacity = @"shadowOpacity"; //阴影透明度
 NSString * const kPOPLayerShadowRadius = @"shadowRadius"; //阴影半径
 
 // CAShapeLayer
 NSString * const kPOPShapeLayerStrokeStart = @"shapeLayer.strokeStart";
 //strokeStart  动画的fromValue = 0，toValue = 1 表示从路径的0位置画到1 怎么画是按照清除开始的位置也就是清除0 一直清除到1 效果就是一条路径慢慢的消失  strokeStart  动画的fromValue = 1，toValue = 0 表示从路径的1位置画到0 怎么画是按照清除开始的位置也就是1 这样开始的路径是空的（即都被清除掉了）一直清除到0 效果就是一条路径被反方向画出来
 NSString * const kPOPShapeLayerStrokeEnd = @"shapeLayer.strokeEnd";
 // strokeEnd  动画的fromValue = 0，toValue = 1  表示 这里我们分3个点说明动画的顺序  strokeEnd从结尾开始清除 首先整条路径先清除后2/3，接着清除1/3 效果就是正方向画出路径     strokeEnd  动画的fromValue = 1，toValue = 0 效果就是反方向路径慢慢消失
 NSString * const kPOPShapeLayerStrokeColor = @"shapeLayer.strokeColor";  //画笔的色
 NSString * const kPOPShapeLayerFillColor = @"shapeLayer.fillColor";
 NSString * const kPOPShapeLayerLineWidth = @"shapeLayer.lineWidth"; //线的宽度
 NSString * const kPOPShapeLayerLineDashPhase = @"shapeLayer.lineDashPhase";
 */

#import "SpringDetailsViewController.h"

@interface SpringDetailsViewController ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, assign) BOOL isOpened;
@property (nonatomic, assign) CGRect hidePosition;
@property (nonatomic, assign) CGRect showPosition;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, assign) BOOL iskPOPLayerScaleXY;

@end

@implementation SpringDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isOpened = NO;
    self.iskPOPLayerScaleXY = NO;
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
    }else if ([springType isEqualToString:SpringType_kPOPViewFrame]){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(showPop)];
        _popView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 64, 0, 0)];
        [self.view addSubview:_popView];
        _popView.backgroundColor = [UIColor redColor];
        _showPosition = CGRectMake(SCREEN_WIDTH-100, 64, 100, 100);
        _hidePosition = _popView.frame;
    }else if ([springType isEqualToString:SpringType_kPOPLayerPositionY]){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kPOPLayerPositionY_imageTapClick)];
        [self.image addGestureRecognizer:tap];
    }else if ([springType isEqualToString:SpringType_kPOPLayerScaleXY]){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kPOPLayerScaleXY_imageTapClick)];
        [self.image addGestureRecognizer:tap];
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
    pop.springSpeed = 10.0;
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
    pop.springBounciness = 10.0;
    [self.image.layer pop_addAnimation:pop forKey:@"kPOPLayerPosition"];
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
    pop.springBounciness = 10.0;
    [_popView.layer pop_addAnimation:pop forKey:@"kPOPViewFrame"];
}

-(void)hidePop{
    POPBasicAnimation *pop = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    pop.fromValue = [NSValue valueWithCGRect:_showPosition];
    pop.toValue = [NSValue valueWithCGRect:_hidePosition];
    [_popView.layer pop_addAnimation:pop forKey:@"kPOPViewFrame"];
    _isOpened = NO;
}

-(void)kPOPLayerPositionY_imageTapClick{
    POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    pop.fromValue = @(100);
    pop.toValue = @(300);
    pop.springBounciness = 10.0;
    pop.springSpeed = 10.0;
//    //拉力    影响回弹力度以及速度
//    pop.dynamicsTension = 200;
//    //摩擦力   如果开启，动画会不断重复，幅度逐渐削弱，直到停止。
//    pop.dynamicsFriction = 100;
    //质量    细微的影响动画的回弹力度以及速度
    pop.dynamicsMass = 10;
    //beginTime     表示动画的起始时间，＋1.0f表示向后延时 1s
//    pop.beginTime = CACurrentMediaTime() +1.f;表示动画的起始时间，＋1.0f表示向后延时 1s
    [self.image.layer pop_addAnimation:pop forKey:@"kPOPLayerPositionY"];
}

-(void)kPOPLayerScaleXY_imageTapClick{
    if (self.iskPOPLayerScaleXY) {
        POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        pop.springBounciness = 20.0;
        pop.springSpeed = 10.0;
        pop.dynamicsTension  = 300;
        [self.image.layer pop_addAnimation:pop forKey:@"kPOPLayerScaleXY"];
        self.iskPOPLayerScaleXY = NO;
    }else{
        POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
        pop.springBounciness = 20.0;
        pop.springSpeed = 10.0;
        pop.dynamicsTension  = 300;
        [self.image.layer pop_addAnimation:pop forKey:@"kPOPLayerScaleXY"];
        self.iskPOPLayerScaleXY = YES;
    }
}













@end

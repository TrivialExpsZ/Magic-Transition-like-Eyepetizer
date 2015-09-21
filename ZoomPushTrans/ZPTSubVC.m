//
//  ZPTSubVC.m
//  ZoomPushTrans
//
//  Created by zhongdian on 15/9/15.
//  Copyright (c) 2015年 zhongdian. All rights reserved.
//

#import "ZPTSubVC.h"
#import "ZPTMagicBackTransition.h"
#import "ZPTTableVC.h"
#import "ZPTiMagicTrans.h"

@interface ZPTSubVC () <ZPTiMagicTransDestination,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *maskOfImage;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZPTSubVC

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.delegate = self;
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _maskOfImage = [[UIView alloc] init];
    _maskOfImage.clipsToBounds = YES;
    _imageView = [[UIImageView alloc] init];
    UIImage *imagen = [UIImage imageNamed:@"food.jpeg"];
    [_imageView setImage:imagen];
    CGRect pantalla = [[UIScreen mainScreen] bounds];
    [_maskOfImage setFrame:CGRectMake(0, 64, pantalla.size.width, 240.0)];
    CGFloat alturaEscala = pantalla.size.width / imagen.size.width *imagen.size.height;
    CGFloat rebosanteY = 30.0;
    CGFloat origenY = 0.5 * (imagen.size.height - alturaEscala);
    [_imageView setFrame:CGRectMake(0, -origenY + rebosanteY,  pantalla.size.width, alturaEscala)];
    [_maskOfImage addSubview:_imageView];
    [self.view addSubview:_maskOfImage];

}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC
{
    
    if ([toVC isKindOfClass:[ZPTTableVC class]]) {
        return [[ZPTMagicBackTransition alloc] init];
    }else{
        return nil;
    }
}

//  4、 interaction For Dismissal 交互返回（eg：系统的左侧滑动返回） 时调用
//      哪个是  pan dismiss 时的方法
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    //    此处 代码执行顺序 ： 由 3 处到这里
    if ([animationController isKindOfClass:[ZPTMagicBackTransition class]]) {
        return nil;//todo
    }else{
        return nil;
    }
}

-(UIImageView *)getDestinationImageView{
    return self.imageView;
}

-(UIView *)getMaskOfImageView{
    return self.maskOfImage;
}



@end

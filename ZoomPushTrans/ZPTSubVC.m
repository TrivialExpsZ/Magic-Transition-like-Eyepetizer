//
//  ZPTSubVC.m
//  ZoomPushTrans
//
//  Created by zhongdian on 15/9/15.
//  Copyright (c) 2015年 zhongdian. All rights reserved.
//

#import "ZPTSubVC.h"
#import "ZPTiMagicTrans.h"

@interface ZPTSubVC () <ZPTiMagicTransDestination>

@property (nonatomic, strong) UIView *maskOfImage;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZPTSubVC

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
    CGFloat origenY = 0.5 * (imagen.size.height - alturaEscala);
    [_imageView setFrame:CGRectMake(0, -origenY,  pantalla.size.width, alturaEscala)];
    [_maskOfImage addSubview:_imageView];
    [self.view addSubview:_maskOfImage];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIImageView *)getDestinationImageView{
    return self.imageView;
}

@end

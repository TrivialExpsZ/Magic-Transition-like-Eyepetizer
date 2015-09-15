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
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ZPTSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    _imageView.clipsToBounds = YES;
    CGSize targetSize = [[UIImage imageNamed:@"food.jpeg"] size];
    CGFloat targetRatio = targetSize.height/targetSize.width;
    _imageView.transform = CGAffineTransformMakeScale(1.6, 1.6*targetRatio);
     */
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImageView *)getDestinationImageView{
    return self.imageView;
}

@end

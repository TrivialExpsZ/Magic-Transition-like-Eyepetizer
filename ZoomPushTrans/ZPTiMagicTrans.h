//
//  ZPTiMagicTrans.h
//  ZoomPushTrans
//
//  Created by zhongdian on 15/9/15.
//  Copyright (c) 2015年 zhongdian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZPTiMagicTransSource <NSObject>

-(CGRect)getFinalTransRect;
-(void)setFinalTransRect:(CGRect)rect;
-(NSIndexPath *)getFinalIndexPath;
-(void)setFinalIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ZPTiMagicTransDestination <NSObject>

-(UIImageView *)getDestinationImageView;
-(UIView *)getMaskOfImageView;

@end

@protocol ZPTiMagicTransCell <NSObject>

@property (strong, nonatomic) UIView *destinationScaleView;
@property (strong, nonatomic) UIImageView *transImgView;

@end

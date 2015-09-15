//
//  ZPTTableCell.m
//  ZoomPushTrans
//
//  Created by zhongdian on 15/9/15.
//  Copyright (c) 2015年 zhongdian. All rights reserved.
//

#import "ZPTTableCell.h"
#import "ZPTiMagicTrans.h"

@interface ZPTTableCell() <ZPTiMagicTransCell>

@end

@implementation ZPTTableCell

- (void)awakeFromNib {
    self.clipsToBounds = YES;
    CGSize targetSize = [[UIImage imageNamed:@"food.jpeg"] size];
    CGFloat targetRatio = targetSize.height/targetSize.width;
    //_transImgView.transform = CGAffineTransformMakeScale(1.5, 1.5*targetRatio);
    _transImgView.clipsToBounds = YES;
    //不能使用contentMode = UIViewContentModeScaleAspectFill;
    //因为动画与这个模式不兼容
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end

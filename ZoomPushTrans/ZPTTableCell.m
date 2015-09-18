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

/**
 *  这个方法是作废了的，代码自定义cell应当使用initWithStyle
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (instancetype) initWithFrame:(CGRect)frame {
    return self;
}

/**
 *  创建一个无视宽高比，把图居中的Cell。
 *  主要注意的问题是，image.size.height属性，是像素数。
 *  而对于屏幕，[[UIScreen mainScreen] bounds].size.height则是点数。
 *  然而对x缩放以后，按比例也把y变成点数了。
 *  另外，由于是对Cell里的imageView操作，可以直接使用frame。如果对外面contentView则需要使用bounds。
 *
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 */
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        _transImgView = [[UIImageView alloc] init];
        UIImage *imagen = [UIImage imageNamed:@"food.jpeg"];
        [_transImgView setImage:imagen];
        CGRect pantalla = [[UIScreen mainScreen] bounds];
        CGFloat alturaEscala = pantalla.size.width / imagen.size.width *imagen.size.height;
        CGFloat origenY = 0.5 * (imagen.size.height - alturaEscala);
        [_transImgView setFrame:CGRectMake(0, -origenY,  pantalla.size.width, alturaEscala)];
        [self.contentView addSubview:_transImgView];
        
        //不能使用contentMode = UIViewContentModeScaleAspectFill;
        //因为动画与这个模式不兼容
    }
    return self;
}
@end

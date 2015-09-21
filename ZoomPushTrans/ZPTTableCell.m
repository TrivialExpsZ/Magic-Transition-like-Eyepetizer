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
        CGRect pantalla = [[UIScreen mainScreen] bounds];
        
        _destinationScaleView = [[UIView alloc] init];
        //参数rebosanteY：（cell高度-destination的高度）/2.0
        //如果使用self.contentView.bounds.size.height会出默认高度44.0
        CGFloat rebosanteY = 30.0;
        [_destinationScaleView setFrame:CGRectMake(0, -rebosanteY, pantalla.size.width, 240.0)];
        _transImgView = [[UIImageView alloc] init];
        UIImage *imagen = [UIImage imageNamed:@"food.jpeg"];
        [_transImgView setImage:imagen];
        
        CGFloat alturaEscala = pantalla.size.width / imagen.size.width *imagen.size.height;
        CGFloat origenY = 0.5 * (imagen.size.height - alturaEscala);
        [_transImgView setFrame:CGRectMake(0, -origenY + rebosanteY,  pantalla.size.width, alturaEscala)];
        [_destinationScaleView addSubview:_transImgView];
        [self.contentView addSubview:_destinationScaleView];
        
        //不能使用contentMode = UIViewContentModeScaleAspectFill;
        //因为动画与这个模式不兼容
    }
    return self;
}
@end

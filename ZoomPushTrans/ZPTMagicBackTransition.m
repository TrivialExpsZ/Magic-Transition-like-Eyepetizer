//
//  ZPTMagicBackTransition.m
//  ZoomPushTrans
//
//  Created by zhongdian on 15/9/21.
//  Copyright (c) 2015年 zhongdian. All rights reserved.
//

#import "ZPTMagicBackTransition.h"
#import "ZPTiMagicTrans.h"

@implementation ZPTMagicBackTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //容器View是用来装下这个转场的地方
    UIView *containerView = [transitionContext containerView];
    
    //获取来和去两个VC，但是返回的时候互换了位置，toVC是当前vc
    UITableViewController<ZPTiMagicTransSource> *fromVC = (UITableViewController<ZPTiMagicTransSource> *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController<ZPTiMagicTransDestination> *toVC = (UIViewController<ZPTiMagicTransDestination> *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //对大图截图
    UIView *snapShotView = [[toVC getMaskOfImageView] snapshotViewAfterScreenUpdates:NO];
    //将大图的frame转换给截图的view
    snapShotView.frame = [containerView convertRect:[toVC getMaskOfImageView].frame fromView:[toVC getMaskOfImageView].superview];
    //将原大图隐藏
    [toVC getMaskOfImageView].hidden = YES;
    
    //获取到点击的cell，先隐藏cell内容
    UITableViewCell<ZPTiMagicTransCell> *cell = (UITableViewCell<ZPTiMagicTransCell> *)[fromVC.tableView cellForRowAtIndexPath:[fromVC getFinalIndexPath]];
    cell.destinationScaleView.hidden = YES;
    
    //  3、设置 第二个控制器（要出现的） 的位置、透明度先 设置为 0， 目标 cell 图 先隐藏
    fromVC.view.frame = [transitionContext finalFrameForViewController:fromVC];
    
    
    //    ----------------------- *************************** ————————————————————————————————
    
    //  4、把动画前后的两个 VC 加到容器中 (加的先后顺序  有 影响 ！！！！！！ )
    //      要把 to VC 加下边
    [containerView addSubview:snapShotView];
    [containerView insertSubview:fromVC.view belowSubview:toVC.view];
    
    //    ----------------------- *************************** ————————————————————————————————
    
    //  5、动起来。
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        //    5.1、第二个控制器的透明度1~0；
        //        让截图的位置更新到 toVC 的 大图 所在位置后
        toVC.view.alpha = .0f;
        snapShotView.frame = [fromVC getFinalTransRect];  //  就是 cell 上 image 的frame
        
        
    } completion:^(BOOL finished) {
        
        //      5.2 截图覆盖上去后，大图 取消隐藏，截图移除
        //          原始的 cell上的图片 取消 隐藏
        cell.destinationScaleView.hidden = NO;
        [snapShotView removeFromSuperview];
        
        ([toVC getMaskOfImageView]).hidden = NO;
        
        //      5.3、告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
    
}

@end

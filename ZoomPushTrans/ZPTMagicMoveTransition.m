//
//  ZPTMagicMoveTransition.m
//  ZoomPushTrans
//
//  Created by zhongdian on 15/9/15.
//  Copyright (c) 2015年 zhongdian. All rights reserved.
//

#import "ZPTMagicMoveTransition.h"

#import "ZPTiMagicTrans.h"

@implementation ZPTMagicMoveTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //容器View是用来装下这个转场的地方
    UIView *containerView = [transitionContext containerView];
    
    //获取来和去两个VC
    UITableViewController<ZPTiMagicTransSource> *fromVC = (UITableViewController<ZPTiMagicTransSource> *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController<ZPTiMagicTransDestination> *toVC = (UIViewController<ZPTiMagicTransDestination> *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取点击的cell
    [fromVC setFinalIndexPath:[fromVC.tableView indexPathForSelectedRow]];
    UITableViewCell<ZPTiMagicTransCell> *cell = (UITableViewCell<ZPTiMagicTransCell> *)[fromVC.tableView cellForRowAtIndexPath:[fromVC.tableView indexPathForSelectedRow]];
    
    //获取展示用的ImageView
    UIImageView *destinationImageView = [toVC getDestinationImageView];
    CGRect ha = [containerView convertRect:destinationImageView.frame fromView:toVC.view];
    
    //对cell截图备用，iOS7 方法
    UIView *snapShotView = [cell.transImgView snapshotViewAfterScreenUpdates:NO];
    
    //移花接木
    CGRect finalRect = [containerView convertRect:cell.transImgView.frame fromView:cell.transImgView.superview];
    [fromVC setFinalTransRect:finalRect];
    snapShotView.frame = finalRect;
    cell.transImgView .hidden = YES;
    
    //把两个View加入容器，注意顺序有影响
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    //动画，[self transitionDuration:transitionContext] 这个时间要和 usingSpringWithDamping一致，或更快
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.alpha = 1.0;
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGRect destinationRect = CGRectMake(0, 64, screenRect.size.width , 250);
        snapShotView.frame = [containerView convertRect:destinationRect fromView:toVC.view];
    } completion:^(BOOL finished) {
        cell.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        toVC.getDestinationImageView.hidden = NO;
        //告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end

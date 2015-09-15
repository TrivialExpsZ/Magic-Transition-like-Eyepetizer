//
//  ZPTTableVC.m
//  ZoomPushTrans
//
//  Created by zhongdian on 15/9/15.
//  Copyright (c) 2015年 zhongdian. All rights reserved.
//

#import "ZPTTableVC.h"

#import "ZPTSubVC.h"
#import "ZPTTableCell.h"
#import "ZPTiMagicTrans.h"
#import "ZPTMagicMoveTransition.h"

static NSString * const reuseIdentifier = @"TableCell";

@interface ZPTTableVC ()<UINavigationControllerDelegate,ZPTiMagicTransSource>

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,assign) CGRect cellRect;

@end

@implementation ZPTTableVC

/**
 *  参考代码中使用的是ViewDidAppear并且没有调用[super viewDidAppear]
 *
 *  @param animated you know
 */
- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.delegate = self;
    [super viewDidAppear:animated];
}

-(void)viewDidLoad{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

/**
 *  当Navigation Controller在顶上叠一层新VC时被调用
 *
 *  @param navigationController <#navigationController description#>
 *  @param operation            <#operation description#>
 *  @param fromVC               <#fromVC description#>
 *  @param toVC                 <#toVC description#>
 *
 *  @return <#return value description#>
 */
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[ZPTSubVC class]]) {
        return [[ZPTMagicMoveTransition alloc] init];
    }else{
        return nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPTTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"fromListToDetail" sender:self];
}

#pragma mark - Magic Transition

/**
 *  确保这个方法是触发了ZPTiMagicTrans之后才被调用的
 *
 *  @return
 */
-(NSIndexPath *)getFinalIndexPath{
    if (!_indexPath) {
       return _indexPath;
    }
    return nil;
}

-(CGRect)getFinalTransRect{
    return _cellRect;
}

-(void)setFinalTransRect:(CGRect)rect{
    self.cellRect = rect;
}

-(void)setFinalIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
}

@end

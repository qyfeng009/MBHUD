//
//  ViewController.m
//  MBHUD
//
//  Created by 009 on 2017/10/8.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import "ViewController.h"
#import "MBHUD.h"
#import "QAnimationSuccess.h"
#import "QAnimationBallClipRotate.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> {
    float pro;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController
- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.dataArray addObject:@[@"显示文字信息"]];
    [self.dataArray addObject:@[@"显示成功图片", @"显示失败图片", @"显示警告图片", @"显示自定义图片"]];
    [self.dataArray addObject:@[@"显示Loading", @"显示LoadingSmall", @"显示LoadingCircle", @"显示自定义帧动画", @"显示CustomView"]];
    [self.dataArray addObject:@[@"显示AnnularDeterminate", @"显示DeterminateHorizontalBar", @"显示Determinate"]];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithRed:.337f green:.57f blue:.731f alpha:1.f];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [cell.textLabel.textColor colorWithAlphaComponent:0.1f];
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [MBHUD showTitle:@"欲买桂花同载酒，终不似，少年游" onView:self.view];
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [MBHUD showSuccess:@"完成" onView:self.view];
                break;
            case 1:
                [MBHUD showError:@"失败" onView:self.view];
                break;
            case 2:
                [MBHUD showWarning:@"失败" onView:self.view];
                break;
            case 3:
                [MBHUD showCustomImage:[UIImage imageNamed:@"loading_5_1"] title:@"customer" onView:self.view];
                break;

            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [MBHUD showLoading:@"加载中..." onView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBHUD showSuccess:@"完成" onView:self.view];
            });
        }
        if (indexPath.row == 1) {
            [MBHUD showLoadingSmall:@"加载中..." onView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBHUD hide];
            });
        }
        if (indexPath.row == 2) {
            [MBHUD showLoadingCircle:@"加载中..." onView:self.view];
            [MBHUD setHUDBezelViewColor:[UIColor yellowColor]];
            [MBHUD setHUDContentColor:[UIColor redColor]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBHUD hide];
            });
        }
        if (indexPath.row == 3) {
            [MBHUD showCustomAnimationWithImageArray:[self getRandomImgArry] onView:self.view];
            [MBHUD setHUDBackgroundViewColor:[UIColor colorWithWhite:0.f alpha:0.3f]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBHUD hide];
            });
        }
        if (indexPath.row == 4) {
            QAnimationBallClipRotate *ballClipRotate = [[QAnimationBallClipRotate alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
                QAnimationSuccess *animationSucces = [[QAnimationSuccess alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
                animationSucces.animationType = QAnimationTypeSuccess;
                [MBHUD showCustomView:ballClipRotate onView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ballClipRotate removeFromSuperview];
                [MBHUD showCustomView:animationSucces onView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBHUD hide];
                });
            });
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            pro = 0.0f;
            [MBHUD showAnnularDeterminate:@"loading" onView:self.view];
            [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.1f];
        }
        if (indexPath.row == 1) {
            pro = 0.0f;
            [MBHUD showDeterminateHorizontalBar:@"loading" onView:self.view];
            [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.1f];
        }
        if (indexPath.row == 2) {
            pro = 0.0f;
            [MBHUD showDeterminate:@"loading" onView:self.view];
            [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.1f];
        }
    }
}

- (void)increaseProgress {
    pro += 0.05f;
    [MBHUD setHUDDeterminateProgress:pro];

    if(pro < 1.0f){
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.1f];
    } else {
        [MBHUD showSuccess:@"完成" onView:self.view];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)getRandomImgArry {
    NSMutableArray *imageArr = [NSMutableArray array];
    //1 - 8 的随机数
    int y = (arc4random() % 8) + 1;

    int I = 0;

    if (y == 1) {

        I = 12 + 1;

    } else if (y == 2) {

        I = 8 + 1;

    }else if (y == 3) {

        I = 16 + 1;

    }else if (y == 4) {

        I = 50 + 1;

    }else if (y == 5) {

        I = 23 + 1;

    }else if (y == 6) {

        I = 13 + 1;

    }else if (y == 7) {

        I = 22 + 1;

    }else if (y == 8) {

        I = 70 + 1;
    }


    for (int i = 1; i < I; i ++ ) {

        [imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d_%d",y,i]]];
    }

    return [imageArr copy];
}
@end

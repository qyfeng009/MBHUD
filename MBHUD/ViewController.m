//
//  ViewController.m
//  MBHUD
//
//  Created by 009 on 2017/10/8.
//  Copyright © 2017年 qyfeng. All rights reserved.
//

#import "ViewController.h"
#import "QAnimationSuccess.h"
#import "QAnimationBallClipRotate.h"
#import "MBHUDHeader.h"

@interface MBExample : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL selector;

@end

@implementation MBExample

+ (instancetype)exampleWithTitle:(NSString *)title selector:(SEL)selector {
    MBExample *example = [[self class] new];
    example.title = title;
    example.selector = selector;
    return example;
}
@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> {
    float pro;
}
@property (nonatomic, strong) NSArray<NSArray<MBExample *> *> *examples;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    self.examples =
    @[@[[MBExample exampleWithTitle:@"show text in middle" selector:@selector(showTextInMiddle)],
        [MBExample exampleWithTitle:@"show text in bottom" selector:@selector(showTextInBottom)]],

      @[[MBExample exampleWithTitle:@"show success" selector:@selector(showSuccess)],
        [MBExample exampleWithTitle:@"show failed" selector:@selector(showFailed)],
        [MBExample exampleWithTitle:@"show warning" selector:@selector(showWarning)],
        [MBExample exampleWithTitle:@"show custom image" selector:@selector(showCustomImage)]],

      @[[MBExample exampleWithTitle:@"show loading" selector:@selector(showLoading)],
        [MBExample exampleWithTitle:@"show loading small" selector:@selector(showLoadingSmall)],
        [MBExample exampleWithTitle:@"show loading circle" selector:@selector(showLoadingCircle)],
        [MBExample exampleWithTitle:@"show loading ChaseR" selector:@selector(showLoadingChaseR)],
        [MBExample exampleWithTitle:@"show loading frameAmimation" selector:@selector(showLoadingFrameAmimation)],
        [MBExample exampleWithTitle:@"show custom view" selector:@selector(showCustomView)]],

      @[[MBExample exampleWithTitle:@"show annular determinate mode" selector:@selector(annularDeterminateExample)],
        [MBExample exampleWithTitle:@"show bar determinate mode" selector:@selector(barDeterminateExample)],
        [MBExample exampleWithTitle:@"show determinate mode" selector:@selector(determinateExample)]]
      ];

}
- (void)showTextInMiddle {
    [MBHUD showHUDToView:self.view].setEnabled().showText(@"欲买桂花同载酒，终不似，少年游。");
}
- (void)showTextInBottom {
    MBHUD *hud = [MBHUD showHUDToView:self.navigationController.tabBarController.view];
    [hud showTextInBottom:@"杨柳依依"];
}
- (void)showSuccess {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showSuccess:@"success"];
}
- (void)showFailed {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showFailed:@"failed"];
}
- (void)showWarning {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showWarning:@"warning"];
    [hud setDarkStyle];
}
- (void)showCustomImage {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showImage:[UIImage imageNamed:@"loading_6_1"] title:@"bored daze"];
}
- (void)showLoading {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showLoading:@"Loading..."];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(3.);
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud showFailed:@"failed..."];
        });
    });
}
- (void)showLoadingSmall {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showLoadingSmall:@""];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(3.);
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide];
        });
    });
}
- (void)showLoadingCircle {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showLoadingCircle:@"loading..."];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(3.);
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud showFailed:@"failed..."];
        });
    });
}
- (void)showLoadingChaseR {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showLoadingChaseR:nil];
    [hud setMBBackgroundStyleBlur];
    [hud setBezelViewStyleSolidColor];
    [hud setBezelViewColor:[UIColor clearColor]];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(3.);
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide];
        });
    });

}
- (void)showLoadingFrameAmimation {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showFrameAnimationWithImageArray:[self getRandomImgArry]];
    [hud setMBBackgroundViewColor:[UIColor colorWithWhite:0.f alpha:0.3f]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide];
    });
}
- (void)showCustomView {
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    QAnimationBallClipRotate *ballClipRotate = [[QAnimationBallClipRotate alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
    QAnimationSuccess *animationSucces = [[QAnimationSuccess alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
    animationSucces.animationType = QAnimationTypeSuccess;
    [hud showCustomView:ballClipRotate];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ballClipRotate removeFromSuperview];
        [hud showCustomView:animationSucces];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hide];
        });
    });
}
- (void)annularDeterminateExample {
    pro = 0.0f;
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showAnnularDeterminate:@"loading..."];
    [self performSelector:@selector(increaseProgressForHUD:) withObject:hud afterDelay:0.1f];
}
- (void)barDeterminateExample {
    pro = 0.0f;
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showBarDeterminate:@"loading..."];
    [self performSelector:@selector(increaseProgressForHUD:) withObject:hud afterDelay:0.1f];
}
- (void)determinateExample {
    pro = 0.0f;
    MBHUD *hud = [MBHUD showHUDToView:self.view];
    [hud showDeterminate:@"loading"];
    [self performSelector:@selector(increaseProgressForHUD:) withObject:hud afterDelay:0.1f];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBExample *example = self.examples[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MBExampleCell" forIndexPath:indexPath];
    cell.textLabel.text = example.title;
    cell.textLabel.textColor = self.view.tintColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [cell.textLabel.textColor colorWithAlphaComponent:0.1f];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MBExample *example = self.examples[indexPath.section][indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
}



- (void)increaseProgressForHUD:(MBHUD *)hud {

    pro += 0.05f;
    [hud setHUDDeterminateProgress:pro];

    if(pro < 1.0f){
        [self performSelector:@selector(increaseProgressForHUD:) withObject:hud afterDelay:0.1f];
    } else {
        [hud showSuccess:@"complete"];
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

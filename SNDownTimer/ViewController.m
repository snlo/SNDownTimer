//
//  ViewController.m
//  SNDownTimer
//
//  Created by sunDong on 2017/2/23.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "ViewController.h"

#import "SNDownTimer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __block SNDownTimer * timer =
    [SNDownTimer downTimerWithFrame:60 interval:1 formatter:@"SS" startBlock:^{
        //第0秒
        NSLog(@"start");
    } intervalBlock:^(NSTimeInterval afterSeconds, NSString *showTimeString) {
        
        if (afterSeconds == 11) {
            [timer invalidate];
            [SNSharedDownTimer invalidate];
        }
        NSLog(@"showTimeString - - %@",showTimeString);
    } completBlock:^{
        //最后一秒结束
        NSLog(@"end");
    }];
    
    
    [SNSharedDownTimer downTimerInterval:2 intervalBlock:^{
        NSLog(@"interval");
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

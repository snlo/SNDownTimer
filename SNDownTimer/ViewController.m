//
//  ViewController.m
//  SNDownTimer
//
//  Created by snlo on 2017/2/23.
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
//	pod trunk push SNDownTimer.podspec --verbose --allow-warnings --use-libraries
	
    __block SNDownTimer * timer =
    [SNDownTimer downTimerWithFrame:86282 interval:60 formatter:@"HH小时mm分钟" startBlock:^(NSString *showTimeString){
        //第0秒
        NSLog(@"start - %@",showTimeString);
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

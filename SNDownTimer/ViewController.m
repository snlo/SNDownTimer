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

@property (nonatomic, copy) NSString * name;

@property (nonatomic, strong) dispatch_source_t timers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//	pod trunk push SNDownTimer.podspec --verbose --allow-warnings --use-libraries
	
//    __block SNDownTimer * timer =
//    [SNDownTimer downTimerWithFrame:86282 interval:60 formatter:@"HH小时mm分钟" startBlock:^(NSString *showTimeString){
//        //第0秒
//        NSLog(@"start - %@",showTimeString);
//    } intervalBlock:^(NSTimeInterval afterSeconds, NSString *showTimeString) {
//
//        if (afterSeconds == 11) {
//            [timer invalidate];
//            [SNSharedDownTimer invalidate];
//        }
//        NSLog(@"showTimeString - - %@",showTimeString);
//    } completBlock:^{
//        //最后一秒结束
//        NSLog(@"end");
//    }];
//
//
//    [SNSharedDownTimer downTimerInterval:2 intervalBlock:^{
//        NSLog(@"interval");
//    }];
    
	
	NSMutableString * str = [NSMutableString stringWithFormat:@"test"];
	
	self.name = str;
	
	[str setString:@"hihi"];
	
	NSLog(@"%@",self.name);
	
	UITextField * textfield ;
	
	textfield.attributedText
	
	
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	dispatch_cancel(self.timers);
}

- (void)dealloc {
	NSLog(@"%s",__func__);
}

@end

//
//  SNDownTimer.m
//  Ljiamm
//
//  Created by sunDong on 16/12/9.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNDownTimer.h"

typedef void(^StartBlock)(void);
typedef void(^IntervalBlock)(NSTimeInterval afterSeconds, NSString *showTimeString);
typedef void(^CompletBlock)(void);
@class SNSharedDownTimer;
@interface SNDownTimer ()
{
    double _timeFrame;
    double _tempTime;
    double _interval;
}

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSDateFormatter * formatter;

@property (nonatomic, copy) StartBlock startBlock;
@property (nonatomic, copy) IntervalBlock intervalBlock;
@property (nonatomic, copy) CompletBlock completBlock;

@end

@implementation SNDownTimer

- (instancetype)initWithFrame:(NSTimeInterval)timeFrame
                     interval:(NSTimeInterval)interval
                    formatter:(NSString *)formatter
                   startBlock:(void(^)(void))startBlock
                intervalBlock:(void(^)(NSTimeInterval afterSeconds, NSString *showTimeString))intervalBlock
                 completBlock:(void(^)(void))completBlock
{
    self = [super init];
    if (self) {
        _timeFrame = timeFrame;
        _interval = interval;
        [self.formatter setDateFormat:formatter];
        [self timer];
        if (startBlock) startBlock();
        if (intervalBlock) self.intervalBlock = intervalBlock;
        if (completBlock) self.completBlock = completBlock;
    } return self;
}

+ (instancetype)downTimerWithFrame:(NSTimeInterval)timeFrame
                          interval:(NSTimeInterval)interval
                         formatter:(NSString *)formatter
                        startBlock:(void(^)(void))startBlock
                     intervalBlock:(void(^)(NSTimeInterval afterSeconds, NSString *showTimeString))intervalBlock
                      completBlock:(void(^)(void))completBlock
{
    return [[self alloc]initWithFrame:timeFrame
                             interval:interval
                            formatter:formatter
                           startBlock:startBlock
                        intervalBlock:intervalBlock
                         completBlock:completBlock];
}

- (void)actionTimer:(NSTimer *)timer
{
    _tempTime += _interval;
    
    NSString * showTimeString = [self.formatter stringFromDate:[[NSDate dateWithTimeIntervalSince1970:0] dateByAddingTimeInterval:(_timeFrame -_tempTime)]];
    
    if ([self.formatter.dateFormat isEqualToString:@"SS"]) {
        
        showTimeString = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:_timeFrame -_tempTime]];
    }
    
    if (_tempTime < _timeFrame) {
        
        if (self.intervalBlock) self.intervalBlock([[NSNumber numberWithDouble:_tempTime] integerValue], showTimeString);
    } else {
        
        if (self.intervalBlock) self.intervalBlock([[NSNumber numberWithDouble:_tempTime] integerValue], showTimeString);
        
        [self.timer invalidate];
        self.timer = nil;
        
        if (self.completBlock) self.completBlock();
    }
}
#pragma msek -- getter

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(actionTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    } return _timer;
}

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc]init];
    } return _formatter;
}

+ (void)downTimerIntervalBlock:(void(^)(void))intervalBlock
{
    [SNSharedDownTimer downTimerIntervalBlock:intervalBlock];
    
}

@end



//---------------我是分割线------------------




typedef void(^ShardIntervalBlock)(void);

@interface SNSharedDownTimer ()
{
    double _timeFrame;
    double _tempTime;
    double _interval;
}
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSDateFormatter * formatter;

@property (nonatomic, copy) ShardIntervalBlock intervalBlock;

@end



@implementation SNSharedDownTimer

static id _singletion;

+ (instancetype)sharedManeger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singletion = [[self alloc] init];
    });
    return _singletion;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singletion = [super allocWithZone:zone];
    });
    return _singletion;
}


+ (void)downTimerIntervalBlock:(void(^)(void))intervalBlock
{
    [[SNSharedDownTimer sharedManeger] timer];
    if (intervalBlock) [SNSharedDownTimer sharedManeger].intervalBlock = intervalBlock;
}


- (void)shardActionTimer:(NSTimer *)timer {
    if ([SNSharedDownTimer sharedManeger].intervalBlock) {
        [SNSharedDownTimer sharedManeger].intervalBlock();
    }
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shardActionTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    } return _timer;
}

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc]init];
    } return _formatter;
}

@end

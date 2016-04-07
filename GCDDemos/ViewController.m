//
//  ViewController.m
//  GCDDemos
//
//  Created by huangyibiao on 16/4/6.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self demo1];
}

// 队列
- (void)demo1 {
  
  //    [self demo1_global_queue];
//  [self demo1_serial_queue];
//  [self  demo1_concurrency_queue];
  //  [self demo1_main_queue];
  [self demo1_global_queue_prority];
}

- (void)demo1_concurrency_queue {
dispatch_queue_t serialQueue = dispatch_queue_create("com.huangyibiao.serial-queue",
                                                     DISPATCH_QUEUE_CONCURRENT);
dispatch_async(serialQueue, ^{
  NSLog(@"s1");
});
dispatch_async(serialQueue, ^{
  sleep(2);
  NSLog(@"s2");
});
dispatch_async(serialQueue, ^{
  sleep(1);
  NSLog(@"s3");
});
}

- (void)demo1_serial_queue {
// 串行队列
dispatch_queue_t concurrencyQueue = dispatch_queue_create("com.huangyibiao.concurrency-queue",
                                                          DISPATCH_QUEUE_SERIAL);
dispatch_async(concurrencyQueue, ^{
  NSLog(@"s1");
});
dispatch_async(concurrencyQueue, ^{
  sleep(2);
  NSLog(@"s2");
});
dispatch_async(concurrencyQueue, ^{
  sleep(1);
  NSLog(@"s3");
});
}

- (void)demo1_main_queue {
  dispatch_async(dispatch_get_main_queue(), ^{
    sleep(2);
    NSLog(@"main 1");
  });
  
  dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"main 2");
  });
  
  dispatch_async(dispatch_get_main_queue(), ^{
    sleep(1);
    NSLog(@"main 3");
  });
}

- (void)demo1_global_queue {
  /*
   #define DISPATCH_QUEUE_PRIORITY_HIGH 2
   #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
   #define DISPATCH_QUEUE_PRIORITY_LOW (-2)
   #define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
   */
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"1");
  });
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // 睡眠2秒
    sleep(2);
    NSLog(@"2");
  });
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // 睡眠3秒
    sleep(1);
    NSLog(@"3");
  });
}

- (void)demo1_global_queue_prority {
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
  NSLog(@"4");
});

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
  NSLog(@"3");
});

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
  NSLog(@"2");
});

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
  NSLog(@"1");
});
}

@end

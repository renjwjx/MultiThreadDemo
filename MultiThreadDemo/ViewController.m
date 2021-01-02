//
//  ViewController.m
//  MultiThreadDemo
//
//  Created by renjinwei on 2020/12/30.
//  Copyright © 2020 renjinwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSThread* thread;
// 没有atomic的效果对于NSinteger
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (atomic, assign)NSInteger myTotal;
@end

@implementation ViewController
static NSInteger total = 100;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view performSelectorOnMainThread:@selector(setBackgroundColor:) withObject:[UIColor redColor] waitUntilDone:NO];
    [self.view performSelector:@selector(setBackgroundColor:) withObject:[UIColor blueColor] afterDelay:1];
}


- (IBAction)reStartBtn:(id)sender {
//    [self asynConcurrent];
//    [self asynSerial];
//    [self synSerial];
//    [self synConcurrent];
    //卡死
//    [self synMainQueue];
    
    [self synGloblaQueue];
    
}
#pragma mark -- 同步，异步， 队列， 并发， 串行
- (void)synGloblaQueue
{
    NSLog(@"start %s", __func__);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_sync(queue, ^{
        NSLog(@"download1 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 100000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download1 end, %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 10; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download2 end, %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 1000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download3 end, %@", [NSThread currentThread]);
    });
    NSLog(@"end %s", __func__);
}

- (void)synMainQueue
{
    NSLog(@"start %s", __func__);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"download1 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 100000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download1 end, %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 10; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download2 end, %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 1000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download3 end, %@", [NSThread currentThread]);
    });
    NSLog(@"end %s", __func__);
}

- (void)synConcurrent
{
    NSLog(@"start %s", __func__);
    dispatch_queue_t queue = dispatch_queue_create("Serial", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"download1 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 100000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download1 end, %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 10; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download2 end, %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 1000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download3 end, %@", [NSThread currentThread]);
    });
    NSLog(@"end %s", __func__);
}

- (void)synSerial
{
    NSLog(@"start %s", __func__);
    dispatch_queue_t queue = dispatch_queue_create("Serial", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"download1 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 100000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download1 end, %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 10; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download2 end, %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 1000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download3 end, %@", [NSThread currentThread]);
    });
    NSLog(@"end %s", __func__);
}


- (void)asynSerial
{
    NSLog(@"start %s", __func__);
    dispatch_queue_t queue = dispatch_queue_create("Serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"download1 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 100000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download1 end, %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 10; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download2 end, %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 1000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download3 end, %@", [NSThread currentThread]);
    });
    NSLog(@"end %s", __func__);
}


- (void)asynConcurrent
{
    NSLog(@"start %s", __func__);
    dispatch_queue_t queue = dispatch_queue_create("Serial", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"download1 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 100000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download1 end, %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 10; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download2 end, %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3 start, %@", [NSThread currentThread]);

        for (int i = 0; i < 1000; i++) {
            int a = 10, b = 20;
            int c = a + b;
        }
        NSLog(@"download3 end, %@", [NSThread currentThread]);
    });
    NSLog(@"end %s", __func__);
}


#pragma mark -- 手动创建子线程
- (void)create_thread_by_nsthread
{
    total = 100;
    _myTotal = 100;
    NSThread* thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(task) object:nil];
    NSThread* thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(task) object:nil];
    NSThread* thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(task) object:nil];
    [thread1 start];
    [thread2 start];
    [thread3 start];
}

- (void)task
{
    for (NSInteger i =0; i < 1000; i++) {
        @synchronized (self) {
            if (self.myTotal <= 0) {
                NSLog(@"exit, %ld", self.myTotal);
                break;
                //注意这个地方不能用exit， 会导致synchronized self, 不能正常退出失败
                //Thread 10: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
                //                 [NSThread exit];
            }
            //在其他地方调用 cancel， 可以在这里获取到状态然后自己退出   [self.thread cancel];

            if ([[NSThread currentThread] isCancelled]) {
                break;
            }
            [NSThread sleepForTimeInterval:0.01];
            self.myTotal = self.myTotal - 1;
            NSLog(@"%ld, %@", self.myTotal, [NSThread currentThread]);
            
        }
    }
}


#pragma mark -- 自动create thread， 进程间通信 withObject
- (void)automatic_creat_thread
{
    [NSThread detachNewThreadSelector:@selector(downloadImage) toTarget:self withObject:nil];
}
- (void)downloadImage
{
    NSLog(@"thread: %@", [NSThread currentThread]);
    NSDate* start = [NSDate date];
    CFTimeInterval startCF = CFAbsoluteTimeGetCurrent();
    NSString* imageStr = @"https://youimg1.c-ctrip.com/target/fd/tg/g2/M05/63/4D/CghzgFTz8_WAHjQTABB6rt-2dKw788.jpg";
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
    UIImage* image = [UIImage imageWithData:imageData];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        <#code to be executed once#>
    });
    //update on main thread
//    [self performSelectorOnMainThread:@selector(updateImage:) withObject:image waitUntilDone:NO];
    
    // update on main thread
//    [self performSelector:@selector(updateImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    
    // 直接在imageView里面执行
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    
    NSDate* end = [NSDate date];
    NSLog(@"total:%f", [end timeIntervalSinceDate:start]);
    NSLog(@"total CF, %f", CFAbsoluteTimeGetCurrent() - startCF);

}

- (void)updateImage:(UIImage*)img
{
    
    NSLog(@"updateImage thread: %@", [NSThread currentThread]);
    self.imageView.image = img;

}


@end

//
//  ViewController.m
//  OperationPractice
//
//  Created by Bing Guo on 2021/4/21.
//

#import "ViewController.h"
#import "HTTPBinManager.h"
#import "HTTPBinManagerDelegate.h"

@interface ViewController () <HTTPBinManagerDelegate>
{
    HTTPBinManager *manager;
    BOOL isRunning;
}
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation ViewController

@synthesize progressView;
@synthesize startButton;

- (void)viewDidLoad {
    [super viewDidLoad];

    isRunning = NO;

    [self setupUI];
    [self setupManager];
}

// MARK: - Setup UI
- (void)setupUI {
    [startButton addTarget: self
                     action: @selector(handleStartButtonClick:)
           forControlEvents: UIControlEventTouchUpInside];
    [startButton setTitle:@"START" forState:UIControlStateNormal];

    [progressView setProgress:0.0f];
}

- (void)setupManager {
    manager = [HTTPBinManager sharedInstance];
    manager.delegate = self;
}

- (void)handleStartButtonClick:(id)sender {
    if(isRunning) {
        [self cancelOperation];
    } else {
        [self executeOperation];
    }

    isRunning = !isRunning;
}

// MARK: - Activate
- (void)executeOperation {
    [progressView setProgress:0.0f];
    [startButton setTitle:@"CANCEL" forState:UIControlStateNormal];

    [manager executeOperation];
}

- (void)cancelOperation {
    [progressView setProgress:0.0f];
    [startButton setTitle:@"START" forState:UIControlStateNormal];

    [manager cancelAllOperations];
}

- (void)completedOperation {
    [startButton setTitle:@"RESTART" forState:UIControlStateNormal];
}

// MARK: - HTTPBinManagerDelegate
- (void)HTTPBinManager:(HTTPBinManager *)HTTPBinManager
              progress:(float)progress
                 error:(NSError *)error
{
    [progressView setProgress:progress];

    if(progress == 1.0f) {
        [self completedOperation];
    }
}

- (void)HTTPBinManager:(HTTPBinManager *)HTTPBinManager didCancelOperationQueue:(NSOperationQueue *)queue {
}

@end

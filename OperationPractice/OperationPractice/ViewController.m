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

- (void)viewDidLoad {
    [super viewDidLoad];

    isRunning = NO;

    [self setupView];
    [self setupManager];
}

// MARK: - Setup

-(void)setupView {
    [_startButton addTarget:self action:@selector(handleStartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_startButton setTitle:@"START" forState:UIControlStateNormal];

    [_progressView setProgress:0.0f];
}

-(void)setupManager {
    manager = [HTTPBinManager sharedInstance];
    manager.delegate = self;
}

-(void)handleStartButtonClick:(id)sender {
    if(isRunning) {
        [self cancelOperation];
    } else {
        [self executeOperation];
    }

    isRunning = !isRunning;
}

// MARK: - Update Operation State

-(void)executeOperation {
    [_progressView setProgress:0.0f];
    [_startButton setTitle:@"CANCEL" forState:UIControlStateNormal];

    [manager executeOperation];
}

-(void)cancelOperation {
    [_progressView setProgress:0.0f];
    [_startButton setTitle:@"START" forState:UIControlStateNormal];

    [manager cancelAllOperations];
}

-(void)completedOperation {
    [_startButton setTitle:@"RESTART" forState:UIControlStateNormal];
}

// MARK: - HTTPBinManagerDelegate

- (void)HTTPBinManager:(HTTPBinManager *)HTTPBinManager progress:(float)progress error:(NSError *)error {
    [_progressView setProgress:progress];

    if(progress == 1.0f) {
        [self completedOperation];
    }

    NSLog(@"🐯 progress: %f", progress);
    NSLog(@"🐯 error: %@", error);
}

- (void)HTTPBinManager:(HTTPBinManager *)HTTPBinManager didCancelOperationQueue:(NSOperationQueue *)queue {
    NSLog(@"🐯 Queue is cancelled");
}

@end

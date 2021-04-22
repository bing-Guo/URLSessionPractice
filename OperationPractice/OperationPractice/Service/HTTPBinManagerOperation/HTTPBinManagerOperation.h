//
//  HTTPBinManagerOperation.h
//  OperationPractice
//
//  Created by Bing Guo on 2021/4/21.
//

#import "HTTPBinManagerOperationDelegate.h"

#ifndef HTTPBinManagerOperation_h
#define HTTPBinManagerOperation_h

@interface HTTPBinManagerOperation : NSOperation

@property (weak, nonatomic) id <HTTPBinManagerOperationDelegate> delegate;
@property (strong, nonatomic) dispatch_semaphore_t semaphore;

@end

#endif /* HTTPBinManagerOperation_h */

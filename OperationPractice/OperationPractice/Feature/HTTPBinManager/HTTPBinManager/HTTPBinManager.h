//
//  HTTPBinManager.h
//  OperationPractice
//
//  Created by Bing Guo on 2021/4/21.
//

#import "HTTPBinManagerOperationDelegate.h"
#import "HTTPBinManagerDelegate.h"

#ifndef HTTPBinManager_h
#define HTTPBinManager_h

@interface HTTPBinManager : NSObject <HTTPBinManagerOperationDelegate>
{
    HTTPBinManagerOperation *operation;
}
@property (weak, nonatomic) id <HTTPBinManagerDelegate> delegate;
@property NSOperationQueue *queue;

+ (instancetype)sharedInstance;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

- (void)executeOperation;
- (void)cancelAllOperations;

@end

#endif /* HTTPBinManager_h */

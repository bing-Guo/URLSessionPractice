//
//  HTTPBinManagerDelegate.h
//  OperationPractice
//
//  Created by Bing Guo on 2021/4/21.
//

#ifndef HTTPBinManagerDelegate_h
#define HTTPBinManagerDelegate_h

@class HTTPBinManager;

@protocol HTTPBinManagerDelegate <NSObject>

- (void)HTTPBinManager:(HTTPBinManager *)HTTPBinManager
              progress:(float)progress
                 error:(NSError *)error;

- (void)HTTPBinManager:(HTTPBinManager *)HTTPBinManager didCancelOperationQueue:(NSOperationQueue *)queue;

@end

#endif /* HTTPBinManagerDelegate_h */

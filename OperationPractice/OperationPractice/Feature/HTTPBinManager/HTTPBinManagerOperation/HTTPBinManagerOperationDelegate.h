//
//  HTTPBinManagerOperationDelegate.h
//  OperationPractice
//
//  Created by Bing Guo on 2021/4/21.
//

#ifndef HTTPBinManagerOperationDelegate_h
#define HTTPBinManagerOperationDelegate_h

@class HTTPBinManagerOperation;

@protocol HTTPBinManagerOperationDelegate <NSObject>

- (void)HTTPBinManagerOperation:(HTTPBinManagerOperation *)HTTPBinManagerOperation progress:(float)progress error:(NSError *)error;

@end

#endif /* HTTPBinManagerOperationDelegate_h */

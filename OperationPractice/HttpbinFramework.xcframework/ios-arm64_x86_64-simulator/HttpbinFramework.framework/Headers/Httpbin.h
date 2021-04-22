//
//  Httpbin.h
//  HttpbinFramework
//
//  Created by Bing Guo on 2021/3/31.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Httpbin : NSObject

- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback;
- (void)postCustomerName:(NSString *)name callback:(void(^)(NSDictionary *, NSError *))callback;
- (void)fetchImageWithCallback:(void(^)(UIImage *, NSError *))callback;

@end

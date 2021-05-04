//
//  HTTPBinAPI.h
//  HttpbinFramework
//
//  Created by Bing Kuo on 2021/5/4.
//

#ifndef HTTPBinAPI_h
#define HTTPBinAPI_h

@interface HTTPBinAPI: NSObject

@property NSURLSession *mainSession;

+ (HTTPBinAPI *)shared;
- (NSDictionary *)defaultHeader;
- (float)defaultTimeout;

@end

#endif /* HTTPBinAPI_h */

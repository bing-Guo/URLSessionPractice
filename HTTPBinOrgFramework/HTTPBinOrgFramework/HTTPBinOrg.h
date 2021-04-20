#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HTTPBinOrg;

@protocol HTTPBinOrgDelegate <NSObject>

- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin dictionaryForGet:(NSDictionary *)dictionary error:(NSError *) error;
- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin dictionaryForPostName:(NSDictionary *)dictionary error:(NSError *) error;
- (void)HTTPBinOrg:(HTTPBinOrg *)httpbin image:(UIImage *)image error:(NSError *) error;

@end

@interface HTTPBinOrg : NSObject
@property (weak, nonatomic) id <HTTPBinOrgDelegate> delegate;

- (void)fetchGetResponse;
- (void)postCustomerName:(NSString *)name;
- (void)fetchImageWithCallback;

@end

#import <Foundation/Foundation.h>

@class RecaptchaClient;
@class RecaptchaError;

NS_ASSUME_NONNULL_BEGIN

/** Interface to interact with reCAPTCHA. */
API_AVAILABLE(ios(11.0))
@interface Recaptcha : NSObject

/**
 * Builds a new reCAPTCHA Client for the given SiteKey.
 * @param siteKey reCAPTCHA Site Key for the app.
 * @param completionHandler Callback function to return the RecaptchaClient or an error.
 */
+ (void)getClientWithSiteKey:(NSString *)siteKey
           completionHandler:(void (^)(RecaptchaClient *_Nullable recaptchaClient,
                                       RecaptchaError *_Nullable error))completionHandler
    NS_SWIFT_NAME(getClient(siteKey:completionHandler:));

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

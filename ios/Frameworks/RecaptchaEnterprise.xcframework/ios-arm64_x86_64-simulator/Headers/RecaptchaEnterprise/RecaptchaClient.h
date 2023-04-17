#import <Foundation/Foundation.h>

@class RecaptchaAction;
@class RecaptchaError;
@class RecaptchaToken;
@class RecaptchaVerificationHandler;

NS_ASSUME_NONNULL_BEGIN

/** Interface to interact with reCAPTCHA. */
@interface RecaptchaClient : NSObject

- (instancetype)init NS_UNAVAILABLE;
/**
 * Executes reCAPTCHA on a user action.
 * @param action The user action to protect.
 * @param completionHandler Callback function to return the execute result.
 */
- (void)execute:(RecaptchaAction *)action
    completionHandler:(void (^)(RecaptchaToken *_Nullable recaptchaToken,
                                RecaptchaError *_Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END

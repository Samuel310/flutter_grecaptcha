#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RecaptchaError;
@class RecaptchaToken;

/**
 * Class that handles the verification phase of reCAPTCHA 2FA. An instance of this class will
 * be returned by @c RecaptchaClient#ChallengeAccount, when your user inputs the 2FA pin you
 * can call @c verifyPin to finish the 2FA workflow.
 */
@interface RecaptchaVerificationHandler : NSObject

/**
 * Verifies that the user's input pin is valid.
 * @param pin The pin that the user typed in.
 * @param completionHandler Callback function to return the recaptcha token or an error.
 */
- (void)verifyPin:(NSString *)pin
    completionHandler:(void (^)(RecaptchaToken *_Nullable recaptchaToken,
                                NSError *_Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END

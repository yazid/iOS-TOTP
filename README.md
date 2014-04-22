# iOS TOTP Sample

[TOTP](http://tools.ietf.org/html/draft-mraihi-totp-timebased) (Time-based 
One-time Password) is a great and simple approach for two-factor authentication. 
Google Authenticator uses it. But, the project for the original Google Authenticator
iOS client is super bloated, and most likely won't compile on first run (at least
it didn't for me). So, here's a barebones single-view iOS app which makes use of
only 4 of the files from Google. And it works! (you should find that it generates
the same codes as the Google Authenticator app)

## Usage

1. Add the required files to your project:
  1. OTPGenerator.m/.h*
  2. HOTPGenerator.m/.h*
  3. MF_Base32Additions.m/.h

    Note: i and ii are not ARC-compliant so be sure to add the `-fno-objc-arc` Compiler Flag under your target's Build Phases > Compile Sources

2. Imports:

    ```
    #import "TOTPGenerator.h"
    #import "MF_Base32Additions.h"
    ```

3. Setup i) secret string, ii) date, and iii) `TOTPGenerator` object:

    ```
    NSString *secret = @"abcdefghijklmnop";
    NSData *secretData = [NSData dataWithBase32String:secret];
    NSDate *now = [NSDate date];
    TOTPGenerator *generator = [[TOTPGenerator alloc] initWithSecret:secretData 
    algorithm:kOTPGeneratorSHA1Algorithm digits:6 period:30];
    ```
    Note: 
    * `digits` can be 6-8
    * `period` is the PIN expiry period in seconds
    * `algorithm` can be either `kOTPGeneratorSHA1Algorithm` (default), `kOTPGeneratorSHA256Algorithm`, `kOTPGeneratorSHA512Algorithm`, or `kOTPGeneratorSHAMD5Algorithm`.

4. Generate PIN:

    ```
    NSString *pin = [generator generateOTPForDate:now];
    ```

Safe travels.

## Credits

* [Google Authenticator Project](https://code.google.com/p/google-authenticator/)
* [ekscrypto/Base32](https://github.com/ekscrypto/Base32)



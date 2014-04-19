# iOS TOTP Sample

[TOTP](http://tools.ietf.org/html/draft-mraihi-totp-timebased) (Time-based 
One-time Password) is a great and simple approach for two-factor authentication. 
Google Authenticator uses it. But, the code for the original Google Authenticator 
iOS client is super bloated, and most likely won't compile on first run (at least
it didn't for me). So, here's a barebones single-view iOS app which makes use of
only 4 of the files from Google. And it works.

## Usage

1. Imports:
```
#import "TOTPGenerator.h"
```

2. Setup i) secret string, ii) date, and iii) `TOTPGenerator` object:
```
NSString *secret = @"123456789";
NSDate *now = [NSDate date];
TOTPGenerator *generator = [[TOTPGenerator alloc] initWithSecret:
[secret dataUsingEncoding:NSASCIIStringEncoding] algorithm:kOTPGeneratorSHA1Algorithm 
digits:6 period:30];
```
Note: `digits` can 6-8, and `period` is the PIN expiry period in seconds. 

3. Generate PIN:
```
NSString *pin = [generator generateOTPForDate:now];
```

Safe travels.

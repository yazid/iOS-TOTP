//
//  YAViewController.m
//  TOTP Sample
//
//  Created by Yazid Azahari on 19/4/14.
//  Copyright (c) 2014 Yazid Azahari. All rights reserved.
//

#import "YAViewController.h"
#import "TOTPGenerator.h"
#import "MF_Base32Additions.h"

@interface YAViewController ()

@end

@implementation YAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.secretTextField.delegate = self;
    self.expiryTextField.delegate = self;
    self.digitsTextField.delegate = self;
    
    self.secretTextField.text = @"abcdefghijklmnop";
    self.expiryTextField.text = @"30";
    self.digitsTextField.text = @"6";
    
    [self updateUI];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
}

- (void)updateUI
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:timeZone];
    NSString *dateString = [dateFormatter stringFromDate:now];
    
    long timestamp = (long)[now timeIntervalSince1970];
    if(timestamp % [self.expiryTextField.text integerValue] != 0){
        timestamp -= timestamp % [self.expiryTextField.text integerValue];
    }

    self.dateLabel.text = dateString;
    self.timestampLabel.text = [NSString stringWithFormat:@"%ld",timestamp];
    
    [self generatePIN];
}

-(void)generatePIN
{
    NSString *secret = self.secretTextField.text;
    NSData *secretData =  [NSData dataWithBase32String:secret];
    
    NSInteger digits = [self.digitsTextField.text integerValue];
    NSInteger period = [self.expiryTextField.text integerValue];
    NSTimeInterval timestamp = [self.timestampLabel.text integerValue];
    
    TOTPGenerator *generator = [[TOTPGenerator alloc] initWithSecret:secretData algorithm:kOTPGeneratorSHA1Algorithm digits:digits period:period];
    
    NSString *pin = [generator generateOTPForDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    
    self.PINLabel.text = pin;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

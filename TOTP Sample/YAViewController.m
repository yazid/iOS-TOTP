//
//  YAViewController.m
//  TOTP Sample
//
//  Created by Yazid Azahari on 19/4/14.
//  Copyright (c) 2014 Yazid Azahari. All rights reserved.
//

#import "YAViewController.h"
#import "TOTPGenerator.h"

@interface YAViewController ()

@end

@implementation YAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.secretTextField.delegate = self;
    self.expiryTextField.delegate = self;
    self.digitsTextField.delegate = self;
    
    self.secretTextField.text = @"123456789";
    self.expiryTextField.text = @"10";
    self.digitsTextField.text = @"6";
    
    [self updateUI];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
}

- (void)updateUI
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
    
    self.dateLabel.text = [dateFormatter stringFromDate:now];
    self.timestampLabel.text = [NSString stringWithFormat:@"%ld",(long)[now timeIntervalSince1970]];
    
    [self generatePIN];
}

-(void)generatePIN
{
    NSString *secret = self.secretTextField.text;
    
    TOTPGenerator *generator = [[TOTPGenerator alloc] initWithSecret:[secret dataUsingEncoding:NSASCIIStringEncoding] algorithm:kOTPGeneratorSHA1Algorithm digits:[self.digitsTextField.text integerValue] period:[self.expiryTextField.text integerValue]];
    
    NSString *pin = [generator generateOTPForDate:[NSDate dateWithTimeIntervalSince1970:[self.timestampLabel.text integerValue]]];
    
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

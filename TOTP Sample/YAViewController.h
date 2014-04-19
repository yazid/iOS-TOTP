//
//  YAViewController.h
//  TOTP Sample
//
//  Created by Yazid Azahari on 19/4/14.
//  Copyright (c) 2014 Yazid Azahari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YAViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;
@property (weak, nonatomic) IBOutlet UILabel *PINLabel;
@property (weak, nonatomic) IBOutlet UITextField *expiryTextField;
@property (weak, nonatomic) IBOutlet UITextField *digitsTextField;


@end

//
//  ViewController.h
//  TPTCurrencyTextField
//
//  Created by James Rutherford on 2013-01-25.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPTCurrencyTextField.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) TPTCurrencyTextField *textInputField;

- (IBAction)setWithNumber:(UIButton *)sender;
- (IBAction)logNumericValue:(UIButton *)sender;
- (IBAction)logCurrencyText:(UIButton *)sender;

@end

//
//  TPTCurrencyTextField.h
//  TPTCurrencyTextField
//
//  Created by James Rutherford on 2013-01-26.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTCurrencyTextField : UITextField <UITextFieldDelegate>


@property (nonatomic, strong) NSNumber *numericValue;

-(BOOL)currencyTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

-(void)currencyTextFieldDidBeginEditing:(UITextField *)textField;

@end

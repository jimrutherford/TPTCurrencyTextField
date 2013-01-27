//
//  TPTCurrencyTextFieldPrivateDelegate.m
//  TPTCurrencyTextField
//
//  Created by James Rutherford on 2013-01-26.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//
//  Solution comes from http://goo.gl/XHSzr
//

#import "TPTCurrencyTextFieldPrivateDelegate.h"
#import "TPTCurrencyTextField.h"

@implementation TPTCurrencyTextFieldPrivateDelegate


- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	[(TPTCurrencyTextField *)textField currencyTextField:textField shouldChangeCharactersInRange:range replacementString:string];
	if ([_userDelegate respondsToSelector:_cmd]) {
        [_userDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
	return NO;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
	[(TPTCurrencyTextField *)textField currencyTextFieldDidBeginEditing:textField];
	if ([_userDelegate respondsToSelector:_cmd]) {
        [_userDelegate textFieldDidBeginEditing:textField];
    }

}


- (BOOL)respondsToSelector:(SEL)selector {
    return [_userDelegate respondsToSelector:selector] || [super respondsToSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    // This should only ever be called from `UITextField`, after it has verified
    // that `_userDelegate` responds to the selector by sending me
    // `respondsToSelector:`.  So I don't need to check again here.
    [invocation invokeWithTarget:_userDelegate];
}


@end
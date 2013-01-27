//
//  TPTCurrencyTextFieldPrivateDelegate.h
//  TPTCurrencyTextField
//
//  Created by James Rutherford on 2013-01-26.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPTCurrencyTextFieldPrivateDelegate : NSObject <UITextFieldDelegate> {

@public
	id<UITextFieldDelegate> _userDelegate;
}

@end

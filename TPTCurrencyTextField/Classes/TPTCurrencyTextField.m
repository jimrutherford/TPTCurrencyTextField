//
//  TPTCurrencyTextField.m
//  TPTCurrencyTextField
//
//  Created by James Rutherford on 2013-01-26.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import "TPTCurrencyTextField.h"
#import "TPTCurrencyTextFieldPrivateDelegate.h"

@implementation TPTCurrencyTextField {
    TPTCurrencyTextFieldPrivateDelegate *_myDelegate;
}

@synthesize numericValue;

NSNumberFormatter* currencyFormatter;
NSNumberFormatter* basicFormatter;

NSCharacterSet *nonNumberSet;
NSString *localCurrencySymbol;
NSString *localDecimalSeparator;
NSString *localGroupingSeparator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
		[self initDelegate];
    }
    return self;
}

-(void) setup
{
	self.keyboardType = UIKeyboardTypeDecimalPad;
	
	NSLocale* locale = [NSLocale currentLocale];
	localCurrencySymbol = [locale objectForKey:NSLocaleCurrencySymbol];
	localGroupingSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
	localDecimalSeparator = [locale objectForKey:NSLocaleDecimalSeparator];
	
	currencyFormatter  = [[NSNumberFormatter alloc] init];
	[currencyFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[currencyFormatter setLocale:[NSLocale currentLocale]];
	
	basicFormatter = [[NSNumberFormatter alloc] init];
    [basicFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	
	//set up the reject character set
	NSMutableCharacterSet *numberSet = [[NSCharacterSet decimalDigitCharacterSet] mutableCopy];
	[numberSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
	nonNumberSet = [numberSet invertedSet];
}

-(void)currencyTextFieldDidBeginEditing:(UITextField *)textField
{
	[textField setText:[currencyFormatter stringFromNumber:[NSNumber numberWithInt:0]]];
}

-(BOOL)currencyTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	BOOL result = NO; //default to reject
	
	if([string length] == 0)
	{
		//backspace
		result = YES;
	}
	else
	{
		if([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0){
			result = YES;
		}
	}
	
	//here we deal with the UITextField on our own
	if(result){
		//grab a mutable copy of what's currently in the UITextField
		NSMutableString* inputCopy = [[textField text] mutableCopy];
		
        //adding a char or deleting?
        if([string length] > 0){
            [inputCopy insertString:string atIndex:range.location];
        }
        else {
            //delete case - the length of replacement string is zero for a delete
            [inputCopy deleteCharactersInRange:range];
        }
		
        //sanitize the input to remove any non-numeric symbols so the formatter will work
		NSString *sanitizedInput = [self sanitizedStringFromTextField:inputCopy];
		
        double currencyValue = [[basicFormatter numberFromString:sanitizedInput] doubleValue] / 100.0;
		NSNumber* number = [NSNumber numberWithDouble:currencyValue];
		
		//now format the number back to the proper currency string
		//and get the grouping separators added in and put it in the UITextField
		[textField setText:[currencyFormatter stringFromNumber:number]];
	}
	
	//always return no since we are manually changing the text field
	return NO;
}


- (NSString*) sanitizedStringFromTextField:(NSString*)input
{
	NSString *sanitizedString;
	sanitizedString = [input stringByReplacingOccurrencesOfString:localGroupingSeparator
														  withString:@""];
	sanitizedString = [sanitizedString stringByReplacingOccurrencesOfString:localCurrencySymbol
															   withString:@""];
	sanitizedString = [sanitizedString stringByReplacingOccurrencesOfString:localDecimalSeparator
															   withString:@""];
	return sanitizedString;
}

#pragma mark - Control Initialization

- (void)initDelegate {
    _myDelegate = [[TPTCurrencyTextFieldPrivateDelegate alloc] init];
    [super setDelegate:_myDelegate];
}



#pragma mark - Getters/Setters

- (void)setNumericValue:(NSNumber *)aNumericValue
{
	[self setText:[currencyFormatter stringFromNumber:aNumericValue]];
}

- (NSNumber*	) numericValue
{
	NSString *sanitizedInput = [self sanitizedStringFromTextField:self.text];
	
	double currencyValue = [[basicFormatter numberFromString:sanitizedInput] doubleValue] / 100.0;
	return [NSNumber numberWithDouble:currencyValue];

}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    _myDelegate->_userDelegate = delegate;
    // Scroll view delegate caches whether the delegate responds to some of the delegate
    // methods, so we need to force it to re-evaluate if the delegate responds to them
    super.delegate = nil;
    super.delegate = (id)_myDelegate;
}

- (id<UITextFieldDelegate>)delegate {
    return _myDelegate->_userDelegate;
}



@end

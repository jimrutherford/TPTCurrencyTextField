//
//  ViewController.m
//  TPTCurrencyTextField
//
//  Created by James Rutherford on 2013-01-25.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import "ViewController.h"
#import "Formatters.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize textInputField;

NSNumberFormatter* currencyFormatter;
NSNumberFormatter* basicFormatter;

NSCharacterSet *nonNumberSet;
NSString *localCurrencySymbol;
NSString *localGroupingSeparator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	textInputField.delegate = self;
	
	NSLocale* locale = [NSLocale currentLocale];
	localCurrencySymbol = [locale objectForKey:NSLocaleCurrencySymbol];
	localGroupingSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
	
	currencyFormatter = [Formatters currencyFormatterWithTwoDecimals];
	basicFormatter = [Formatters basicFormatter];
	
	//set up the reject character set
	NSMutableCharacterSet *numberSet = [[NSCharacterSet decimalDigitCharacterSet] mutableCopy];
	[numberSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
	nonNumberSet = [numberSet invertedSet];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	[textField setText:[currencyFormatter stringFromNumber:[NSNumber numberWithInt:0]]];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	BOOL result = NO; //default to reject

	
	NSLog(@"range.location - %i   replacementString - %@", range.location, string);
	
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
		NSMutableString* mstring = [[textField text] mutableCopy];
		
        //adding a char or deleting?
        if([string length] > 0){
            [mstring insertString:string atIndex:range.location];
        }
        else {
            //delete case - the length of replacement string is zero for a delete
            [mstring deleteCharactersInRange:range];
        }
		
        //remove any possible symbols so the formatter will work
        NSString* clean_string = [[[mstring stringByReplacingOccurrencesOfString:localGroupingSeparator
                                                                     withString:@""]
								  stringByReplacingOccurrencesOfString:localCurrencySymbol
								  withString:@""] stringByReplacingOccurrencesOfString:@"."
	withString:@""];
		
        //clean up mstring since it's no longer needed
		
        NSNumber* number = [basicFormatter numberFromString: clean_string];
		
		//now format the number back to the proper currency string
		//and get the grouping separators added in and put it in the UITextField
		[textField setText:[currencyFormatter stringFromNumber:number]];
	}
	
	//always return no since we are manually changing the text field
	return NO;
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  TPTCurrencyTextField
//
//  Created by James Rutherford on 2013-01-25.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import "ViewController.h"
#import "TPTCurrencyTextField.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize textInputField;



- (void)viewDidLoad
{
    [super viewDidLoad];
	
	textInputField = [[TPTCurrencyTextField alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
	textInputField.borderStyle = UITextBorderStyleRoundedRect;
	textInputField.font = [UIFont fontWithName:@"Helvetica" size:25.0f];
	textInputField.delegate = self;
	[self.view addSubview:textInputField];
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setWithNumber:(UIButton *)sender {
	[textInputField setNumericValue:[NSNumber numberWithDouble:20.99]];
}

- (IBAction)logNumericValue:(UIButton *)sender {
	NSLog(@"Numeric Value - %f", [textInputField.numericValue doubleValue]);
}
@end

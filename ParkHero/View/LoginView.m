//
//  LoginView.m
//  ParkHero
//
//  Created by Dylan Marriott on 07/03/15.
//  Copyright (c) 2015 Dylan Marriott. All rights reserved.
//

#import "LoginView.h"
#import "CustomTextField.h"

@interface LoginView () <UITextFieldDelegate>
@end

@implementation LoginView {
    UITextField *_nameField;
    UITextField *_emailField;
    UITextField *_passwordField;
    UIButton *_registerButton;
    UILabel *_switchLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 120, 40, 240, 154)];
        logoView.image = [UIImage imageNamed:@"LoginLogo"];
        [self addSubview:logoView];
        
        _nameField = [self createTextField];
        _nameField.placeholder = @"Name";
        _nameField.returnKeyType = UIReturnKeyNext;
        _emailField = [self createTextField];
        _emailField.returnKeyType = UIReturnKeyNext;
        _emailField.placeholder = @"Email";
        _passwordField = [self createTextField];
        _passwordField.returnKeyType = UIReturnKeyDone;
        _passwordField.secureTextEntry = YES;
        _passwordField.placeholder = @"Password";
        
        _registerButton = [[UIButton alloc] init];
        _registerButton.layer.cornerRadius = 6;
        _registerButton.backgroundColor = [UIColor colorWithRed:0.25 green:0.44 blue:0.54 alpha:1.00];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(actionRegister:) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.alpha = 0.5;
        _registerButton.enabled = NO;
        [self addSubview:_registerButton];
        
        _switchLabel = [[UILabel alloc] init];
        _switchLabel.text = @"Already signed up?";
        _switchLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _switchLabel.font = [UIFont systemFontOfSize:14];
        [_switchLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchMode:)]];
        _switchLabel.textAlignment = NSTextAlignmentCenter;
        _switchLabel.userInteractionEnabled = YES;
        [self addSubview:_switchLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat y = 210;
    if (self.mode == kLoginViewModeRegister) {
        _nameField.frame = CGRectMake(50, y, self.frame.size.width - 100, 35);
        y += 42;
    }
    _emailField.frame = CGRectMake(50, y, self.frame.size.width - 100, 35);
    y += 42;
    _passwordField.frame = CGRectMake(50, y, self.frame.size.width - 100, 35);
    y += 42;
    
    y = self.frame.size.height - 90;
    _registerButton.frame = CGRectMake(50, y, self.frame.size.width - 100, 35);
    
    y += 42;
    _switchLabel.frame = CGRectMake(50, y, self.frame.size.width - 100, 35);
}

- (UITextField *)createTextField {
    CustomTextField *field = [[CustomTextField alloc] init];
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    field.layer.cornerRadius = 6;
    field.layer.borderWidth = 0.5;
    field.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    field.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    field.delegate = self;
    [self addSubview:field];
    return field;
}

- (void)switchMode:(id)sender {
    [UIView animateWithDuration:0.4 animations:^{
        if (self.mode == kLoginViewModeLogin) {
            self.mode = kLoginViewModeRegister;
            _nameField.alpha = 1.0;
            _switchLabel.text = @"Already signed up?";
            [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
        } else {
            self.mode = kLoginViewModeLogin;
            _nameField.alpha = 0.0;
            _switchLabel.text = @"Not yet registered?";
            [_registerButton setTitle:@"Login" forState:UIControlStateNormal];
        }
        [self layoutSubviews];
    }];
}

- (void)actionRegister:(id)sender {
    if (self.mode == kLoginViewModeLogin) {
        [self.delegate performedLoginWithEmail:_emailField.text password:_passwordField.text];
    } else {
        [self.delegate performedRegistrationWithName:_nameField.text email:_emailField.text password:_passwordField.text];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    if (self.mode == kLoginViewModeRegister) {
        _registerButton.enabled = _nameField.text.length > 0 && _emailField.text.length > 3 && _passwordField.text.length > 5;
    } else {
        _registerButton.enabled = _emailField.text.length > 3 && _passwordField.text.length > 5;
    }
    _registerButton.alpha = _registerButton.enabled ? 1.0 : 0.5;
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _nameField) {
        [_emailField becomeFirstResponder];
    } else if (textField == _emailField) {
        [_passwordField becomeFirstResponder];
    } else if (textField == _passwordField) {
        [_passwordField resignFirstResponder];
    }
    return NO;
}

@end

//
//  ContainerViewController.m
//  DigitalDay
//
//  Created by Rodrigo Gomes Dias on 01/09/16.
//  Copyright © 2016 Rodrigo Gomes Dias. All rights reserved.
//

#import "ContainerViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Material/Material.h>

@interface ContainerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *nomeField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *nomeLabel;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)inscrever:(id)sender {
    [self.delegate changePageTo:2];
}

- (IBAction)enviar:(id)sender {
    if ([self isValidForm]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD show];
        [self.view endEditing:@YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.delegate changePageTo:3];
        });
    }
}

- (BOOL)isValidForm {
    BOOL isValid = true;
    if ([self.nomeField.text isEqualToString:@""]) {
        self.nomeLabel.text = @"Informe seu nome completo";
        isValid = false;
    } else {
        self.nomeLabel.text = @"";
    }
    if (![self isValidEmail:self.emailField.text]) {
        self.emailLabel.text = @"Informe um e-mail válido";
        isValid = false;
    } else {
        self.emailLabel.text = @"";
    }
    return isValid;
}

-(BOOL)isValidEmail:(NSString *)email
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end

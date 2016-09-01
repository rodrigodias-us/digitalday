//
//  ViewController.m
//  DigitalDay
//
//  Created by Rodrigo Gomes Dias on 31/08/16.
//  Copyright © 2016 Rodrigo Gomes Dias. All rights reserved.
//

#import "ViewController.h"
#import "ContainerViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGPoint scrollPoint = CGPointMake(self.scrollView.contentOffset.x, 130);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"embedseg"]) {
        ContainerViewController* containerViewController = (ContainerViewController *) [segue destinationViewController];
        containerViewController.delegate = self;
    }
}

-(void)changePageTo:(int)page {
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * (page - 1);
    frame.origin.y = 0;
    
    [self.view endEditing:@YES];
    [self.scrollView scrollRectToVisible:frame animated:@YES];
}

@end

//
//  ViewController.m
//  Chameleon
//
//  Created by Rajneesh . on 2/17/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import "ViewController.h"
#import "Application.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)unwindToHomePage:(UIStoryboardSegue *)segue
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.iterationsCount) {
        [theTextField resignFirstResponder];
    } else if (theTextField == self.url) {
        [self.iterationsCount becomeFirstResponder];
    }
    return YES;
}

- (BOOL) validateUrl: (NSString *) candidate {
    //NSString *urlRegEx =
    //@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    //NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    //return [urlTest evaluateWithObject:candidate];
    return YES;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    Application *appInstance = [Application getInstance];
    
    appInstance.urlToTest = [NSURL URLWithString:self.url.text];
    appInstance.noOfIterations = [self.iterationsCount.text integerValue];
    appInstance.logString = nil;
    
    NSString *candidate =[appInstance.urlToTest absoluteString];

    if ([self validateUrl: [candidate  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] == FALSE) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Url"
                                                        message:@"Please enter in http://www.abc.com format"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    else {
        return YES;
    }
}

- (IBAction)startBtn:(UIButton *)sender {

    
}
@end

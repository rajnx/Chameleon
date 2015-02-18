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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Application *appInstance = [Application getInstance];
    
    appInstance.urlToTest = [NSURL URLWithString:@"http://www.msn.com"];
    appInstance.noOfIterations = [self.iterationsCount.text integerValue];}

- (IBAction)startBtn:(UIButton *)sender {

    
}
@end

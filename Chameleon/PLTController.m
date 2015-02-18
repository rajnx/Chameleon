//
//  PLTController.m
//  Chameleon
//
//  Created by Rajneesh . on 2/17/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import "PLTController.h"
#import "Application.h"

@implementation PLTController

- (void)viewDidLoad {
    [super viewDidLoad];

    Application *appInstance = [Application getInstance];
    self.webView.delegate = self;
    
    self.methodStart = [NSDate date];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:appInstance.urlToTest
                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:120.0]];
    self.progressLabel.text = @"Started loadrequest";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldStartLoadWithRequest:(NSURLRequest *)request {
    return TRUE;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (!webView.isLoading) {
        self.methodFinish = [NSDate date];
        NSTimeInterval plt = [self.methodFinish timeIntervalSinceDate:self.methodStart];
        self.progressLabel.text = [NSString stringWithFormat:@"PLT = %f ms", plt];
    }
}

- (void)didFailLoadWithError:(NSError *)error {
    
}
- (IBAction)reRun:(id)sender {
    Application *appInstance = [Application getInstance];
    self.webView.delegate = self;
    
    self.methodStart = [NSDate date];
    [self.webView loadRequest:[NSURLRequest requestWithURL:appInstance.urlToTest
                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                           timeoutInterval:120.0]];
    self.progressLabel.text = @"Started loadrequest";
}
@end

//
//  PLTController.m
//  Chameleon
//
//  Created by Rajneesh . on 2/17/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import "PLTController.h"
#import "Application.h"
#import "HtmlLog.h"



@implementation PLTController


-(void)analyzePage:(NSTimer *)timer
{
    [self resetTimersData];
    Application *appInstance = [Application getInstance];
    
    if (self.noOfIterations < appInstance.noOfIterations)
    {        
        self.webViewRequestLoadStart = [NSDate date];
        [self.webView loadRequest:[NSURLRequest requestWithURL:appInstance.urlToTest
                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                               timeoutInterval:120.0]];
        
        self.progressLabel.text = [NSString stringWithFormat:@"Analyzing iteration #%d", self.noOfIterations + 1];
    }
    else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        self.viewReport.enabled = YES;
        [self.timer invalidate];
    }
    
    
    if (!self.timer) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                      target: self
                                                    selector:@selector(analyzePage:)
                                                    userInfo: nil repeats:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.log = [HtmlLog new];
    [self.log initLog];
    
    self.noOfIterations = 0;
    self.webView.delegate = self;
    self.isLoadStarted = FALSE;
    
    self.viewReport.enabled = NO;
    
    [self analyzePage:nil];
    
}

-(void) resetTimersData
{
    self.loadCompleteTime = nil;
    self.loadStartTime = nil;
    self.webViewLoadStart = nil;
    self.webViewRequestLoadStart = nil;
    self.webViewLoadFinish = nil;
    self.isLoadStarted = FALSE;

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldStartLoadWithRequest:(NSURLRequest *)request
{
    NSString *url = [[request URL] absoluteString];
    NSLog(@"webViewDidStartLoad called with url %@", url);
    
    return TRUE;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSString *url = [[[webView request] URL] absoluteString];
    
    NSLog(@"webViewDidStartLoad called with url %@", url);
    
    if (self.isLoadStarted == FALSE)
    {
        self.webViewLoadStart = [NSDate date];
        NSTimeInterval plt = [self.webViewLoadStart timeIntervalSinceDate:self.webViewRequestLoadStart];
        self.loadStartTime = [NSString stringWithFormat:@"%f", plt];
        
        self.isLoadStarted = TRUE;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *url = [[[webView request] URL] absoluteString];
    
    NSLog(@"webViewDidFinishLoad called with url %@", url);
    
    if (!webView.isLoading) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        self.webViewLoadFinish = [NSDate date];
        NSTimeInterval plt = [self.webViewLoadFinish timeIntervalSinceDate:self.webViewLoadStart];
        self.loadCompleteTime = [NSString stringWithFormat:@"%f", plt];
        [self logResult];
        self.noOfIterations++;
    }
    
}

-(void) logResult
{
    NSString *result = [NSString stringWithFormat:@"<tr><td>%d</td><td>%@</td><td>%@</td></tr>", self.noOfIterations + 1, self.loadStartTime, self.loadCompleteTime];
    [self.log addResult:result];
}

- (void)didFailLoadWithError:(NSError *)error
{
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    Application *appInstance = [Application getInstance];

    if (self.noOfIterations < appInstance.noOfIterations)
    {
        return NO;
    }
    else
    {
        appInstance.logString = [self.log getLog];
        return YES;
    }
}

- (IBAction)reRun:(id)sender
{

}
- (IBAction)viewReport:(UIButton *)sender {
}
@end

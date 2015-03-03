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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.log = [HtmlLog new];
    [self.log initLog];
    
    self.noOfIterations = 0;
    self.webView.delegate = self;
    self.isLoadStarted = FALSE;
    
    [self analyzePage];
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
    [[NSURLCache sharedURLCache] setDiskCapacity:0];

    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) analyzePage
{
    [self resetTimersData];
    Application *appInstance = [Application getInstance];
    

    if (self.noOfIterations < appInstance.noOfIterations)
    {
        //[NSThread sleepForTimeInterval:5.0];
        
        self.webViewRequestLoadStart = [NSDate date];
        [self.webView loadRequest:[NSURLRequest requestWithURL:appInstance.urlToTest
                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:120.0]];
    
        self.progressLabel.text = [NSString stringWithFormat:@"Analyzing iteration #%d", self.noOfIterations + 1];
    }
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
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
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
        self.webViewLoadFinish = [NSDate date];
        NSTimeInterval plt = [self.webViewLoadFinish timeIntervalSinceDate:self.webViewLoadStart];
        self.loadCompleteTime = [NSString stringWithFormat:@"%f", plt];
        [self logResult];
        self.noOfIterations++;
        
        [self analyzePage];
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
@end

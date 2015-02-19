//
//  ReportController.m
//  Chameleon
//
//  Created by Rajneesh . on 2/18/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import "ReportController.h"
#import "Application.h"

@implementation ReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Application *appInstance = [Application getInstance];
    
    [self.reportView loadHTMLString:appInstance.logString baseURL:nil];
}


@end

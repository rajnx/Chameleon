//
//  Application.m
//  Chameleon
//
//  Created by Rajneesh . on 2/17/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import "Application.h"

@implementation Application

static Application* appInstance;

+(Application*) getInstance
{
    if (appInstance == nil) {
        appInstance = [Application new];
    }
    
    return  appInstance;
}

@end

//
//  Application.h
//  Chameleon
//
//  Created by Rajneesh . on 2/17/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Application : NSObject

@property(strong, nonatomic) NSURL *urlToTest;
@property(nonatomic) NSInteger noOfIterations;
@property(strong, nonatomic) NSString *logString;


@property(nonatomic, strong) Application *appInstance;

+(Application*) getInstance;

@end

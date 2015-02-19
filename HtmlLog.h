//
//  HtmlLog.h
//  Chameleon
//
//  Created by Rajneesh . on 2/18/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlLog : NSObject

@property(strong, nonatomic) NSString *logFile;

-(void) initLog;
-(void) addResult: (NSString *) result;
- (NSString*) getLog;
-(void) deleteLog;

@end

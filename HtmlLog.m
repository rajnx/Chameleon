//
//  HtmlLog.m
//  Chameleon
//
//  Created by Rajneesh . on 2/18/15.
//  Copyright (c) 2015 Rajneesh. All rights reserved.
//

#import "HtmlLog.h"

NSString* const c_LogFileName = @"pltLog.htm";

NSString* const c_ReportHtmlStart =
@"<!DOCTYPE html>"
@"<html>"
@"<head>"
@"<style>"
@"table {"
@"width:100%;"
@"}"
@"table, th, td {"
@"border: 1px solid black;"
@"    border-collapse: collapse;"
@"}"
@"th, td {"
@"padding: 5px;"
@"  text-align: left;"
@"}"
@"table#t01 tr:nth-child(even) {"
@"    background-color: #eee;"
@"}"
@"table#t01 tr:nth-child(odd) {"
@"    background-color:#fff;"
@"}"
@"table#t01 th	{"
@"    background-color: black;"
@"color: white;"
@"}"
@"</style>"
@"</head>"
@"<body>"
@"<table id=""t01"">"
@"<tr>"
@"<th>Iteration #</th>"
@"<th>Time to Load Page (in Secs)</th>"
@"<th>Time to Show Page (in Secs)</th>"
@"</tr>";

NSString* const c_ReportHtmlEnd =
@"</table>"
@"</body>"
@"</html>";

@implementation HtmlLog

-(void) initLog
{
    //Get the file path
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.logFile = [documentsDirectory stringByAppendingPathComponent:c_LogFileName];
    
    //create file if it doesn't exist
    if([[NSFileManager defaultManager] fileExistsAtPath:self.logFile])
    {
        [[NSFileManager defaultManager] removeItemAtPath:self.logFile error:nil];
    }
    
    [[NSFileManager defaultManager] createFileAtPath:self.logFile contents:nil attributes:nil];
    [self addResult:c_ReportHtmlStart];
    
}

-(void) addResult: (NSString *) result
{
    //append text to file (you'll probably want to add a newline every write)
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:self.logFile];
    
    [file seekToEndOfFile];
    [file writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
}

- (NSString*) getLog
{
    [self addResult:c_ReportHtmlEnd];

    //read the whole file as a single string
    NSString *content = [NSString stringWithContentsOfFile:self.logFile encoding:NSUTF8StringEncoding error:nil];
    
    return content;
}

-(void) deleteLog
{
    
}

@end

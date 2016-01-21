//
//  HttpOperation.m
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/21.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import "HttpOperation.h"
#import "ReadingEntity.h"

@implementation HttpOperation

+(ReadingEntity*)RequestReadingContent:(int)No {
    ReadingEntity* reading = [[ReadingEntity alloc] init];
    NSString *data1 = @"http://localhost:8080/IosService/Reading";
    data1 = [data1 stringByAppendingString:@"?date="];
    
    data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"%d", No]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
    NSError * error = nil;
    
    NSURLResponse *response=nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    id JsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *jsonDictionary = (NSDictionary*)JsonObj;
    NSString *desContent = [[jsonDictionary valueForKey:@"article"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [reading setReadingContent:desContent];
    [reading setNo:No];
    [reading setReadingTitle:nil];
    [reading setAuthor:nil];
    [reading setRecommender:nil];
    
    return reading;

}

@end

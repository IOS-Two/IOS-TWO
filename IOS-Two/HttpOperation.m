//
//  HttpOperation.m
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/21.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import "HttpOperation.h"
#import "ReadingEntity.h"
#import "AppDelegate.h"
#import "QuestionEntity.h"

@implementation HttpOperation

+(int)RequestTotalVol {
    NSString *data1 = TotalUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
    NSError * error = nil;
    NSURLResponse *response=nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    if (data == nil) {
        return 0;
    }
    NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return (int)[aString integerValue];
}

+(QuestionEntity*)RequestQuestionContent:(int)No{
    NSString* who = [AppDelegate getRecommender];
    QuestionEntity* question = [[QuestionEntity alloc] init];
    NSString *data1 = QuestionUrl;
    data1 = [data1 stringByAppendingString:@"?date="];
    data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"%d", No]];
    data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"&who=%@", who]];
    //data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"%d", 1]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
    NSError * error = nil;
    
    NSURLResponse *response=nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    if (data == nil) {
        return nil;
    }
    if (error == nil) NSLog(@"success");
    id JsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *jsonDictionary = (NSDictionary*)JsonObj;
    NSString *desContent = [[jsonDictionary valueForKey:@"article"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [question setQuestionContent:desContent];
    [question setNo:No];
    return question;
}

+(ReadingEntity*)RequestReadingContent:(int)No {
    NSString* who = [AppDelegate getRecommender];
    ReadingEntity* reading = [[ReadingEntity alloc] init];
    NSString *data1 = ReadingUrl;
    data1 = [data1 stringByAppendingString:@"?date="];
    data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"%d", No]];
    data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"&who=%@", who]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
    NSError * error = nil;
    
    NSURLResponse *response=nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    if (data == nil) {
        return nil;
    }
    id JsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *jsonDictionary = (NSDictionary*)JsonObj;
    NSString *desContent = [[jsonDictionary valueForKey:@"article"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *title = [[jsonDictionary valueForKey:@"title"]
                       stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *author = [[jsonDictionary valueForKey:@"author"]
                        stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [reading setReadingContent:desContent];
    [reading setNo:No];
    [reading setReadingTitle:title];
    [reading setAuthor:author];
    [reading setRecommender:nil];
    return reading;
}

+(PictureEntity*)RequestPictureContent:(int)No {
    NSString* who = [AppDelegate getRecommender];
    PictureEntity* picture = [[PictureEntity alloc] init];
    NSString *data1 = PictureUrl;
    data1 = [data1 stringByAppendingString:@"?date="];
    data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"%d", No]];
    data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"&who=%@", who]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
    NSError * error = nil;
    
    NSURLResponse *response=nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    if (data == nil) {
        return nil;
    }
    id JsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *jsonDictionary = (NSDictionary*)JsonObj;
    
    
    NSString* url = [[jsonDictionary valueForKey:@"url"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *title = [[jsonDictionary valueForKey:@"title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *picturedes =[[jsonDictionary valueForKey:@"describtion"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *recommender = [[jsonDictionary valueForKey:@"recommender"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *author = [[jsonDictionary valueForKey:@"author"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [picture setTitle:title];
    [picture setPictureDes:picturedes];
    [picture setRecommender:recommender];
    [picture setAuthor:author];
    [picture setNo:No];
    [picture setPicutureUrl:url];
    return picture;
}

@end

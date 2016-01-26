//
//  HttpOperation.h
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/21.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadingEntity.h"
#import "QuestionEntity.h"
#import "PictureEntity.h"
#import "PictureEntity.h"

#define ReadingUrl @"http://localhost:8080/IosService/Reading"
#define QuestionUrl @"http://localhost:8080/IosService/question"
#define PictureUrl @"http://localhost:8080/IosService/Picture"
#define TotalUrl @"http://localhost:8080/IosService/TotalVol"
#define ImageUrl @"http://localhost:8080/IosService/picture/"
#define AboutUrl @"http://localhost:8080/IosService/about.html"

//#define ReadingUrl @"http://192.168.0.4:8080/IosService/Reading"
//#define QuestionUrl @"http://l192.168.0.4:8080/IosService/question"
//#define PictureUrl @"http://192.168.0.4:8080/IosService/Picture"
//#define TotalUrl @"http://192.168.0.4:8080/IosService/TotalVol"
//#define ImageUrl @"http://192.168.0.4:8080/IosService/picture/"

@interface HttpOperation : NSObject

+(ReadingEntity*)RequestReadingContent:(int)No;
+(QuestionEntity*)RequestQuestionContent:(int)No;
+(PictureEntity*)RequestPictureContent:(int)No;
+(int)RequestTotalVol;

@end

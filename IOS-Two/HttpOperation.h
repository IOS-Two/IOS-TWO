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

@interface HttpOperation : NSObject

+(ReadingEntity*)RequestReadingContent:(int)No;
+(QuestionEntity*)RequestQuestionContent:(int)No;
+(PictureEntity*)RequestPictureContent:(int)No;

@end

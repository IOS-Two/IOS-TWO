//
//  QuestionEntity.h
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/20.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionEntity : NSObject <NSCoding>


@property int No;
@property NSString *QuestionContent;
@property NSString *Recommender;

@end

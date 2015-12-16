//
//  ReadingEntity.h
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/15.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadingEntity : NSObject <NSCoding>

@property NSString *ReadingTitle;
@property int No;
@property NSString *ReadingContent;
@property NSString *Recommender;
@property NSString *Author;

@end

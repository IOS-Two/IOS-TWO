//
//  PictureEntity.h
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/24.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureEntity : NSObject <NSCoding>

@property int No;
@property NSString *PictureDes;
@property NSString *Recommender;
@property NSString *Author;
@property NSData *Picture;
@end

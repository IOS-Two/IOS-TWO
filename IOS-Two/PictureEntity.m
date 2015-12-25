//
//  PictureEntity.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/24.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "PictureEntity.h"

@implementation PictureEntity
@synthesize No = _No;
@synthesize ImageContent = _ImageContent;
@synthesize PictureDes = _PictureDes;
@synthesize Recommender= _Recommender;
@synthesize Author = _Author;
@synthesize height = _height;
@synthesize width = _width;


-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.ImageContent=[aDecoder decodeObjectForKey:@"ImageContent"];
        self.Author=[aDecoder decodeObjectForKey:@"author"];
        self.PictureDes=[aDecoder decodeObjectForKey:@"des"];
        self.No=[aDecoder decodeIntForKey:@"No"];
        self.Recommender=[aDecoder decodeObjectForKey:@"recommender"];
        self.height=[aDecoder decodeFloatForKey:@"height"];
        self.width=[aDecoder decodeFloatForKey:@"width"];
       
    }
    return self;
}
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.ImageContent forKey:@"ImageContent"];
    [aCoder encodeObject:self.Author forKey:@"author"];
    [aCoder encodeInt:self.No forKey:@"No"];
    [aCoder encodeObject:self.Recommender forKey:@"recommender"];
    [aCoder encodeObject:self.PictureDes forKey:@"des"];
    [aCoder encodeFloat:self.height forKey:@"height"];
    [aCoder encodeFloat:self.width forKey:@"width"];
   
}

@end

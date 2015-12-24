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
@synthesize PictureDes = _PictureDes;
@synthesize Recommender= _Recommender;
@synthesize Author = _Author;
@synthesize Picture = _Picture;

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.PictureDes=[aDecoder decodeObjectForKey:@"Describtion"];
        self.Author=[aDecoder decodeObjectForKey:@"author"];
        self.Picture=[aDecoder decodeObjectForKey:@"picture"];
        self.No=[aDecoder decodeIntForKey:@"No"];
        self.Recommender=[aDecoder decodeObjectForKey:@"recommender"];
    }
    return self;
}
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.Picture forKey:@"picture"];
    [aCoder encodeObject:self.Author forKey:@"author"];
    [aCoder encodeInt:self.No forKey:@"No"];
    [aCoder encodeObject:self.Recommender forKey:@"recommender"];
    [aCoder encodeObject:self.PictureDes forKey:@"Describtion"];
}

@end

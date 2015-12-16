//
//  ReadingEntity.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/15.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "ReadingEntity.h"

@implementation ReadingEntity
@synthesize No = _No;
@synthesize ReadingContent = _ReadingContent;
@synthesize ReadingTitle = _ReadingTitle;
@synthesize Recommender= _Recommender;
@synthesize Author = _Author;

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.ReadingTitle=[aDecoder decodeObjectForKey:@"title"];
        self.Author=[aDecoder decodeObjectForKey:@"author"];
        self.ReadingContent=[aDecoder decodeObjectForKey:@"content"];
        self.No=[aDecoder decodeIntForKey:@"No"];
        self.Recommender=[aDecoder decodeObjectForKey:@"recommender"];
    }
    return  self;
}
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.ReadingTitle forKey:@"title"];
    [aCoder encodeObject:self.Author forKey:@"author"];
    [aCoder encodeInt:self.No forKey:@"No"];
    [aCoder encodeObject:self.Recommender forKey:@"recommender"];
    [aCoder encodeObject:self.ReadingContent forKey:@"content"];
}



@end

//
//  QuestionEntity.m
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/20.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import "QuestionEntity.h"

@implementation QuestionEntity
@synthesize No = _No;
@synthesize QuestionContent = _QuestionContent;
@synthesize Recommender = _Recommender;

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.QuestionContent = [aDecoder decodeObjectForKey:@"QuestionContent"];
        self.No=[aDecoder decodeIntForKey:@"No"];
        self.Recommender=[aDecoder decodeObjectForKey:@"recommender"];
        
    }
    return self;
}
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt:self.No forKey:@"No"];
    [aCoder encodeObject:self.Recommender forKey:@"recommender"];
    [aCoder encodeObject:self.QuestionContent forKey:@"QuestionContent"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

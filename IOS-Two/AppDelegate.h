//
//  AppDelegate.h
//  IOS-Two
//
//  Created by 江晨舟 on 15/11/30.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+(int)instanceWho;
+(void)setWho:(int) co;
+(int)getTotalVol;
+(CGFloat)getwidth;
+(BOOL)getIsNight;
+(void)setIsNight: (BOOL)mode;
+(NSString*)getRecommender;

@end


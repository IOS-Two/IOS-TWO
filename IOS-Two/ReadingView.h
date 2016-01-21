//
//  ReadingView.h
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/20.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingEntity.h"

@interface ReadingView : UIView

-(void)ConfigureReadingContent:(ReadingEntity*)reading BackC:(NSString*)backgroundColor CharC:(NSString*)
    charactersColor;


@end

//
//  PictureView.h
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/21.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureEntity.h"
@interface PictureView : UIView
-(void)ConfigurePictureContent:(PictureEntity*)picture BackC:(NSString*)backgroundColor CharC:(NSString*)
    charactersColor;
@end

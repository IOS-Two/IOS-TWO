//
//  PictureTableViewCell.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/24.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "PictureTableViewCell.h"

@implementation PictureTableViewCell

- (void) Completed:(NSURL *)location URLResponse:(NSURLResponse *)response Error:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (error == nil) {
        self.picture.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
    }
    else {
        NSLog(@"Error");
    }
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/IosService/custom.jpg"];
    NSURLSessionDownloadTask *downloadPhotoTask =[[NSURLSession sharedSession]
                                                  downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                      [self Completed:location URLResponse:response Error:error];
                                                  }];
    
    [downloadPhotoTask resume];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

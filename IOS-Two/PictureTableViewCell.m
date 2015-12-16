//
//  PictureTableViewCell.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/15.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "PictureTableViewCell.h"

@implementation PictureTableViewCell

@synthesize pheight;

- (void) Completed:(NSURL *)location URLResponse:(NSURLResponse *)response Error:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (error == nil) {
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pictrueView.image = downloadedImage;
            float p = downloadedImage.size.height / downloadedImage.size.width;
            self.pheight = [[UIScreen mainScreen] bounds].size.width * p;
            [self.pictrueView sizeToFit];
    });
    } else {
        NSLog(@"Error");
    }
}



- (void)awakeFromNib {
    // Initialization code
    
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

//
//  PictureViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/13.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "PictureViewController.h"
#import "AppDelegate.h"
#import "PictureEntity.h"

@interface PictureViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *ContentWebView;

@end

@implementation PictureViewController

-(void) savePictrue:(PictureEntity *)picture {
    NSString * temp = [NSString stringWithFormat:@"Reading%d.archive" , picture.No];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:picture toFile:path];
    if (sucess)
    {
        NSLog(@"archive sucess");
    }
}

-(PictureEntity*) decodePicture:(int)vol path:(NSString*)path{
    PictureEntity* picture = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"Read archive");
    return picture;
}


- (NSString *)htmlForJPGImage:(UIImage *)image
{
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat p = imageHeight / imageWidth;
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    NSString *imageSource = [NSString stringWithFormat:@"data:image/jpg;base64,%@",[imageData base64Encoding]];
    CGFloat width = [AppDelegate getwidth] - 30;
    CGFloat height = width * p;
    return [NSString stringWithFormat:@"<img src = \"%@\" height = %f width= %f/>", imageSource, height
            , width];
}


- (void) Completed:(NSURL *)location URLResponse:(NSURLResponse *)response Error:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (error == nil) {
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *stringImage = [self htmlForJPGImage:downloadedImage];
            NSString *HTMLTitle = [NSString stringWithFormat:@"<!-- 文章标题 --><p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 20px; margin-left: 0px;\">%@</p>", @"#333333", @"你别来客栈"];
            NSString *HTMLContent =  [NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 10px; margin-left: 0px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div>", @"#888888", @"咱们家美美哒智孝欧尼~~~"];
                        //构造内容
            NSString *contentImg = [NSString stringWithFormat:@"<p style=\" font-size: 21px; font-weight: bold; margin-top: 20px; margin-left: 0px; margin-left: 0px;\">%@</p>", stringImage];
            NSString *content =[NSString stringWithFormat:
                                @"<html>"
                                "<style type=\"text/css\">"
                                "<!--"
                                "body{font-size:40pt;line-height:60pt;}"
                                "-->"
                                "</style>"
                                "<body>"
                                "%@"
                                "%@"
                                "%@"
                                "</body>"
                                "</html>"
                                ,@"Vol.1"
                                ,contentImg
                                , HTMLContent];
            
            //让self.contentWebView加载content
            [self.ContentWebView loadHTMLString:content baseURL:nil];
        });
    } else {
        NSLog(@"Error");
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.ContentWebView.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/IosService/haha.jpg"];
    NSURLSessionDownloadTask *downloadPhotoTask =[[NSURLSession sharedSession]
                                                  downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                      [self Completed:location URLResponse:response Error:error];
                                                  }];
    
    [downloadPhotoTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

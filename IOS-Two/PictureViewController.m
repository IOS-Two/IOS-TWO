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
int PictrueNo = 1;

-(void) viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
}

-(void) savePictrue:(PictureEntity *)picture path:(NSString*)path {
    BOOL sucess = [NSKeyedArchiver archiveRootObject:picture toFile:path];
    if (sucess) {
        NSLog(@"archive sucess");
    }
}

-(PictureEntity*) decodePicture:(int)vol path:(NSString*)path{
    PictureEntity* picture = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"Read archive");
    return picture;
}


- (NSString *)htmlForJPGImage:(PictureEntity*)picture {
    CGFloat imageWidth = [picture width];
    CGFloat imageHeight = [picture height];
    CGFloat p = imageHeight / imageWidth;

    UIImage* result = (UIImage*)[picture ImageContent];
    NSData *imageData = UIImageJPEGRepresentation(result,1.0);
    NSString *imageSource = [NSString stringWithFormat:@"data:image/jpg;base64,%@",[imageData base64Encoding]];
    CGFloat width = [AppDelegate getwidth] - 30;
    CGFloat height = width * p;
    return [NSString stringWithFormat:@"<img src = \"%@\" height = %f width= %f/>", imageSource, height
            , width];
}

- (void) configureWebViewContent:(PictureEntity*) picture {
    NSString *backgroundColor;
    NSString *charactersColor;
    if ([AppDelegate getIsNight]) {
        backgroundColor = @"3C3C3C";
        charactersColor = @"D0D0D0";
    }
    else {
        backgroundColor = @"FFFFFF";
        charactersColor = @"333333";
    }
    NSString *stringImage = [self htmlForJPGImage:picture];
    NSString *title = [NSString stringWithFormat:@"Vol.%d", PictrueNo];
    NSString *des = [picture PictureDes];
    NSString *HTMLTitle = [NSString stringWithFormat:@"<p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 20px; margin-left: 0px;\">%@</p>", charactersColor, title];
    NSString *HTMLContent =  [NSString stringWithFormat:@"<div style=\"line-height: 20px; margin-top: 10px; margin-left: 0px; margin-right: 15px; color: %@; font-size: 12px;\">%@</div>", charactersColor, des];
    NSString *contentImg = [NSString stringWithFormat:@"<p style=\"  font-size: 14px; font-weight: bold; margin-top: 20px; margin-left: 0px; margin-left: 0px;\">%@</p>",stringImage];
    NSString *HTMLAuthor =  [NSString stringWithFormat:@"<div style=\"line-height: 6px; margin-top: 0px; margin-left: 0px; text-align: right ;margin-right: 15px; color: %@; font-size: 12px;\">%@</div>", charactersColor, [picture Author]];

    NSString *content =[NSString stringWithFormat:
                        @"<html>"
                        "<body bgcolor=\"%@\">"
                        "<body>"
                        "%@"
                        "%@"
                        "%@"
                        "%@"
                        "</body>"
                        "</html>"
                        ,backgroundColor
                        ,HTMLTitle
                        ,contentImg
                        , HTMLContent
                        , HTMLAuthor];
    
    //让self.contentWebView加载content
    [self.ContentWebView loadHTMLString:content baseURL:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([AppDelegate getIsNight]) {
        self.view.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        self.ContentWebView.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        UIColor * color = [UIColor colorWithRed:0xD0/255.0 green:0xD0/255.0 blue:0xD0/255.0 alpha:1];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;

    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.ContentWebView.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;

    }
    
    
    PictureEntity *picture = [[PictureEntity alloc] init];
    NSString * temp;
    NSString * who;
    if ([AppDelegate instanceWho] == 0) {
        temp = [NSString stringWithFormat:@"Picture%dg.archive" ,PictrueNo];
        who = @"g";
    }
    else {
        temp = [NSString stringWithFormat:@"Picture%dj.archive" ,PictrueNo];
        who = @"j";
    }

    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] == nil) {
        
        NSString *data1 = @"http://localhost:8080/IosService/Picture";
        data1 = [data1 stringByAppendingString:@"?date="];
        data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"%d", PictrueNo]];
        data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"&who=%@", who]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
        NSError * error = nil;
        
        NSURLResponse *response=nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&error];
        id JsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *jsonDictionary = (NSDictionary*)JsonObj;
        
        
        NSURL *url = [NSURL URLWithString:[[jsonDictionary valueForKey:@"url"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSString *picturedes =[[jsonDictionary valueForKey:@"describtion"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *recommender = [[jsonDictionary valueForKey:@"recommender"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *author = [[jsonDictionary valueForKey:@"author"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLSessionDownloadTask *downloadPhotoTask =[[NSURLSession sharedSession]
                                                      downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                          if (error == nil) {
                                                              UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  [picture setPictureDes:picturedes];
                                                                  [picture setRecommender:recommender];
                                                                  [picture setAuthor:author];
                                                                  [picture setNo:PictrueNo];
                                                                  [picture setHeight:downloadedImage.size.height];
                                                                  [picture setWidth:downloadedImage.size.width];
                                                                  [picture setImageContent:(NSData*)downloadedImage];
                                                                  
                                                                  [self configureWebViewContent:picture];
                                                                  [self savePictrue:picture path:path];
                                                              });
                                                          } else {
                                                              NSLog(@"Error");
                                                          }

                                                          
                                                      }];
        
        [downloadPhotoTask resume];
    }
    else {
        picture = [self decodePicture:PictrueNo path:path];
        [self configureWebViewContent:picture];
    }
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

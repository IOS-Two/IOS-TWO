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
#import "PictureView.h"
#import "SettingTableViewController.h"
#import "HttpOperation.h"

@interface PictureViewController ()
@property (strong, nonatomic) PictureView* pictureView;
@property int No;
@property BOOL NightMode;
@property NSString* Recommender;
@property BOOL isFirstTime;
@end

@implementation PictureViewController
-(instancetype)init {
    self.isFirstTime = true;
    return self;
}


-(void) viewWillAppear:(BOOL)animated {
    if (![self.Recommender isEqualToString:[AppDelegate getRecommender]] ||
        (self.NightMode != [AppDelegate getIsNight]))
        [self viewDidLoad];
    if (self.isFirstTime) {
        self.isFirstTime = false;
        [self viewDidLoad];
    }
}

-(void)RightLook {
    if (self.No <= 1) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"木有更多~" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
    else {
        [UIView beginAnimations:@"Curl" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        
        self.No--;
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
        
        [self.pictureView removeFromSuperview];
        self.pictureView = nil;
        [self addPictureViewToSuperView:self.No BackC:backgroundColor CharC:charactersColor];
        [UIView commitAnimations];
    }
}

-(void)LeftLook {
    if (self.No >= [AppDelegate getTotalVol]) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"木有更多~" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
    else {
        [UIView beginAnimations:@"Curl" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
        
        self.No++;
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
        
        [self.pictureView removeFromSuperview];
        self.pictureView = nil;
        [self addPictureViewToSuperView:self.No BackC:backgroundColor CharC:charactersColor];
        [UIView commitAnimations];
    }
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.No = [HttpOperation RequestTotalVol];
    self.Recommender = [AppDelegate getRecommender];
    self.NightMode = [AppDelegate getIsNight];
    NSString *backgroundColor;
    NSString *charactersColor;
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"←" style:UIBarButtonItemStylePlain target:self action:@selector(LeftLook)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"→" style:UIBarButtonItemStylePlain target:self action:@selector(RightLook)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;

    if ([AppDelegate getIsNight]) {
        backgroundColor = @"3C3C3C";
        charactersColor = @"D0D0D0";
        self.view.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        UIColor * color = [UIColor colorWithRed:0xD0/255.0 green:0xD0/255.0 blue:0xD0/255.0 alpha:1];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;

    } else {
        backgroundColor = @"FFFFFF";
        charactersColor = @"333333";
        self.view.backgroundColor = [UIColor whiteColor];
               self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    if (self.No == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"啊哦" message:@"加载失败···" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
        return;
    }
    [self addPictureViewToSuperView:self.No BackC:backgroundColor CharC:charactersColor];
    
}

-(void)addPictureViewToSuperView:(int)No BackC:(NSString*)back CharC:(NSString*)charC{
    PictureEntity *picture = [[PictureEntity alloc] init];
    CGRect mainrect = [UIScreen mainScreen].bounds;
    self.pictureView = [[PictureView alloc] initWithFrame:CGRectMake(0, 0, mainrect.size.width, mainrect.size.height)];
    NSString * who = [AppDelegate getRecommender];
    NSString * temp = [NSString stringWithFormat:@"picture%d%@.archive" ,No, who];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] == nil) {
        
        picture = [HttpOperation RequestPictureContent:No];
        if (picture == nil) {
            
        }
        NSString *data1 = ImageUrl;
        data1 = [data1 stringByAppendingString:[picture PicutureUrl]];
        NSLog(@"%@", data1);
        NSURL *url = [NSURL URLWithString:[data1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLSessionDownloadTask *downloadPhotoTask =[[NSURLSession sharedSession]
                                                      downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                          if (error == nil) {
                                                              UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  [picture setHeight:downloadedImage.size.height];
                                                                  [picture setWidth:downloadedImage.size.width];
                                                                  [picture setImageContent:(NSData*)downloadedImage];
                                                                  [self savePictrue:picture path:path];
                                                                  [self.pictureView ConfigurePictureContent:picture BackC:back CharC:charC];
                                                                  [self.view addSubview:self.pictureView];
                                                              });
                                                          } else {
                                                              NSLog(@"Error");
                                                          }
                                                          
                                                      }];
        
        [downloadPhotoTask resume];
    }
    else {
        picture = [self decodePicture:self.No path:path];
        [self.pictureView ConfigurePictureContent:picture BackC:back CharC:charC];
        [self.view addSubview:self.pictureView];
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

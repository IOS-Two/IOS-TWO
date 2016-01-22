//
//  ReadViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/5.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "ReadViewController.h"
#import "AppDelegate.h"
#import "ReadingEntity.h"
#import "ReadingView.h"
#import "HttpOperation.h"
#import "SettingTableViewController.h"

@interface ReadViewController () //<UIScrollViewDelegate>

//@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray* readingViewArray;
@property (strong, nonatomic) ReadingView* readingView;

@property int No;

@end

@implementation ReadViewController
//@synthesize rightSwipeGestureRecognizer;
//@synthesize leftSwipeGestureRecognizer;

-(void) viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
    
    if ([SettingTableViewController getNightModeIsSwitch]) {
        [SettingTableViewController setNightModeIsSwitch:false];
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self viewDidLoad];
    }
    else if([SettingTableViewController getRecommenderIsSwitch]) {
        [SettingTableViewController setRecommenderIsSwitch:false];
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self viewDidLoad];
    }
}

-(void) saveReading:(ReadingEntity *)reading {
    NSString* who = [AppDelegate getRecommender];
    NSString * temp = [NSString stringWithFormat:@"Reading%d%@.archive" , reading.No, who];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:reading toFile:path];
    if (sucess)
    {
//        NSLog(@"archive sucess");
    }
}

-(ReadingEntity*) decodeReading:(int)vol path:(NSString*)path{
    ReadingEntity *Reading = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    NSLog(@"Read archive");
    return Reading;
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
        ReadingEntity* reading = [self loadReadingContent:self.No];
        CGRect mainrect = [[UIScreen mainScreen] bounds];
        [self.readingView removeFromSuperview];
        self.readingView = [[ReadingView alloc] initWithFrame:CGRectMake(0, 70, mainrect.size.width, mainrect.size.height)];
        [self.readingView ConfigureReadingContent:reading BackC:backgroundColor CharC:charactersColor];
        [self.view addSubview:self.readingView];
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
        ReadingEntity* reading = [self loadReadingContent:self.No];
        CGRect mainrect = [[UIScreen mainScreen] bounds];
        [self.readingView removeFromSuperview];
        self.readingView = [[ReadingView alloc] initWithFrame:CGRectMake(0, 70, mainrect.size.width, mainrect.size.height)];
        [self.readingView ConfigureReadingContent:reading BackC:backgroundColor CharC:charactersColor];
        [self.view addSubview:self.readingView];
        [UIView commitAnimations];

    }
}

-(ReadingEntity*)loadReadingContent:(int)No {
    NSString* who = [AppDelegate getRecommender];
    ReadingEntity *reading = [[ReadingEntity alloc] init];
    NSString * temp = [NSString stringWithFormat:@"Reading%d%@.archive" ,No, who];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] == nil) {
        reading = [HttpOperation RequestReadingContent:No];
        [self saveReading:reading];
    }
    else {
        reading = [self decodeReading:No path:path];
    }
    return reading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.readingViewArray = [[NSMutableArray alloc] init];
//    self.No = [AppDelegate getTotalVol];
//   
//    self.scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.scrollView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:self.scrollView];
//    self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * [AppDelegate getTotalVol], [[UIScreen mainScreen] bounds].size.height);
//
//    self.scrollView.delegate = self;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.pagingEnabled = YES;
    
//    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
//    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
//    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
//    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    self.readingViewArray = [[NSMutableArray alloc] init];
    self.No = [AppDelegate getTotalVol];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"←" style:UIBarButtonItemStylePlain target:self action:@selector(LeftLook)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"→" style:UIBarButtonItemStylePlain target:self action:@selector(RightLook)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
    
    NSString *backgroundColor;
    NSString *charactersColor;
    if ([AppDelegate getIsNight]) {
        backgroundColor = @"3C3C3C";
        charactersColor = @"D0D0D0";
        self.view.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        UIColor * color = [UIColor colorWithRed:0xD0/255.0 green:0xD0/255.0 blue:0xD0/255.0 alpha:1];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    else {
        backgroundColor = @"FFFFFF";
        charactersColor = @"333333";
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    
    NSString* who = [AppDelegate getRecommender];
    ReadingEntity *reading = [[ReadingEntity alloc] init];
    NSString * temp = [NSString stringWithFormat:@"Reading%d%@.archive" ,self.No, who];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] == nil) {
        reading = [HttpOperation RequestReadingContent:self.No];
        [self saveReading:reading];
    }
    else {
        reading = [self decodeReading:self.No path:path];
    }
    
    CGRect mainrect = [UIScreen mainScreen].bounds;
    self.readingView = [[ReadingView alloc] initWithFrame:CGRectMake(0, 70, mainrect.size.width, mainrect.size.height)];
    [self.readingView ConfigureReadingContent:reading BackC:backgroundColor CharC:charactersColor];
    //[self.view addSubview:self.readingView];
    [self.view addSubview:self.readingView];

}


//-(void)loadReadingView:(int)No BackC:(NSString*)backgroundColor CharC:(NSString*)charactersColor{
//    int page = [AppDelegate getTotalVol] - No;
//    if (page >= [self.readingViewArray count]) {
//        NSString* who = [AppDelegate getRecommender];
//        ReadingEntity *reading = [[ReadingEntity alloc] init];
//        NSString * temp = [NSString stringWithFormat:@"Reading%d%@.archive" ,No, who];
//        NSString *homePath = NSHomeDirectory();
//        NSString *path = [homePath stringByAppendingPathComponent:temp];
//        if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] == nil) {
//            reading = [HttpOperation RequestReadingContent:No];
//            [self saveReading:reading];
//        }
//        else {
//            reading = [self decodeReading:No path:path];
//        }
//        
//        CGRect mainrect = [UIScreen mainScreen].bounds;
//        ReadingView* readingView ;
//        readingView = [[ReadingView alloc] initWithFrame:CGRectMake(page * mainrect.size.width + 1, 30, mainrect.size.width -2, mainrect.size.height - 100)];
//        [readingView ConfigureReadingContent:reading BackC:backgroundColor CharC:charactersColor];
//        [self.readingViewArray addObject:readingView];
//        [self.scrollView addSubview:readingView];
//
//    }
//    else
//        return;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSString *backgroundColor;
//    NSString *charactersColor;
//    if ([AppDelegate getIsNight]) {
//        backgroundColor = @"3C3C3C";
//        charactersColor = @"D0D0D0";
//    }
//    else {
//        backgroundColor = @"FFFFFF";
//        charactersColor = @"333333";
//    }
//    CGFloat pageWidth = [[UIScreen mainScreen] bounds].size.width;
//    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    self.No = [AppDelegate getTotalVol] - page;
//    NSLog(@"No:%d", self.No);
//    NSLog(@"page:%d", page);
////    CGRect bounds = self.scrollView.bounds;
////    bounds.origin.x = page * pageWidth;
////    bounds.origin.y = 30;
////    [self.scrollView scrollRectToVisible:bounds animated:YES];
//    [self loadReadingView:self.No BackC:backgroundColor CharC:charactersColor];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

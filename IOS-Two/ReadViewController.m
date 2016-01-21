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

@interface ReadViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) ReadingView* readingView;
@property (strong, nonatomic) NSMutableArray* readingViewArray;

@property int No;

@end

@implementation ReadViewController

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSString *backgroundColor;
    NSString *charactersColor;
    if ([AppDelegate getIsNight]) {
        backgroundColor = @"3C3C3C";
        charactersColor = @"D0D0D0";
        
        self.view.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        self.scrollView.backgroundColor =[UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        UIColor * color = [UIColor colorWithRed:0xD0/255.0 green:0xD0/255.0 blue:0xD0/255.0 alpha:1];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;
        
    }
    else {
        backgroundColor = @"FFFFFF";
        charactersColor = @"333333";
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.scrollView.backgroundColor =[UIColor whiteColor];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    ReadingEntity *reading = [[ReadingEntity alloc] init];
    NSString * temp = [NSString stringWithFormat:@"Reading%d.archive" ,self.No];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    reading = [self decodeReading:self.No path:path];
    [self.readingView ConfigureReadingContent:reading BackC:backgroundColor CharC:charactersColor];
}

-(void) saveReading:(ReadingEntity *)reading {
    NSString * temp = [NSString stringWithFormat:@"Reading%d.archive" , reading.No];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:reading toFile:path];
    if (sucess)
    {
        NSLog(@"archive sucess");
    }
}

-(ReadingEntity*) decodeReading:(int)vol path:(NSString*)path{
    ReadingEntity *Reading = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"Read archive");
    return Reading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.readingViewArray = [[NSMutableArray alloc] init];
    self.No = [AppDelegate getTotalVol];
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

    self.scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * [AppDelegate getTotalVol],
                                             [[UIScreen mainScreen] bounds].size.height- 200);
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;

    ReadingEntity *reading = [[ReadingEntity alloc] init];
    NSString * temp = [NSString stringWithFormat:@"Reading%d.archive" ,self.No];
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
    self.readingView = [[ReadingView alloc] initWithFrame:CGRectMake(0, 0, mainrect.size.width, mainrect.size.height - 130)];
    [self.readingView ConfigureReadingContent:reading BackC:backgroundColor CharC:charactersColor];
    [self.readingViewArray addObject:self.readingView];
    [self.scrollView addSubview:self.readingView];
    
}

-(void)loadReadingView:(ReadingView*)readingView Number:(int)No {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat pageWidth = [[UIScreen mainScreen] bounds].size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.No = [AppDelegate getTotalVol] - page;
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = pageWidth * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
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

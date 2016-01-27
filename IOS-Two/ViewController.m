//
//  ViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/11/30.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "ViewController.h"
#import "HttpOperation.h"
#import "SettingTableViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property BOOL NightMode;
@property NSString* Recommender;
@property BOOL isFirstTime;
@end

@implementation ViewController

UIActivityIndicatorView *activityIndicator;
NSURLRequest *urlRequest;

-(instancetype)init {
    self.isFirstTime = true;
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    //    [super viewWillAppear:YES];
    NSString *backgroundColor;
    NSString *charactersColor;
    if (![self.Recommender isEqualToString:[AppDelegate getRecommender]] ||
        (self.NightMode != [AppDelegate getIsNight])) {
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
    }
    if (self.isFirstTime) {
        self.isFirstTime = false;
        [self viewDidLoad];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *backgroundColor;
    NSString *charactersColor;
    self.Recommender = [AppDelegate getRecommender];
    self.NightMode = [AppDelegate getIsNight];
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

    CGRect cgrect=[UIScreen mainScreen].bounds;
    uiWebVIew = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,cgrect.size.width,cgrect.size.height)];
    urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:AboutUrl]];
    [self.view addSubview:uiWebVIew];
    uiWebVIew.delegate=self;
    [uiWebVIew loadRequest:urlRequest];
    
    //[self.view addSubview:uiTabBar];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    CGRect cgrect=[UIScreen mainScreen].bounds;
    //创建UIActivityIndicatorView背底半透明View
    UIView *view=[[UIView alloc] initWithFrame:cgrect];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f ,32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    UIView *view =[self.view viewWithTag:108];
    [view removeFromSuperview];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", error);
    [activityIndicator stopAnimating];
    UIView *view =[self.view viewWithTag:108];
    [view removeFromSuperview];
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"啊哦" message:@"加载失败···" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/11/30.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "ViewController.h"
#import "HttpOperation.h"

@interface ViewController ()
@end

@implementation ViewController

UIActivityIndicatorView *activityIndicator;
NSURLRequest *urlRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

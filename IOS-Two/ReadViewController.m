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


@interface ReadViewController () <UIWebViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIWebView *webview;
@property (strong, nonatomic) UIButton *Zan;

-(IBAction)DianZan:(id)sender;


@end

@implementation ReadViewController

bool isDianZan = false;
NSUInteger No = 1;

-(void) viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
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

-(IBAction)DianZan:(id)sender
{
    if (isDianZan) {
        [self.Zan setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        isDianZan = false;
    }
    else {
        [self.Zan setImage:[UIImage imageNamed:@"Image-1"] forState:UIControlStateNormal];
        isDianZan = true;
    }
}

- (void)Forward {
    if (No == 1) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"你已经处于第一期~"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    No--;
    [self viewDidLoad];
}

- (void)Backward {
    if (No == [AppDelegate getTotalVol]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"你已经处在最新一期~"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    No++;
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 5,
                                             [[UIScreen mainScreen] bounds].size.height- 200);
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(200, 200, 200, 100)];
//    label.text = @"JAHAA";
//    [self.scrollView addSubview:label];
//
    NSString *backgroundColor;
    NSString *charactersColor;
    if ([AppDelegate getIsNight]) {
        backgroundColor = @"3C3C3C";
        charactersColor = @"D0D0D0";
        self.webview.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
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
        self.webview.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.scrollView.backgroundColor =[UIColor whiteColor];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;

    }
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"前一天" style:UIBarButtonItemStylePlain target:self action:@selector(Forward)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"后一天" style:UIBarButtonItemStylePlain target:self action:@selector(Backward)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    ReadingEntity *reading = [[ReadingEntity alloc] init];
    NSString * temp = [NSString stringWithFormat:@"Reading%d.archive" ,No];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] == nil) {
        
        NSString *data1 = @"http://localhost:8080/IosService/Reading";
        data1 = [data1 stringByAppendingString:@"?date="];
        
        data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"%d", No]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
        NSError * error = nil;
        
        NSURLResponse *response=nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&error];
        id JsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *jsonDictionary = (NSDictionary*)JsonObj;
        NSString *desContent = [[jsonDictionary valueForKey:@"article"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [reading setReadingContent:desContent];
        [reading setNo:No];
        [reading setReadingTitle:nil];
        [reading setAuthor:nil];
        [reading setRecommender:nil];
        [self saveReading:reading];
    }
    else {
        reading = [self decodeReading:No path:path];
    }
   
    NSMutableString *HTMLContent = [[NSMutableString alloc] init];
    NSString *content = [reading ReadingContent];
    [HTMLContent appendString:[NSString stringWithFormat:@"<body bgcolor=\"%@\">", backgroundColor]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章标题 --><body><p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 0px; margin-left: 15px;\">%@</p>", charactersColor, @"你别来客栈"]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div></body>", charactersColor, content]];
    CGRect mainrect = [UIScreen mainScreen].bounds;
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, mainrect.size.width, mainrect.size.height - 130)];
    self.webview.delegate = self;
    [self.webview loadHTMLString:HTMLContent baseURL:nil];
    [self.scrollView addSubview:self.webview];
    //[self.view addSubview:self.button1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    CGSize webSize = [webView sizeThatFits:CGSizeZero];
    self.webview.scrollView.contentSize =CGSizeMake([[UIScreen mainScreen] bounds].size.width,
                                                    webSize.height + 150);
    self.webview.scrollView.backgroundColor = [UIColor whiteColor];
    self.Zan = [[UIButton alloc] initWithFrame:CGRectMake(250, webSize.height + 20, 70, 20)];
    self.Zan.imageEdgeInsets = UIEdgeInsetsMake(2, -22, 0, 0);
//    self.Zan.titleEdgeInsets = UIEdgeInsetsMake(2, 20, 0, 60);
    UIImage *btnImage = [[UIImage imageNamed:@"LikeBG"] stretchableImageWithLeftCapWidth:70
                                                                            topCapHeight:2];
    [self.Zan setBackgroundImage:btnImage forState:UIControlStateNormal];
    [self.Zan setTitle:@"12" forState:UIControlStateNormal];
    [self.Zan.titleLabel setFrame:CGRectMake(280, webSize.height + 63, 40, 17)];
    self.Zan.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.Zan.titleLabel setHidden:NO];
    [self.Zan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [self.Zan setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    [self.Zan addTarget:self action:@selector(DianZan:) forControlEvents:UIControlEventTouchUpInside];
    [self.webview.scrollView addSubview:self.Zan];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"Dragging!");
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat pageWidth = [[UIScreen mainScreen] bounds].size.width;
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2;
    No = page;
    NSLog(@"%d", No);
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = pageWidth * (No - 1);
    bounds.origin.y = 70;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
//    if ((self.scrollView.contentOffset.x - )
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

//
//  ReadViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/5.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UIButton *Zan;
-(IBAction)DianZan:(id)sender;

@end

@implementation ReadViewController
bool isDianZan = false;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.Zan setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"前一天" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"后一天" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    NSDate *date= [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *data1 = @"http://localhost:8080/IosService/Reading";
    data1 = [data1 stringByAppendingString:@"?date="];
    data1 = [data1 stringByAppendingString:dateString];
    NSString *dataUTF8 = [data1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dataUTF8]];
    NSError * error = nil;
    
    NSURLResponse *response=nil;
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
      id JsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *jsonDictionary = (NSDictionary*)JsonObj;
    NSString *desContent = [[jsonDictionary valueForKey:@"article"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    self.webview.backgroundColor = [UIColor whiteColor];
    NSMutableString *HTMLContent = [[NSMutableString alloc] init];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章标题 --><p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 34px; margin-left: 15px;\">%@</p>", @"#333333", @"你别来客栈"]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div>", @"#888888", desContent]];
    
    [self.webview loadHTMLString:HTMLContent baseURL:nil];
    
    //[self.view addSubview:self.button1];
    
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

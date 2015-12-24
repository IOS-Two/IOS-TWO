//
//  QuestionViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/16.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *Content;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *data1 = @"http://localhost:8080/IosService/question";
    data1 = [data1 stringByAppendingString:@"?date=1"];
    
    //data1 = [data1 stringByAppendingString:[NSString stringWithFormat:@"%d", 1]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:data1]];
    NSError * error = nil;
    
    NSURLResponse *response=nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    if (error == nil) NSLog(@"success");
    id JsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *jsonDictionary = (NSDictionary*)JsonObj;
    NSString *desContent = [[jsonDictionary valueForKey:@"article"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.Content.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
    NSMutableString *HTMLContent = [[NSMutableString alloc] init];
    self.view.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
 
    [HTMLContent appendString:[NSString stringWithFormat:@"<body bgcolor=\"#3C3C3C\">"]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- vol --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 12px;font-family:verdana;\">%@</div>", @"#D0D0D0", @"Vol.1"]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;font-family:SimHei;\">%@</div>", @"#D0D0D0", desContent]];
    
    [self.Content loadHTMLString:HTMLContent baseURL:nil];

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

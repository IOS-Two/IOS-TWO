//
//  AboutViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/13.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "AboutViewController.h"
#import "HttpOperation.h"

@interface AboutViewController ()
@property (strong, nonatomic) UIWebView* aboutView;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aboutView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.aboutView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:AboutUrl]]];
    [self.view addSubview:self.aboutView];
    // Do any additional setup after loading the view from its nib.
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

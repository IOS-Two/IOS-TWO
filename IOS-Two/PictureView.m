//
//  PictureView.m
//  IOS-Two
//
//  Created by 江晨舟 on 16/1/21.
//  Copyright © 2016年 江晨舟. All rights reserved.
//

#import "PictureView.h"
#import "AppDelegate.h"

@interface PictureView () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView* webview;
@property (strong, nonatomic) UIButton *Zan;
@property UIColor *backgroundColor;

@end

@implementation PictureView

-(IBAction)DianZan:(id)sender
{
    [self.Zan setSelected:![self.Zan isSelected]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    // CGRect mainrect = [[UIScreen mainScreen] bounds];
    
    if (self) {
        self.webview = [[UIWebView alloc] initWithFrame:frame];
        [self addSubview:self.webview];
        self.webview.delegate = self;
    }
    
    return self;
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

-(void)ConfigurePictureContent:(PictureEntity*)picture BackC:(NSString*)backgroundColor CharC:(NSString*)
    charactersColor;{
    if ([backgroundColor isEqualToString:@"3C3C3C"]) {
        self.backgroundColor = [UIColor colorWithRed:0x3C/255.0 green:0x3C/255.0 blue:0x3C/255.0 alpha:1];
        self.webview.scrollView.backgroundColor = self.backgroundColor;
        self.webview.backgroundColor = self.backgroundColor;
        self.backgroundColor = self.backgroundColor;
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        self.webview.backgroundColor = [UIColor whiteColor];
        self.webview.scrollView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    NSString *stringImage = [self htmlForJPGImage:picture];
    NSString *title = [NSString stringWithFormat:@"Vol.%d", [picture No]];
    NSString *des = [picture PictureDes];
    NSString *HTMLTitle = [NSString stringWithFormat:@"<p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 20px; margin-left: 0px;\">%@</p>", charactersColor, title];
    NSString *HTMLContent =  [NSString stringWithFormat:@"<div style=\"line-height: 20px; margin-top: 10px; margin-left: 0px; margin-right: 15px; color: %@; font-size: 12px;\">%@</div></br>", charactersColor, des];
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
    [self.webview loadHTMLString:content baseURL:nil];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSArray *sv = [NSArray arrayWithArray:[self.webview subviews]];
    UIScrollView *webScroller = (UIScrollView *)[sv objectAtIndex:0];
    CGSize webSize = [webView sizeThatFits:CGSizeZero];
    self.webview.scrollView.contentSize =CGSizeMake([[UIScreen mainScreen] bounds].size.width,
                                                    webSize.height + 150);
    self.webview.scrollView.backgroundColor = [UIColor whiteColor];
    self.Zan = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 70, webSize.height, 70, 20)];
    self.Zan.imageEdgeInsets = UIEdgeInsetsMake(2, -22, 0, 0);
    
    UIImage *btnImage = [[UIImage imageNamed:@"LikeBG"] stretchableImageWithLeftCapWidth:70
                                                                            topCapHeight:2];
    [self.Zan setBackgroundImage:btnImage forState:UIControlStateNormal];
    [self.Zan setTitle:@"12" forState:UIControlStateNormal];
    [self.Zan.titleLabel setFrame:CGRectMake(280, webSize.height + 63, 40, 17)];
    self.Zan.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.Zan.titleLabel setHidden:NO];
    [self.Zan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.Zan setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    [self.Zan setImage:[UIImage imageNamed:@"Image-1"] forState:UIControlStateSelected];
    [self.Zan addTarget:self action:@selector(DianZan:) forControlEvents:UIControlEventTouchUpInside];
    
    webScroller.backgroundColor = self.backgroundColor;
    [self.webview.scrollView addSubview:self.Zan];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

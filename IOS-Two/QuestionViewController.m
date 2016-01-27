//
//  QuestionViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/16.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "QuestionViewController.h"
#import "AppDelegate.h"
#import "QuestionEntity.h"
#import "QuestionView.h"
#import "HttpOperation.h"
#import "SettingTableViewController.h"

@interface QuestionViewController ()
@property (strong, nonatomic) QuestionView* questionView;
@property int No;
@property BOOL NightMode;
@property NSString* Recommender;
@property BOOL isFirstTime;
@end

@implementation QuestionViewController

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

-(void) saveQuestion:(QuestionEntity *)question {
    NSString* who = [AppDelegate getRecommender];
    NSString * temp = [NSString stringWithFormat:@"Question%d%@.archive" , question.No, who];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:question toFile:path];
    if (sucess)
    {
       
    }
}

-(QuestionEntity*) decodeQuestion:(int)vol path:(NSString*)path{
    QuestionEntity *Reading = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    //    NSLog(@"Read archive");
    return Reading;
}

-(QuestionEntity*)loadQuestionContent:(int)No {
    NSString* who = [AppDelegate getRecommender];
    QuestionEntity *question = [[QuestionEntity alloc] init];
    NSString * temp = [NSString stringWithFormat:@"Question%d%@.archive" ,No, who];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] == nil) {
        question = [HttpOperation RequestQuestionContent:No];
        [self saveQuestion:question];
    }
    else {
        question = [self decodeQuestion:No path:path];
    }
    return question;
}

-(void)RightLook {
    if (self.No <= 1) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"木有更多~" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
    else {
        [UIView beginAnimations:@"Curl" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
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
        QuestionEntity* question = [self loadQuestionContent:self.No];
        CGRect mainrect = [[UIScreen mainScreen] bounds];
        [self.questionView removeFromSuperview];
        self.questionView = [[QuestionView alloc] initWithFrame:CGRectMake(0, 0, mainrect.size.width, mainrect.size.height)];
        [self.questionView ConfigureQuestionContent:question BackC:backgroundColor CharC:charactersColor];
        [self.view addSubview:self.questionView];
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
        [UIView setAnimationDuration:0.75];
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
        QuestionEntity* question = [self loadQuestionContent:self.No];
        CGRect mainrect = [[UIScreen mainScreen] bounds];
        [self.questionView removeFromSuperview];
        self.questionView = [[QuestionView alloc] initWithFrame:CGRectMake(0, 0, mainrect.size.width, mainrect.size.height)];
        [self.questionView ConfigureQuestionContent:question BackC:backgroundColor CharC:charactersColor];
        [self.view addSubview:self.questionView];
        [UIView commitAnimations];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.No = [HttpOperation RequestTotalVol];;
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"←" style:UIBarButtonItemStylePlain target:self action:@selector(LeftLook)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"→" style:UIBarButtonItemStylePlain target:self action:@selector(RightLook)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
    self.Recommender = [AppDelegate getRecommender];
    self.NightMode = [AppDelegate getIsNight];

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
    if (self.No == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"啊哦" message:@"加载失败···" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
        return;
    }
    NSString* who = [AppDelegate getRecommender];
    QuestionEntity *question = [[QuestionEntity alloc] init];
    NSString * temp = [NSString stringWithFormat:@"Question%d%@.archive" ,self.No, who];
    NSString *homePath = NSHomeDirectory();
    NSString *path = [homePath stringByAppendingPathComponent:temp];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] == nil) {
        question = [HttpOperation RequestQuestionContent:self.No];
        [self saveQuestion:question];
    }
    else {
        question = [self decodeQuestion:self.No path:path];
    }
    
    CGRect mainrect = [UIScreen mainScreen].bounds;
    self.questionView = [[QuestionView alloc] initWithFrame:CGRectMake(0, 0, mainrect.size.width, mainrect.size.height)];
    [self.questionView ConfigureQuestionContent:question BackC:backgroundColor CharC:charactersColor];
    //[self.view addSubview:self.readingView];
    [self.view addSubview:self.questionView];
    
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

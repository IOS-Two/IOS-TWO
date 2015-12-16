//
//  SettingTableViewController.m
//  IOS-Two
//
//  Created by 江晨舟 on 15/12/13.
//  Copyright © 2015年 江晨舟. All rights reserved.
//

#import "SettingTableViewController.h"
#import "AppDelegate.h"
#import "AboutViewController.h"

@interface SettingTableViewController () <UITableViewDataSource>
@property (nonatomic, strong) UISwitch * JiangOn;
@property (nonatomic, strong) UISwitch * GeOn;
@property (nonatomic, strong) UISwitch * NightSwtich;

@end

@implementation SettingTableViewController

- (void)JiangSwitch:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [self.GeOn setOn:NO animated:YES];
        [AppDelegate setWho:1];
        NSLog(@"%d", [AppDelegate instanceWho]);
    } else {
        [self.GeOn setOn:YES animated:YES];
        [AppDelegate setWho:0];
        NSLog(@"%d", [AppDelegate instanceWho]);
    }
}

- (void)GeSwitch:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [self.JiangOn setOn:NO animated:YES];
        [AppDelegate setWho:0];
        NSLog(@"%d", [AppDelegate instanceWho]);
    } else {
        [self.JiangOn setOn:YES animated:YES];
        [AppDelegate setWho:1];
        NSLog(@"%d", [AppDelegate instanceWho]);
    }
}

- (void)NightSwitchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
       
    } else {
       
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.JiangOn = [[UISwitch alloc] init];
    self.GeOn = [[UISwitch alloc] init];
    self.NightSwtich = [[UISwitch alloc] init];
    int who = [AppDelegate instanceWho];
    if (who == 0) {
        [self.JiangOn setOn:NO];
        [self.GeOn setOn:YES];
    } else {
        [self.JiangOn setOn:YES];
        [self.GeOn setOn:NO];
    }
    [self.JiangOn addTarget:self action:@selector(JiangSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.GeOn addTarget:self action:@selector(GeSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.NightSwtich addTarget:self action:@selector(NightSwitchAction:) forControlEvents:UIControlEventValueChanged];
    
    self.Items = [[NSMutableArray alloc] initWithObjects:@"葛泽凡", @"江晨舟", @"夜间模式", nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 1;
        default:
            return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"设置";
    }
    else {
        return @"关于";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger index = [indexPath row];
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        switch (index) {
            case 2: {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.textLabel.text=[self.Items objectAtIndex:indexPath.row];
                cell.accessoryView = self.NightSwtich;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                break;
            }
            case 1: {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.textLabel.text=[self.Items objectAtIndex:indexPath.row];
                cell.accessoryView = self.JiangOn;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                break;
            }
            case 0: {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.textLabel.text=[self.Items objectAtIndex:indexPath.row];
                cell.accessoryView = self.GeOn;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                break;
            }
        }
    }
    else {
        if (index == 0) {
         
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text=@"关于";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 ) {
        if ([indexPath row] == 0) {
            AboutViewController *AboutView = [[AboutViewController alloc] init];
//            UINavigationController *AboutNav = [[UINavigationController alloc] initWithRootViewController:AboutView];
            AboutView.navigationItem.title = @"关于";
            [self.navigationController pushViewController:AboutView animated:YES];
        }
    }
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

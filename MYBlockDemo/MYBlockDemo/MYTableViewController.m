//
//  MYTableViewController.m
//
//  Created by 夏宗阳 on 2016/10/10.
//  Copyright © 2016年 xiazy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYTableViewController.h"
#import "TableViewDataSource.h"

@interface MYTableViewController()

@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,weak)IBOutlet UITableView *myTableView;
@property(nonatomic,strong)TableViewDataSource *myDataSource;

@end

@implementation MYTableViewController

-(void)viewDidLoad{
    
    [self initDataArr];
    [self initDataSource];
    //注意先后顺序
    _myTableView.dataSource = _myDataSource;
}

#pragma mark---初始化数据
-(void)initDataArr{
    _dataArr = [NSArray arrayWithObjects:@"蓝色",@"绿色",@"黑色",@"白色",@"橘色", nil];
}

#pragma mark---初始化数据源
-(void)initDataSource{
    //很多宝宝想在VC（视图控制器）分离数据源委托代码，达到给给VC瘦身的效果
    //别问我为什么把自己创建的数据源对象(myDataSource)作为类的成员属性，目的是控制数据源对象的生命周期跟VC对象的生命周期一致
    //假使你把数据源对象声明成方法内的临时对象，那么会出现数据源委托协议中的方式是不会被执行的，myTableView中是不会显示任何数据的（不信你可以试试）
    //原因很简单：因为被声明为方法内部的临时数据源对象会随着方法执行完毕后而被释放，出了方法体相当于：(self.myTableView.dataSource=nil)，数据源委托协议中的方法压根没机会被执行！！！
    //TableViewDataSource *myDataSource = .......(千万别把数据源对象作为方法内部的局部对象创建)
    
    __weak typeof (self) weakSelf = self;
    _myDataSource = [[TableViewDataSource alloc]initWithNumberOfSectionsConfigBlock:^NSInteger(UITableView *tableView) {
        return 1;
    } numberOfRowsInSectionConfigBlock:^NSInteger(UITableView *tableView, NSInteger section) {
        //return [_dataArr count];//(注意避免循环引用的发生)
        return [weakSelf.dataArr count];
    } tableViewCellConfigBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"reuseId"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
        }
        //cell.textLabel.text = [_dataArr objectAtIndex:indexPath.row];//(注意避免循环引用的发生)
        cell.textLabel.text = [weakSelf.dataArr objectAtIndex:indexPath.row];
        return cell;
    }];

}

-(void)dealloc{
    NSLog(@"执行析构函数");
}
@end

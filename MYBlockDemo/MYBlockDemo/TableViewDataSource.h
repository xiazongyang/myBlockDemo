//
//  TableViewDataSource.h
//
//  Created by 夏宗阳 on 16/10/8.
//  Copyright © 2016年 xiazy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UITableViewCell *(^TableViewCellConfigBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef NSInteger (^NumberOfRowsInSectionConfigBlock)(UITableView *tableView, NSInteger section);
typedef NSInteger(^NumberOfSectionsConfigBlock)(UITableView *tableView);

@interface TableViewDataSource : NSObject<UITableViewDataSource>

    -(instancetype)initWithNumberOfSectionsConfigBlock:(NumberOfSectionsConfigBlock)numberOfSectionsConfigBlock
                      numberOfRowsInSectionConfigBlock:(NumberOfRowsInSectionConfigBlock)numberOfRowsInSectionConfigBlock
            tableViewCellConfigBlock:(TableViewCellConfigBlock)configBlock;

    -(void)clearConfigBlock;
@end

//
//  TableViewDataSource.m
//
//  Created by 夏宗阳 on 16/10/8.
//  Copyright © 2016年 xiazy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewDataSource.h"
@interface TableViewDataSource(){
    
    TableViewCellConfigBlock _cellConfigBlock;
    NumberOfSectionsConfigBlock _numberOfSectionsConfigBlock;
    NumberOfRowsInSectionConfigBlock _numberOfRowsInSectionConfigBlock;
}
@end

@implementation TableViewDataSource

-(void)clearConfigBlock{
    _cellConfigBlock = nil;
    _numberOfSectionsConfigBlock = nil;
    _numberOfSectionsConfigBlock = nil;
}

-(instancetype)initWithNumberOfSectionsConfigBlock:(NumberOfSectionsConfigBlock)numberOfSectionsConfigBlock
                  numberOfRowsInSectionConfigBlock:(NumberOfRowsInSectionConfigBlock)numberOfRowsInSectionConfigBlock
                          tableViewCellConfigBlock:(TableViewCellConfigBlock)configBlock{
    
    self = [super init];
    if (self) {
        
        _cellConfigBlock = [configBlock copy];
        _numberOfSectionsConfigBlock = [numberOfSectionsConfigBlock copy];
        _numberOfRowsInSectionConfigBlock = [numberOfRowsInSectionConfigBlock copy];
    }
    return self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //回调block
    return _numberOfRowsInSectionConfigBlock(tableView, section);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //回调block
    return _numberOfSectionsConfigBlock(tableView);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //回调block
    return _cellConfigBlock(tableView, indexPath);
}

@end

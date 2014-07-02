//
//  M80RichTableViewController.m
//  M80AttributedLabel
//
//  Created by dw_iOS on 14-7-2.
//  Copyright (c) 2014年 Netease. All rights reserved.
//

#import "M80RichTableViewController.h"

#import "M80AttributedLabel.h"

@interface M80RichItem : NSObject

// If you not setup there, Default is nil
@property (nonatomic, strong) M80AttributedLabel *attributedLabel;

// If you not setup there, Default is 0
@property (nonatomic, assign) CGFloat richItemHeight;

@end

@implementation M80RichItem

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

@interface M80TableViewCache : NSCache

@end

@implementation M80TableViewCache

- (id)init {
    self = [super init];
    if (self) {
        self.totalCostLimit = 20;
    }
    return self;
}

@end

@interface M80RichTableViewCell : UITableViewCell

- (void)congigureCellWithItem:(M80RichItem *)item atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation M80RichTableViewCell

- (void)congigureCellWithItem:(M80RichItem *)item atIndexPath:(NSIndexPath *)indexPath {
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.contentView addSubview:item.attributedLabel];
    });
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

@end

@interface M80RichTableViewController ()

@property (nonatomic, strong) M80TableViewCache *tableViewCache;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation M80RichTableViewController

- (void)refreshingDataSource {
    [self.refreshControl beginRefreshing];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        for (int i = 0; i < 30; i ++) {
            M80RichItem *richItem = [self initilzerRichLabelWithRichItemContent:@"say:[haha] [haha] [haha] [haha] [haha] [haha] [haha] [haha] Your magic is Mine. This demo is not coll! [haha] [haha] [haha] [haha] [haha] [haha]"];
            
            [dataSource addObject:richItem];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataSource = dataSource;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        });
    });
}

#pragma mark - Propertys

- (M80TableViewCache *)tableViewCache {
    if (!_tableViewCache) {
        _tableViewCache = [[M80TableViewCache alloc] init];
    }
    return _tableViewCache;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataSource;
}

#pragma mark - Life Cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshingDataSource];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(refreshingDataSource) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Rich Label Helper Method

- (M80RichItem *)initilzerRichLabelWithRichItemContent:(NSString *)richContent {
    M80RichItem *richItem = [[M80RichItem alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        M80AttributedLabel *attributedLabel = [[M80AttributedLabel alloc] initWithFrame:CGRectZero];
        attributedLabel.lineSpacing = 2;
        [attributedLabel appendImage:[UIImage imageNamed:@"avatar"
                                      ] maxSize:CGSizeMake(60, 60)
                              margin:UIEdgeInsetsZero
                           alignment:M80ImageAlignmentBottom];
        
        NSArray *components = [richContent componentsSeparatedByString:@"[haha]"];
        NSUInteger count = [components count];
        for (NSUInteger i = 0; i < count; i++) {
            [attributedLabel appendText:[components objectAtIndex:i]];
            if (i != count - 1) {
                [attributedLabel appendImage:[UIImage imageNamed:@"haha"]
                                     maxSize:CGSizeMake(15, 15)
                                      margin:UIEdgeInsetsZero
                                   alignment:M80ImageAlignmentBottom];
            }
        }
        
        // cal and frame
        CGSize defaultSize = CGSizeMake(270, MAXFLOAT);
        
        CGFloat padding = 10;
        
        CGFloat richItemHeight = [attributedLabel sizeThatFits:defaultSize].height;
        
        attributedLabel.frame = CGRectMake(10, 10, defaultSize.width, richItemHeight);
        
        // setup
        richItem.attributedLabel = attributedLabel;
        
        // all height
        richItem.richItemHeight = richItemHeight + padding * 2;
    });
    

    return richItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    M80RichTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[M80RichTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    [cell congigureCellWithItem:self.dataSource[indexPath.row] atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count) {
        M80RichItem *richItem = self.dataSource[indexPath.row];
        
        return richItem.richItemHeight;
    } else {
        return 0;
    }
}

@end

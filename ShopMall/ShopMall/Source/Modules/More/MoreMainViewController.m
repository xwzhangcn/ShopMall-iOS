//
//  MoreMainViewController.m
//  ShopMall
//
//  Created by KingsleyYau on 14-1-15.
//  Copyright (c) 2014年 KingsleyYau. All rights reserved.
//

#import "MoreMainViewController.h"

#import "CenteralDetailTextTableViewCell.h"
#import "MapDataDownloadManager.h"

typedef enum {
    RowTypeAbout,
    RowTypeVersion,
    RowTypePhone,
    RowTypeLink,
    RowTypeMapData,
    RowTypeClean,
} RowType;

@interface MoreMainViewController () <MapDownloadManagerDelegate>
@property (nonatomic, strong) NSArray *tableViewArray;
@property (nonatomic, retain) MapDataDownloadManager *mapDataDownloadManager;
@end

@implementation MoreMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapDataDownloadManager = [[MapDataDownloadManager alloc] init];
    self.mapDataDownloadManager.delegate = self;
    
    self.tableView.backgroundView = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadData:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 界面逻辑
- (void)setupNavigationBar {
    [super setupNavigationBar];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text =  @"更多";
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
#pragma mark - 数据逻辑
- (void)reloadData:(BOOL)isReloadView {
    // 数据填充
    // 主tableView
    NSMutableArray *array = [NSMutableArray array];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    CGSize viewSize;
    NSValue *rowSize;
    
    // 关于
    dictionary = [NSMutableDictionary dictionary];
    viewSize = CGSizeMake(_tableView.frame.size.width, [CenteralDetailTextTableViewCell cellHeight:_tableView detailString:@"Shopla的成立年份，公司背景，成立目标和合作伙伴等。其他简介有待填充，让介绍来得更猛烈些吧。"]);
    rowSize = [NSValue valueWithCGSize:viewSize];
    [dictionary setValue:rowSize forKey:ROW_SIZE];
    [dictionary setValue:[NSNumber numberWithInteger:RowTypeAbout] forKey:ROW_TYPE];
    [array addObject:dictionary];
    
    // 版本
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString *version =[infoDict objectForKey:@"CFBundleVersion"];
    dictionary = [NSMutableDictionary dictionary];
    viewSize = CGSizeMake(_tableView.frame.size.width, [CenteralDetailTextTableViewCell cellHeight:_tableView detailString:[NSString stringWithFormat:@"软件版本：%@", version]]);
    rowSize = [NSValue valueWithCGSize:viewSize];
    [dictionary setValue:rowSize forKey:ROW_SIZE];
    [dictionary setValue:[NSNumber numberWithInteger:RowTypeVersion] forKey:ROW_TYPE];
    [array addObject:dictionary];
    
    // 电话
    dictionary = [NSMutableDictionary dictionary];
    viewSize = CGSizeMake(_tableView.frame.size.width, [CenteralDetailTextTableViewCell cellHeight:_tableView detailString:@"客服电话：020-88888888"]);
    rowSize = [NSValue valueWithCGSize:viewSize];
    [dictionary setValue:rowSize forKey:ROW_SIZE];
    [dictionary setValue:[NSNumber numberWithInteger:RowTypePhone] forKey:ROW_TYPE];
    [array addObject:dictionary];
    
    // 网址
    dictionary = [NSMutableDictionary dictionary];
    viewSize = CGSizeMake(_tableView.frame.size.width, [CenteralDetailTextTableViewCell cellHeight:_tableView detailString:@"网址：www.shopla.com"]);
    rowSize = [NSValue valueWithCGSize:viewSize];
    [dictionary setValue:rowSize forKey:ROW_SIZE];
    [dictionary setValue:[NSNumber numberWithInteger:RowTypeLink] forKey:ROW_TYPE];
    [array addObject:dictionary];
    
    // 下载离线地图
    dictionary = [NSMutableDictionary dictionary];
    viewSize = CGSizeMake(_tableView.frame.size.width, [CenteralDetailTextTableViewCell cellHeight:_tableView detailString:@"下载港澳离线地图"]);
    rowSize = [NSValue valueWithCGSize:viewSize];
    [dictionary setValue:rowSize forKey:ROW_SIZE];
    [dictionary setValue:[NSNumber numberWithInteger:RowTypeMapData] forKey:ROW_TYPE];
    [array addObject:dictionary];
    
    // 清除缓存
    dictionary = [NSMutableDictionary dictionary];
    viewSize = CGSizeMake(_tableView.frame.size.width, [CenteralDetailTextTableViewCell cellHeight:_tableView detailString:@"清除缓存"]);
    rowSize = [NSValue valueWithCGSize:viewSize];
    [dictionary setValue:rowSize forKey:ROW_SIZE];
    [dictionary setValue:[NSNumber numberWithInteger:RowTypeClean] forKey:ROW_TYPE];
    [array addObject:dictionary];
    
    self.tableViewArray = array;
    
    if(isReloadView) {
        [self.tableView reloadData];
    }
}
#pragma mark - 列表界面回调 (UITableViewDataSource / UITableViewDelegate)
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int count = 0;
    if([tableView isEqual:self.tableView]) {
        // 主tableview
        count = 1;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    if([tableView isEqual:self.tableView]) {
        // 主tableview
        number = self.tableViewArray.count;
    }
	return number;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if([tableView isEqual:self.tableView]) {
        // 主tableview
        NSDictionary *dictionarry = [self.tableViewArray objectAtIndex:indexPath.row];
        CGSize viewSize;
        NSValue *value = [dictionarry valueForKey:ROW_SIZE];
        [value getValue:&viewSize];
        height = viewSize.height;
    }
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *result = nil;
    
    if([tableView isEqual:self.tableView]) {
        // 主tableview
        NSDictionary *dictionarry = [self.tableViewArray objectAtIndex:indexPath.row];
        
        // TODO:大小
        CGSize viewSize;
        NSValue *value = [dictionarry valueForKey:ROW_SIZE];
        [value getValue:&viewSize];
        
        CenteralDetailTextTableViewCell *cell = [CenteralDetailTextTableViewCell getUITableViewCell:tableView];
        result = cell;
        cell.backgroundColor = [UIColor whiteColor];
        
        // TODO:类型
        RowType type = (RowType)[[dictionarry valueForKey:ROW_TYPE] intValue];
        switch (type) {
            case RowTypeAbout:{
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.detailLabel.numberOfLines = 0;
                cell.detailLabel.text = @"Shopla的成立年份，公司背景，成立目标和合作伙伴等。其他简介有待填充，让介绍来得更猛烈些吧。";
            }break;
            case RowTypeVersion:{
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
                NSString *version =[infoDict objectForKey:@"CFBundleVersion"];
                cell.detailLabel.numberOfLines = 1;
                cell.detailLabel.text = [NSString stringWithFormat:@"软件版本：%@", version];
            }break;
            case RowTypePhone:{
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.detailLabel.numberOfLines = 1;
                cell.detailLabel.text = @"客服电话：020-88888888";
            }break;
            case RowTypeLink:{
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.detailLabel.numberOfLines = 1;
                cell.detailLabel.text = @"网址：www.shopla.com";
            }break;
            case RowTypeMapData:{
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.detailLabel.numberOfLines = 1;
                
                NSString *stringText = @"";
                if([self.mapDataDownloadManager isDownloadAlready]) {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    stringText = @"下载港澳离线地图[已下载]";
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    stringText = @"下载港澳离线地图";
                }
                
                cell.detailLabel.text = stringText;
                self.mapDownloadLabel = cell.detailLabel;
            }break;
            case RowTypeClean:{
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.detailLabel.numberOfLines = 1;
                cell.detailLabel.text = @"清除缓存";
            }break;
            default:break;
        }
    }
    return result;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([tableView isEqual:self.tableView]) {
        // 主tableview
        NSDictionary *dictionarry = [self.tableViewArray objectAtIndex:indexPath.row];
    
        // TODO:类型
        RowType type = (RowType)[[dictionarry valueForKey:ROW_TYPE] intValue];
        switch (type) {
            case RowTypeAbout:{
            }break;
            case RowTypeVersion:{
            }break;
            case RowTypePhone:{
                if(![UIDevice canDail]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的设备不能拨号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                else {
                    NSString *stringPhone = [NSString stringWithFormat:@"tel://%@", @"020-88888888"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringPhone]];
                }
            }break;
            case RowTypeLink:{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.shopla.com"]];
            }break;
            case RowTypeMapData:{
                if(![self.mapDataDownloadManager isDownloadAlready]) {
                    [self.mapDataDownloadManager startDownload];
                }
            }break;
            case RowTypeClean:{
                [ShopDataManager clearDataBase];
            }break;
            default:break;
        }
    }
}
#pragma mark 离线地图下载回调
- (void)downloadFinish:(MapDataDownloadManager*)mapDownloadManager {
    [self reloadData:YES];
}
- (void)downloadFail:(MapDataDownloadManager*)mapDownloadManager error:(NSString*)error {
    // 弹出提示
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"下载失败,请重新下载"/*LocationError*/ delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [self reloadData:YES];
}
- (void)downloadProcess:(MapDataDownloadManager*)mapeDownloadManager processed:(NSInteger)processed total:(NSInteger)total {
    self.mapDownloadLabel.text = [NSString stringWithFormat:@"下载港澳离线地图[已经下载%d%%]", (NSInteger)(100 * processed / total)];
    [self.mapDownloadLabel sizeToFit];
}
@end

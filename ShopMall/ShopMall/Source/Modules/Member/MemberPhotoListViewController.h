//
//  MemberPhotoListViewController.h
//  ShopMall
//
//  Created by KingsleyYau on 14-1-6.
//  Copyright (c) 2014年 KingsleyYau. All rights reserved.
//

#import "BaseViewController.h"
#import "PhotoTableView.h"
@interface MemberPhotoListViewController : BaseViewController
@property (nonatomic, weak) IBOutlet PhotoTableView *tableView;
@property (nonatomic, strong) Shop *item;
@end

//
//  VideoViewController.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoModel.h"
#import "VideoCell.h"

#import "WMPlayer.h"

@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,WMPlayerDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *videoModelArray;
@property (strong, nonatomic) NSMutableDictionary *heights;

@property (nonatomic, strong)  WMPlayer *wmPlayer;
@property (nonatomic, assign)  NSIndexPath *currentIndexPath;
@property (nonatomic,retain) VideoCell *currentCell;
@end



@implementation VideoViewController

- (NSMutableArray *)videoModelArray
{
    if (!_videoModelArray) {
        _videoModelArray = [NSMutableArray array];
    }
    return _videoModelArray;
}

- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatas];
    [self setupTableView];
    
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    //关闭通知
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeTheVideo:)
                                                 name:@"closeTheVideo"
                                               object:nil
     ];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-40-44)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark - 加载shuju
- (void)loadDatas
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shipin" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"json = %@",json);
        
        NSDictionary *datas = json[@"datas"];
        
        NSArray *listArray = datas[@"article_list"];
        
        for (NSDictionary *dict in listArray) {
            VideoModel *model = [VideoModel initWithDic:dict];
            [self.videoModelArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
   

}

#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [VideoCell cellWithTableView:tableView];
    cell.model = self.videoModelArray[indexPath.row];
    CGFloat tmpHeight = [cell cellHeight];
    [self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
    [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    cell.playBtn.tag = indexPath.row;
    
    if (self.wmPlayer&&self.wmPlayer.superview) {
        if (indexPath.row==_currentIndexPath.row) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        }
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:_currentIndexPath]) {//复用
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.wmPlayer]) {
                self.wmPlayer.hidden = NO;
                
            }else{
                self.wmPlayer.hidden = YES;
            }
        }else{
            if ([cell.subviews containsObject:self.wmPlayer]) {
                [cell addSubview:self.wmPlayer];
                
                [self.wmPlayer play];
                self.wmPlayer.hidden = NO;
            }
            
        }
    }


    
    return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.heights[@(indexPath.row)] doubleValue];
}


#pragma mark - 通知
//播放完成通知
- (void)videoDidFinished:(NSNotification *)notice{
    VideoCell *currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [_wmPlayer removeFromSuperview];
}
//播放完成通知
- (void)fullScreenBtnClick:(NSNotification *)notice{
    
}
//关闭通知
-(void)closeTheVideo:(NSNotification *)obj{
    VideoCell *currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    [self prefersStatusBarHidden];
    
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - 内部方法
-(void)releaseWMPlayer{
    [self.wmPlayer pause];
    
    
    [self.wmPlayer removeFromSuperview];
    [self.wmPlayer.playerLayer removeFromSuperlayer];
    [self.wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    self.wmPlayer.player = nil;
    self.wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用self.wmPlayer中的dealloc方法
    [self.wmPlayer.autoDismissTimer invalidate];
    self.wmPlayer.autoDismissTimer = nil;
    
    self.wmPlayer.playOrPauseBtn = nil;
    self.wmPlayer.playerLayer = nil;
    self.wmPlayer = nil;
}

-(void)startPlayVideo:(UIButton *)sender{
    _currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
//        self.currentCell = (VideoCell *)sender.superview.superview.superview;
        self.currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndexPath.row inSection:0]];
        
    }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
        self.currentCell = (VideoCell *)sender.superview.superview.subviews;
    }
    VideoModel *model = [_videoModelArray objectAtIndex:sender.tag];
    
    if (self.wmPlayer) {
        [self releaseWMPlayer];
        self.wmPlayer = [[WMPlayer alloc]init];
        self.wmPlayer.delegate = self;
        self.wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        self.wmPlayer.URLString = model.article_video;
        self.wmPlayer.titleLabel.text = model.article_title;
    }else{
        self.wmPlayer = [[WMPlayer alloc]init];
        self.wmPlayer.delegate = self;
        self.wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        self.wmPlayer.URLString = model.article_video;
        self.wmPlayer.titleLabel.text = model.article_title;
    }
//    self.wmPlayer.frame = CGRectMake(0, 200, ScreenWidth, 200);
//    [self.view addSubview:self.wmPlayer];
    
    NSLog(@"----%@",NSStringFromCGRect(self.currentCell.frame));
//    self.wmPlayer.frame = self.currentCell.coverView.frame;
    [self.currentCell addSubview:self.wmPlayer];
    [self.currentCell bringSubviewToFront:self.wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.currentCell).with.offset(0);
        make.left.equalTo(self.currentCell).with.offset(0);
        make.right.equalTo(self.currentCell).with.offset(0);
        make.height.equalTo(@(self.currentCell.coverView.frame.size.height));
    }];
    NSLog(@"----%@",NSStringFromCGRect(self.wmPlayer.frame));
    [self.wmPlayer play];
//    [self.tableView reloadData];
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if(scrollView ==self.tableView){
//        if (self.wmPlayer==nil) {
//            return;
//        }
//        
//        if (self.wmPlayer.superview) {
//            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:_currentIndexPath];
//            CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
//            if (rectInSuperview.origin.y<-self.currentCell.coverView.frame.size.height||rectInSuperview.origin.y>ScreenHeight-64-44) {//往上拖动
//                
//                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.wmPlayer]&&isSmallScreen) {
//                    isSmallScreen = YES;
//                }else{
//                    //放widow上,小屏显示
//                    [self toSmallScreen];
//                }
//                
//            }else{
//                if ([self.currentCell.backgroundIV.subviews containsObject:wmPlayer]) {
//                    
//                }else{
//                    [self toCell];
//                }
//            }
//        }
//        
//    }
//}

-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self releaseWMPlayer];
}
@end

//
//  AppHeader.h
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#ifndef AppHeader_h
#define AppHeader_h


#endif /* AppHeader_h */

#import "Masonry.h"
#import "UIView+AICategory.h"
#import "UIBarButtonItem+AICategory.h"
#import "SVProgressHUD.h"

//DEBUG 模式下打印日志
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define ThemeColor RGB(230, 198, 168)
#define RandomColor RGB((arc4random() % 256),(arc4random() % 256),(arc4random() % 256))

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

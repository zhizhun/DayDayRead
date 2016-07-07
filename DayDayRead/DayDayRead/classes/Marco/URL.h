//
//  URL.h
//  DayDayRead
//
//  Created by 王志准 on 16/6/24.
//  Copyright © 2016年 王志准. All rights reserved.
//

#ifndef URL_h
#define URL_h

//游戏列表接口：
#define GAME_LIST_URL @"http://api.zhuishushenqi.com/game/h5?platform=ios&start=0&limit=30"
//动画列表接口：
#define COMIC_LIST_URL @"http://mhjk.1391.com/comic/bigbooklist"
//大家都在搜接口
#define SEARCH_LIST_URL @"http://api.zhuishushenqi.com/book/hot-word"
//搜索基地址
#define QUERY_LIST_URL @"http://api.zhuishushenqi.com/book/fuzzy-search?query="
//书籍基地址
#define B00K_ROOT @"http://api.zhuishushenqi.com"

// 排行榜男：
//追书最热榜Top100周榜接口
#define HOT_WEEK_URL @"http://api.zhuishushenqi.com/ranking/54d42d92321052167dfb75e3"
//追书最热榜top100月榜接口：
#define HOT_MOUTH_URL @"http://api.zhuishushenqi.com/ranking/564d820bc319238a644fb408"
//追书最热榜top100总榜接口：
#define HOT_ALL_URL @"http://api.zhuishushenqi.com/ranking/564d8494fe996c25652644d2"

//读者留存率top100周榜接口:
#define REMAIN_WEEK_URL @"http://api.zhuishushenqi.com/ranking/564547c694f1c6a144ec979b"
//读者留存率top100月榜接口：
#define REMAIN_MOUTH_URL @"http://api.zhuishushenqi.com/ranking/564d898f59fd983667a5e3fa"
//读者留存率top100总榜接口：
#define REMAIN_ALL_URL @"http://api.zhuishushenqi.com/ranking/564d8a004a15bb8369d9e28d"

//追书完结榜top100周榜接口：
#define END_WEEK_URL @"http://api.zhuishushenqi.com/ranking/564eb878efe5b8e745508fde"
//追书完结榜top100月榜接口：
#define END_MOUTH_URL @"http://api.zhuishushenqi.com/ranking/564eb12c3edb8b45511139ff"
//追书完结榜top100总榜接口：
#define END_ALL_URL @"http://api.zhuishushenqi.com/ranking/564eea0b731ade4d6c509493"

//本周潜力榜周榜接口：
#define POTEN_WEEK_URL @"http://api.zhuishushenqi.com/ranking/54d42e72d9de23382e6877fb"
//月榜接口：
#define POTEN_MOUTH_URL @"http://api.zhuishushenqi.com/ranking/564eee3ea82e3ada6f14b195"
//总榜接口：
#define POTEN_ALL_URL @"http://api.zhuishushenqi.com/ranking/564eeeabed24953671f2a577"

//排行榜女：
//追书最热榜Top100周榜接口：
#define WHOT_WEEK_URL @"http://api.zhuishushenqi.com/ranking/54d43437d47d13ff21cad58b"
//追书最热榜top100月榜接口：
#define WHOT_MOUTH_URL @"http://api.zhuishushenqi.com/ranking/564d853484665f97662d0810"
//追书最热榜top100总榜接口：
#define WHOT_ALL_URL @"http://api.zhuishushenqi.com/ranking/564d85b6dd2bd1ec660ea8e2"

//读者留存率top100周榜接口：
#define WREMAIN_WEEK_URL @"http://api.zhuishushenqi.com/ranking/5645482405b052fe70aeb1b5"
//读者留存率top100月榜接口：
#define WREMAIN_MOUTH_URL @"http://api.zhuishushenqi.com/ranking/564d8b6b36d10ccd6951195d"
//读者留存率top100总榜接口：
#define WREMAIN_ALL_URL @"http://api.zhuishushenqi.com/ranking/564d8c37752bcca16a976168"

//追书完结榜top100周榜接口：
#define WEND_WEEK_URL @"http://api.zhuishushenqi.com/ranking/564eb8a9cf77e9b25056162d"
//追书完结榜top100月榜接口：
#define WEND_MOUTH_URL @"http://api.zhuishushenqi.com/ranking/564ee8ec146f8f1739777740"
//追书完结榜top100月榜接口：
#define WEND_ALL_URL @"http://api.zhuishushenqi.com/ranking/564eeae6c3345baa6bf06e38"
//本周潜力榜周榜接口：
#define WPOTEN_WEEK_URL @"http://api.zhuishushenqi.com/ranking/54d43709fd6ec9ae04184aa5"
//月榜接口：
#define WPOTEN_MOUTH_URL @"http://api.zhuishushenqi.com/ranking/564eee77e3a44c9f0e5fd7ae"
//总榜接口：
#define WPOTEN_ALL_URL @"http://api.zhuishushenqi.com/ranking/564eeeca5e6ba6ae074f10ec"


//书单：(collectionView显示书单分类)
//基地址：
//全部书单本周最热接口：
#define BOOK_ALL_WEEK_URL @"http://api.zhuishushenqi.com/book-list?sort=collectorCount&duration=last-seven-days&start=0"
//数字改变可刷新，每次刷新start+20

//全部书单最新发布接口：
#define BOOK_ALL_NEW_URL @"http://api.zhuishushenqi.com/book-list?sort=created&duration=all&start=0"
//全部书单最多收藏接口:  http://api.zhuishushenqi.com/book-list?sort=collectorCount&duration=all&start=0
#define BOOK_ALL_MOST_URL @"http://api.zhuishushenqi.com/book-list?sort=collectorCount&duration=all&start=0"
//性别分类拼接：&gender=male或者&gender=female
//其他分类拼接：&tag=中文utf8编码


// 听书专区
// 都市言情
#define LISTEN_CITY_URL @"http://api.ximalaya.com/openapi-gateway-app/albums/list?access_token=cacf1fafcf2d8eaa2144018e7a3ea0c8&app_key=7c835036990c98e4bd500b10efb54616&client_os_type=1&device=iPhone&device_id=9FF15C3A-3488-4439-B292-CC7FA998D449&pack_id=com.ZhuiShu.XiaoShuo&sdk_version=2.3&calc_dimension=2&category_id=3&count=20&page=1&tag_name=%E6%B5%AA%E6%BC%AB%E8%A8%80%E6%83%85&type=0&sig=4f879bcbf276334511c0a5b4b98a0d16&"

// 古装言情
#define LISTEN_ANCIENT_URL @"http://api.ximalaya.com/openapi-gateway-app/albums/list?access_token=cacf1fafcf2d8eaa2144018e7a3ea0c8&app_key=7c835036990c98e4bd500b10efb54616&client_os_type=1&device=iPhone&device_id=9FF15C3A-3488-4439-B292-CC7FA998D449&pack_id=com.ZhuiShu.XiaoShuo&sdk_version=2.3&calc_dimension=3&category_id=3&count=20&page=1&tag_name=%E7%A9%BF%E8%B6%8A%E6%9E%B6%E7%A9%BA&type=0&sig=a23c4359e658769fab155712ddbd8019&"

// 玄幻仙侠
#define LISTEN_MAJIC_URL @"http://api.ximalaya.com/openapi-gateway-app/albums/list?access_token=cacf1fafcf2d8eaa2144018e7a3ea0c8&app_key=7c835036990c98e4bd500b10efb54616&client_os_type=1&device=iPhone&device_id=9FF15C3A-3488-4439-B292-CC7FA998D449&pack_id=com.ZhuiShu.XiaoShuo&sdk_version=2.3&calc_dimension=3&category_id=3&count=20&page=1&tag_name=%E7%8E%84%E5%B9%BB%E5%A5%87%E5%B9%BB&type=0&sig=f234fa14694079d8bc7c59ed72e831ad&"

// 科幻惊悚
#define LISTEN_FICTION_URL @"http://api.ximalaya.com/openapi-gateway-app/albums/list?access_token=cacf1fafcf2d8eaa2144018e7a3ea0c8&app_key=7c835036990c98e4bd500b10efb54616&client_os_type=1&device=iPhone&device_id=9FF15C3A-3488-4439-B292-CC7FA998D449&pack_id=com.ZhuiShu.XiaoShuo&sdk_version=2.3&calc_dimension=3&category_id=3&count=20&page=1&tag_name=%E7%A7%91%E5%B9%BB%E6%B8%B8%E6%88%8F&type=0&sig=fee035923a53b635723544e72a495933&"

// 出版
#define LISTEN_PUBLISH_URL @"http://api.ximalaya.com/openapi-gateway-app/albums/list?access_token=cacf1fafcf2d8eaa2144018e7a3ea0c8&app_key=7c835036990c98e4bd500b10efb54616&client_os_type=1&device=iPhone&device_id=9FF15C3A-3488-4439-B292-CC7FA998D449&pack_id=com.ZhuiShu.XiaoShuo&sdk_version=2.3&calc_dimension=3&category_id=3&count=20&page=1&tag_name=%E7%A3%A8%E9%93%81%E9%98%85%E8%AF%BB&type=0&sig=e99e50e4a62f423596897244c304246c&"


// 书评区
#define REVIEW_ALL_URL @"http://api.zhuishushenqi.com/post/review?duration=all&sort=updated&type=all&start=0&limit=20"

//注册URL

#define USER_REGISTER_URL @"http://162.211.125.85/douban/user.php/DRegister"
//登录URL

#define USER_LOGIN_URL @"http://162.211.125.85/douban/user.php/DLogin"

#endif /* URL_h */

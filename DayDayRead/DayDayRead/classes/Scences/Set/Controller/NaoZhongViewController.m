//
//  NaoZhongViewController.m
//  NAO中
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "NaoZhongViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>

#define kW self.view.frame.size.width
#define kH self.view.frame.size.height

@interface NaoZhongViewController ()<AVAudioPlayerDelegate>


{
    NSTimer * _timer;  //定时器
    AVAudioPlayer * _player;
    
    AVAudioPlayer *avAudioPlayer;   //播放器player
    UIProgressView *progressV;      //播放进度
    UISlider *volumeSlider;         //声音控制
}

@property(nonatomic, weak)UIDatePicker * picker;
@property(nonatomic,weak) UILabel * label;
@property(nonatomic,assign)NSInteger lt;
@property(nonatomic,weak) UIButton * button;

@end

@implementation NaoZhongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"闹钟";
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self _loadView];
    
    [self initView];
    
}

- (void)initView {
    
    
}

- (void) _loadView
{
    //view
 
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(10,0 , kW, kH)];
   
    UIDatePicker * picker=[[UIDatePicker alloc]init];
    picker.backgroundColor=[UIColor colorWithRed:0.1 green:0.1 blue:0.5 alpha:0.1];
    [view addSubview:picker];
    _picker=picker;
    [self.view addSubview:view];
    
    
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(5, 220, kW-10, 120)];
        label.backgroundColor=[UIColor colorWithRed:0.2 green:0.2 blue:0.6 alpha:0.2];
    label.text=@"00:00:00";
    label.textAlignment=NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:nil size:60]];
    _label=label;
    [view addSubview:label];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 230, kW-40, 40)];


    label1.text=@"闹钟还剩时间：";
    [view addSubview: label1];
    
        UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.label.frame)+10, 100, 50)];
                           button.backgroundColor=[UIColor colorWithRed:0.1 green:0.5 blue:0.8 alpha:0.2];
                         //    button.center=self.view.center;
                         [button setTitle:@"确定" forState:UIControlStateNormal];
                         [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                         [button addTarget:self action:@selector(countTime:) forControlEvents:UIControlEventTouchUpInside];
                         
                         [button setTitle:@"确定" forState:UIControlStateSelected];
                         [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
                         
                         _button=button;
                         [view addSubview:button];
    
    //初始化三个button
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playButton setFrame:CGRectMake(0, CGRectGetMaxY(self.button.frame)+10, 60, 40)];
    
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:playButton];
    
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pauseButton setFrame:CGRectMake(70, CGRectGetMaxY(self.button.frame)+10, 60, 40)];


    [pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
    
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stopButton setFrame:CGRectMake(140, CGRectGetMaxY(self.button.frame)+10, 60, 40)];


    [stopButton setTitle:@"stop" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
    //从budle路径下读取音频文件　　轻音乐 - 萨克斯回家 这个文件名是你的歌曲名字,mp3是你的音频格式
    NSString *string = [[NSBundle mainBundle] pathForResource:@"林俊杰-背对背拥抱" ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    avAudioPlayer.delegate = self;
    
    //设置初始音量大小
    avAudioPlayer.volume = 1;
    //设置最小音量
    volumeSlider.minimumValue = 0.0f;
    //设置最大音量
    volumeSlider.maximumValue = 10.0f;
    //初始化音量为多少
    volumeSlider.value = 5.0f;
    
    //设置音乐播放次数  -1为一直循环
    avAudioPlayer.numberOfLoops = -1;
    
    //预播放
//    [avAudioPlayer prepareToPlay];


    
}
//播放
- (void)play
{
    [avAudioPlayer play];
}
//暂停
- (void)pause
{
    [avAudioPlayer pause];
}
//停止
- (void)stop
{
    avAudioPlayer.currentTime = 0;  //当前播放时间设置为0
    [avAudioPlayer stop];
}




- (void) countTime:(UIButton *) button
{
    
    button.selected=!button.selected;
   
    
    //格式
    NSDateFormatter * format1=[[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"hh"];
    NSDateFormatter * format2=[[NSDateFormatter alloc]init];
    [format2 setDateFormat:@"mm"];
    
    //获取小时
    NSString * str1=[format1 stringFromDate:_picker.date];
    NSInteger temp1=[str1 integerValue];
    
    NSDate * date3=[[NSDate alloc]init];
    NSString * str3=[format1 stringFromDate:date3];
    NSInteger temp3=[str3 integerValue];
    
    //获取分钟
    NSString * str2=[format2 stringFromDate:_picker.date];
    NSInteger temp2=[str2 integerValue];
    
    NSDate * date4=[[NSDate alloc]init];
    NSString * str4=[format2 stringFromDate:date4];
    NSInteger temp4=[str4 integerValue];
    NSLog(@"闹钟时长：%li 秒",(temp1-temp3)*60*60+(temp2-temp4)*60);
    //--------------------------------------------------------------------
    NSInteger lt=(temp1-temp3)*60*60+(temp2-temp4)*60;
    _lt=lt;
    
    if (_lt>0 && _button.selected)
    {
        NSString * strT=[NSString stringWithFormat:@"%02i:%02i:%02i",(int)lt/3600%60,(int)lt/60%60,(int)lt%60];
        _label.text=strT;
    }
    else
    {
        NSLog(@"请重新设置时间....");
        _label.text=@"00:00:00";
        return;
    }
    
    
    if(_timer==nil)
    {
       
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(runAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        NSLog(@"开始倒计时.....");
    }
    else
    {
        [_timer invalidate];   //定时器失效
    }
    
    
}



- (void) runAction
{
    _lt--;
    if (_lt==0)
    {
        [_timer invalidate];//让定时器失效
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"关闭闹钟" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alert addButtonWithTitle:@"确定"];
        alert.delegate=self;
        //        [alert clickedButtonAtIndex:0];
        [alert show];
        //提示框弹出的同时，开始响闹钟
        NSString * path=[[NSBundle mainBundle]pathForResource:@"情非得已.mp3" ofType:nil];
        NSURL * url=[NSURL fileURLWithPath:path];
        
        NSError * error;
        _player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _player.numberOfLoops=-1;    //无限循环  =0 一遍   =1 两遍    =2 三遍     =负数  单曲循环
        _player.volume=2;          //音量
        [_player prepareToPlay];    //准备工作
        //[_player stop];       //卡一下
        [_player play];    //开始播放
        
        // 1 注册通知
        
        UIApplication * app=[UIApplication sharedApplication];
        NSArray * array=[app scheduledLocalNotifications];
        NSLog(@"%ld",array.count);
        
        for (UILocalNotification * local in array) {
            NSDictionary * dic= local.userInfo;
            if ([dic[@"name"] isEqual:@"zhangsan"]) {
                //删除指定的通知
//                [app cancelLocalNotification:local];
            }
        }
        
        //删除所有通知
            [app cancelAllLocalNotifications];
        //
        
        //判断是否已经注册通知
        UIUserNotificationSettings* setting= [app currentUserNotificationSettings];
        //如果setting.types==UIUserNotificationTypeNone 需要注册通知
        if(setting.types==UIUserNotificationTypeNone){
            
            UIUserNotificationSettings* newSetting= [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
            [app registerUserNotificationSettings:newSetting];
            
        }else{
            
            [self addLocalNotification];
        }
        
    }
    
    NSString * str=[NSString stringWithFormat:@"%02d:%02d:%02d",(int)(self.lt)/3600%24,(int)(self.lt)/60%60,(int)(self.lt)%60];
    _label.text=str;
    
}



#pragma mark - 增加本地通知
- (void) addLocalNotification{
    
    UILocalNotification * notification=[[UILocalNotification alloc] init];
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:0];
    notification.alertBody=@"闹钟响了。。。。。。";
    notification.alertAction=@"打开闹钟";
    notification.repeatInterval=NSCalendarUnitSecond;
    notification.applicationIconBadgeNumber=1;
    notification.userInfo=@{@"name":@"zhangsan"};
    notification.soundName=@"情非得已.mp3";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}


//注册完成后调用
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    [self addLocalNotification];
    
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    NSLog(@"+========我接受到通知了");
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_player stop];
    
}

@end
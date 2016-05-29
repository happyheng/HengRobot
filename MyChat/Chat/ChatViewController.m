//
//  ChatViewController.m
//  小恒机器人
//
//  Created by 刘恒 on 15/10/2.
//  Copyright © 2015年 cn.com.hibor. All rights reserved.
//

#import "ChatViewController.h"
#import "BaseChatTableViewCell.h"
#import "OtherChatTableViewCell.h"
#import "OwnChatTableViewCell.h"
#import "BaseCellDataType.h"
#import "AFNetworking.h"

//图灵机器人基础请求URL
#define tuLingBaseUrl @"http://www.tuling123.com/openapi/api"

//图灵机器人我的Key
#define tuLingKey @"6cc5357b84ce5bf24a784370fb491557"

#define otherChatTableViewCell NSStringFromClass([OtherChatTableViewCell class])

#define ownChatTableViewCell NSStringFromClass([OwnChatTableViewCell class])

@interface ChatViewController (){
    
    //保存着其聊天信息的Array
    NSMutableArray *chatDataArray;
    
    //由语音读出来的string
    NSMutableString *voiceString;
    
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化数据源
    chatDataArray = [[NSMutableArray alloc] init];
    voiceString = [[NSMutableString alloc] initWithString:@""];
    
    
    //为自己的TableView注册cell
    [self.chatTableView registerNib:[UINib nibWithNibName:otherChatTableViewCell bundle:nil] forCellReuseIdentifier: otherChatTableViewCell];
    [self.chatTableView registerNib:[UINib nibWithNibName:ownChatTableViewCell bundle:nil] forCellReuseIdentifier: ownChatTableViewCell];
    
    
    UIImageView *chatTableViewBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chatTableViewBackImage.jpg"]];
    
    [self.chatTableView setBackgroundView:chatTableViewBackImageView];
    
    self.chatTableView.dataSource = self;
    self.chatTableView.delegate = self;
    
    
    //刚开始添加一条问候信息
    BaseCellDataType *cellDataType = [[BaseCellDataType alloc] initWithChatString:@"您好,我是小恒机器人,很高兴为您服务。" andIsOwn:NO];
    [chatDataArray addObject:cellDataType];
    
    
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    
    //初始化语音听写对象
    [self initRecognizer];
    
    //设置voiceButton的代理
    self.voiceButton.buttonTouchDelegate = self;
    
}

/**
 设置识别参数
 ****/
-(void)initRecognizer{
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    _iFlySpeechRecognizer.delegate = self;
    
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    
    
}


/**
 发送按钮的点击事件
 */
- (IBAction)sendButtonClicked:(id)sender {
    
    NSString *chatString = self.editTextField.text;
    
    if (chatString!=nil&&![chatString isEqualToString:@""]) {
        
        //新增一条我的聊天信息
        [self addChatMessageWithChatString:chatString andIsOwn:YES];
        
        //清空输入框
        self.editTextField.text = @"";
        
        //调用此方法自动访问接口
        [self getMessageFromInterfaceAndResponceWithQuestion:chatString];
        
    }
    
    [self.view endEditing:YES];
    
}

/*
 根据问题向接口回答.
 
 请求成功，返回信息。请求失败，说明情况。
 
 图灵机器人接口只支持http的get请求
 */
-(void) getMessageFromInterfaceAndResponceWithQuestion:(NSString *) questionString{
    
    
    AFHTTPRequestOperationManager *requesetManager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameterDic = @{@"key":tuLingKey,@"info":questionString};
    
    
    [requesetManager GET:tuLingBaseUrl parameters:parameterDic success:^(AFHTTPRequestOperation * operation, id responseObject) {
        
        //利用系统的json解析工具解析返回数据
        NSString *jsonStrng = operation.responseString;
        NSData* data = [jsonStrng dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSString *responceString = [dict objectForKey:@"text"];
        
        //将返回信息添加到聊天界面去
        [self addChatMessageWithChatString:responceString andIsOwn:NO];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
        [self addChatMessageWithChatString:@"网络出错了呢..." andIsOwn:NO];
        
    }];
    
    
    
}


/**
 添加一条聊天信息
 1.会先添加到聊天数据数组中
 2.自动刷新界面
 */
-(void) addChatMessageWithChatString:(NSString *) chatString andIsOwn:(BOOL) isOwn{
    
    //1
    BaseCellDataType *cellDataType = [[BaseCellDataType alloc] initWithChatString:chatString andIsOwn:isOwn];
    [chatDataArray addObject:cellDataType];
    
    //2
    [self.chatTableView reloadData];
    
    
    //3.使其自动滑动到最底部,此为得到最底部的indexPath
    NSIndexPath *bottomIndexPath = [NSIndexPath  indexPathForRow:(chatDataArray.count -1) inSection:0];
    
    [self.chatTableView scrollToRowAtIndexPath:bottomIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}




#define mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [chatDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseCellDataType *cellDataType = [chatDataArray objectAtIndex:indexPath.row];
    
    NSString *chatString = cellDataType.chatString;
    
    
    if (cellDataType.isOwn) {
        
        OwnChatTableViewCell *ownCell = [self.chatTableView dequeueReusableCellWithIdentifier:ownChatTableViewCell];
        
        /*
         注意，得到第一次之后就不要在得到第二次了，这样做有两个原因:
         1.为了更好的重用，提高性能
         2.第二次以后得到会出错，不知道为什么(实测在IOS9下有问题，在IOS8下没问题)
         */
        [ownCell setChatContentString:chatString];
        
        
        
        return ownCell;
    }
    else{
        
        OtherChatTableViewCell *otherCell = [self.chatTableView dequeueReusableCellWithIdentifier:otherChatTableViewCell];
        
        
        [otherCell setChatContentString:chatString];
        
        
        return otherCell;
    }
    
    
}

#define mark UITableViewDelegate

/**
 得到高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseChatTableViewCell *ownCell = (BaseChatTableViewCell *)[self tableView:self.chatTableView cellForRowAtIndexPath:indexPath];
    
    return ownCell.currentCellHeight;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor clearColor];
    
}

#define mark VoiceButtonTouchDelegate

/**
 VoiceButton开始触摸的时候
 */
-(void) voiceButtonTouchBegan{
    
    
    //1.开始语音听写
    if(_iFlySpeechRecognizer == nil)
    {
        [self initRecognizer];
    }
    
    [_iFlySpeechRecognizer cancel];
    
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iFlySpeechRecognizer setDelegate:self];
    
    BOOL ret = [_iFlySpeechRecognizer startListening];
    
    NSLog(@"touchesBegan了,是否成功%d",ret);
    
    //2.清除原先的语音数据
    voiceString = [[NSMutableString alloc] initWithString:@""];
    
    
    
}

/**
 VoiceButton结束触摸的时候
 */
-(void) voiceButtonTouchEnded{
    NSLog(@"touchesEnded了");
    
    [_iFlySpeechRecognizer stopListening];
}



#define mark IFlySpeechRecognizerDelegate

/*识别结果返回代理
 @param resultArray 识别结果
 @ param isLast 表示是否最后一次结果
 */
- (void)onResults: (NSArray *)resultArray isLast:(BOOL) isLast
{
    
    NSMutableString *resultJson = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    for (NSString *key in dic){
        [resultJson appendFormat:@"%@",key];//合并结果
    }
    
    //得到返回结果
    NSString * resultString =  [ISRDataHelper stringFromJson:resultJson];
    
    //将其拼接起来
    [voiceString appendString:resultString];
    
    NSLog(@"返回是结果是  %@  是否是最后一次  %d",resultString,isLast);
    
    /*
     如果拼接的结果不为空的话,且是最后一次的话
     */
    if (voiceString!=nil&&![voiceString isEqualToString:@""]&&isLast) {
        
        
        //向网上请求
        //新增一条我的聊天信息
        [self addChatMessageWithChatString:voiceString andIsOwn:YES];
        
        //调用此方法自动访问接口
        [self getMessageFromInterfaceAndResponceWithQuestion:voiceString];
        
        
        
    }
    
    
    
    
}
/*识别会话错误返回代理
 @ param  error 错误码
 */
- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"出现错误了，出的错误是%@",error.errorDesc);
}



//- (void)mykeyboardWillShow:(NSNotification *)aNotification{
//
//    //根据传入的通知得到其中键盘的高度
//    NSDictionary* info = [aNotification userInfo];
//
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//
//    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//
//    if (UIInterfaceOrientationIsLandscape(interfaceOrientation) && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) {
//        CGFloat tmp = kbSize.height;
//        kbSize.height = kbSize.width;
//        kbSize.width = tmp;
//    }
//
//    self.baseScrollViewButtomConstraint.constant = -(kbSize.height);
//}



//返回按钮的点击事件
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

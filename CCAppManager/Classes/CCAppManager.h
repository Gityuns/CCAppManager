//
//  CCAppManager.h
//  Pods-CCAppManager_Example
//
//  Created by 赵郧陕 on 2023/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCAppManager : NSObject

+(instancetype)defaultManager;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) id user;

/**
 存储用户登录信息
 */
-(void)loginWithUser:(id)user;

/**
 退出登录
 */
-(void)logout;
@end

NS_ASSUME_NONNULL_END

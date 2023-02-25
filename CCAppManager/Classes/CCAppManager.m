//
//  CCAppManager.m
//  Pods-CCAppManager_Example
//
//  Created by 赵郧陕 on 2023/2/25.
//

#import "CCAppManager.h"
#import "MJExtension.h"

static NSString *CC_USERDEFAULT_CLASSNAME = @"CC_USERDEFAULT_CLASSNAME";

@implementation CCAppManager

+(instancetype)defaultManager{
    static CCAppManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CCAppManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if(self){
        [self loadFromCache];
    }
    return self;
}

-(void)loadFromCache{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *className = [defaults objectForKey:CC_USERDEFAULT_CLASSNAME];
    if(className){
        NSDictionary *info = [defaults objectForKey:className];
        Class class = NSClassFromString(className);
        _user = [class mj_objectWithKeyValues:info];
        _isLogin = YES;
    }
}

-(void)saveUser:(id)user{
    @synchronized (_user) {
        _user = user;
    }
    [self save];
}

-(void)loginWithUser:(id)user{
    _isLogin = YES;
    @synchronized (_user) {
        _user = user;
    }
    [self save];
}

-(void)logout{
    _isLogin = NO;
    @synchronized (_user) {
        _user = nil;
    }
    NSString *className = NSStringFromClass([_user class]);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:CC_USERDEFAULT_CLASSNAME];
    [defaults removeObjectForKey:className];
    [defaults synchronize];
}

-(void)save{
    NSString *className = NSStringFromClass([_user class]);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[_user mj_keyValues] forKey:className];
    [defaults setObject:className forKey:CC_USERDEFAULT_CLASSNAME];
    [defaults synchronize];
}
@end

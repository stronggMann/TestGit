//
//  WFSelectPhotoBrowserVC.h
//  021.LearnARC
//
//  Created by BB on 2019/9/9.
//  Copyright © 2019 com.rongke.1111. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFSelectPhotoBrowserVC : UIViewController

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, assign) NSInteger index;


- (void)initWithScrollViewFrame;

@end

NS_ASSUME_NONNULL_END

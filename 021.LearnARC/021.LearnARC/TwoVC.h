//
//  TwoVC.h
//  021.LearnARC
//
//  Created by BB on 2019/9/6.
//  Copyright © 2019 com.rongke.1111. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoVC : UIViewController

@property (nonatomic, strong) NSMutableArray * photoArr;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

NS_ASSUME_NONNULL_END

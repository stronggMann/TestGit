//
//  WFSelectPhotoItemCell.h
//  021.LearnARC
//
//  Created by BB on 2019/9/6.
//  Copyright © 2019 com.rongke.1111. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFSelectPhotoItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UIButton *btn;

- (void)reloadCellData:(NSMutableArray *)dataArr vc:(UIViewController *)vc indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, copy) void(^selectBlock)(NSInteger selectItem);

@property (nonatomic, copy) void(^tfBlock)(NSString *selectItem);




@end

NS_ASSUME_NONNULL_END

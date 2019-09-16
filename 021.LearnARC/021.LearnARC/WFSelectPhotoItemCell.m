//
//  WFSelectPhotoItemCell.m
//  021.LearnARC
//
//  Created by BB on 2019/9/6.
//  Copyright © 2019 com.rongke.1111. All rights reserved.
//

#import "WFSelectPhotoItemCell.h"
#import <ReactiveObjC.h>

@implementation WFSelectPhotoItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)reloadCellData:(NSMutableArray *)dataArr vc:(UIViewController *)vc indexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    self.btn.selected = 0;
    if(dataArr.count > 0){
        
        for (int i =0; i<dataArr.count; i++) {
            
            if (item == [dataArr[i] integerValue]) {
                self.btn.selected = 1;
            }
            
        }

    }
    
    self.btn.tag = 10000+item;
    
//    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//        NSInteger item = self.btn.tag - 10000;
//        self.selectBlock(item);
//
//    }];
    
    self.btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {

        NSInteger item = self.btn.tag - 10000;
        self.selectBlock(item);
        
        return [RACSignal empty];
    }];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 15, 100, 30)];
    [self addSubview:tf];
    
    tf.backgroundColor = [UIColor redColor];
    
    [[tf rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.tfBlock(tf.text);
    }];
    
    
    
    
    
}

- (void)pressBtn:(UIButton *)btn {
    
    NSInteger item = btn.tag - 10000;
    
    self.selectBlock(item);
    
}




@end

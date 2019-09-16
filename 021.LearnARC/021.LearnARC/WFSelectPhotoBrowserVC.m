//
//  WFSelectPhotoBrowserVC.m
//  021.LearnARC
//
//  Created by BB on 2019/9/9.
//  Copyright © 2019 com.rongke.1111. All rights reserved.
//

#import "WFSelectPhotoBrowserVC.h"

@interface WFSelectPhotoBrowserVC () {
    
    
    __weak IBOutlet UIScrollView *scrollView;
    
    NSInteger width,height;
    
    
}


@end

@implementation WFSelectPhotoBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    scrollView.contentSize = CGSizeMake(width*self.dataArr.count, height-200);
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = FALSE;
    
    scrollView.showsHorizontalScrollIndicator = FALSE;
    
    for(int i = 0;i<self.dataArr.count;i++){
        
        UIImageView * imageView = [UIImageView new];
        imageView.frame = CGRectMake(i*width, 0, width, height-200);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImage:self.dataArr[i]];
        
        [scrollView addSubview:imageView];
        
    }
    
}

- (void)initWithScrollViewFrame {
    
    
    
    
    
    
    
}










@end

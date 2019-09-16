//
//  OneVC.m
//  021.LearnARC
//
//  Created by BB on 2019/9/6.
//  Copyright © 2019 com.rongke.1111. All rights reserved.
//

#import "OneVC.h"
#import <ReactiveObjC.h>
#import <Photos/Photos.h>
#import "TwoVC.h"

@interface OneVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
}

@end

@implementation OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 30);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;

        [self enumerateAssetsInAssetCollection:cameraRoll original:NO startGetPhotoPoint:0 getPhotoNum:50];

    }];
    
    
}

- (void)getPhotos {
    
    // 判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    // 获得相机胶卷中的所有图片
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithOptions:nil];
    
    __block int count = 0;
    
    for (PHAsset *asset in assets) {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            if(result){
            
//                [dataArr addObject:result];
    
            }
            
        }];
    }
    
    
}

- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original startGetPhotoPoint:(NSInteger)startGetPhotoPoint getPhotoNum:(NSInteger)getPhotoNum {
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    NSMutableArray * dataArr = [NSMutableArray new];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    for (NSInteger i = startGetPhotoPoint; i<getPhotoNum; i++) {

        PHAsset * tempAssets = assets[i];
    
        CGSize size = original ? CGSizeMake(tempAssets.pixelWidth, tempAssets.pixelHeight):CGSizeZero;
        
        [[PHImageManager defaultManager] requestImageForAsset:tempAssets targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            [dataArr addObject:result];
            
        }];
        
    }
    
    TwoVC * twoVC = [TwoVC new];
    twoVC.photoArr = dataArr;
    [self.navigationController pushViewController:twoVC animated:YES];

    
    
    
}

















@end

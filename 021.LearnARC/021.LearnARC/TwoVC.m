//
//  TwoVC.m
//  021.LearnARC
//
//  Created by BB on 2019/9/6.
//  Copyright © 2019 com.rongke.1111. All rights reserved.
//
#define WeakSelf __weak typeof(self) weakSelf = self;
#import <ReactiveObjC.h>
#import <Photos/Photos.h>

#import "TwoVC.h"
#import "WFSelectPhotoItemCell.h"
#import "WFSelectPhotoBrowserVC.h"
@interface TwoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    NSMutableArray * selectArr,*bigPhotoArr;
    NSInteger startGetPhotoPoint;
    
}

@end

@implementation TwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    selectArr = [NSMutableArray new];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"WFSelectPhotoItemCell" bundle:nil] forCellWithReuseIdentifier:@"WFSelectPhotoItemCell"];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(pressRightItem)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self getPhotos];
    
}

- (void)pressRightItem {
    
    NSLog(@"----------\n%@",selectArr);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float width = self.view.frame.size.width/4;
    
    return CGSizeMake(width, width);
}

// 设置item间距。
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 设置行间距。
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    
    WFSelectPhotoItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WFSelectPhotoItemCell" forIndexPath:indexPath];
    
    [cell.img setImage:_photoArr[item]];
    
    [cell reloadCellData:selectArr vc:self indexPath:indexPath];

    cell.selectBlock = ^(NSInteger selectItem) {
        
        NSLog(@"1");
        NSString * selectItemStr = [NSString stringWithFormat:@"%ld",(long)selectItem];
        
        [self->selectArr addObject:selectItemStr];
        [self clearSelectItem:self->selectArr];
        [collectionView reloadData];
        
    };
    
    cell.tfBlock = ^(NSString * _Nonnull selectItem) {
        NSLog(@"tfBlock:\n%@",selectItem);
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WFSelectPhotoBrowserVC * vc = [WFSelectPhotoBrowserVC new];
    
    vc.dataArr = bigPhotoArr;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)clearSelectItem:(NSMutableArray *)arr {

    NSSet *set = [NSSet setWithArray:arr];
    
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF like [cd] %@", obj];
        NSArray *filterdArray = [arr filteredArrayUsingPredicate:predicate];

        if (filterdArray.count >= 2) {
            [arr removeObjectsInArray:filterdArray];
        }
    }];
    
}

- (void)getPhotos {
    
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
    
}

- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original {
    
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    bigPhotoArr = [NSMutableArray new];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    /**
     获取缩略图
     */
    for (PHAsset *asset in assets) {
        //获取缩略图 size是后面collectionViewCell的size
        CGSize size =CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if(result){
                
                [self->bigPhotoArr addObject:result];
                
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




















/**
 
 我是你爸爸2
 
 
 
 */







@end

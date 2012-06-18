//
//  Created by azu on 12/06/18.
//


#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"


@interface SelectedImageCell : AQGridViewCell

@property(nonatomic, retain) UIImageView *imageView;


@property(nonatomic) BOOL isChecked;

- (UIImage *)image;

- (void)setImage:(UIImage *)anImage;


@end
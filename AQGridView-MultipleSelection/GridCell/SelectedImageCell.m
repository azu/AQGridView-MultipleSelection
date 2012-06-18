//
//  Created by azu on 12/06/18.
//


#import "SelectedImageCell.h"


@interface SelectedImageCell ()

@property(nonatomic, retain) UIImageView *checkImageView;

@end

@implementation SelectedImageCell {

@private
    UIImageView *imageView_;
    UIImageView *checkImageView_;
    BOOL isChecked_;
}

@synthesize imageView = imageView_;
@synthesize checkImageView = checkImageView_;
@synthesize isChecked = isChecked_;


- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)aReuseIdentifier {
    self = [super initWithFrame:frame reuseIdentifier:aReuseIdentifier];
    if (self == nil){
        return (nil);
    }

    self.isChecked = NO;
    self.checkImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-checkmark.png"]] autorelease];
    self.imageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.contentView.backgroundColor = self.backgroundColor;
    self.imageView.backgroundColor = self.backgroundColor;

    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.checkImageView];

    return self;
}


- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)anImage {
    self.imageView.image = anImage;
    [self setNeedsLayout];
}

- (void)setIsChecked:(BOOL)anIsChecked {
    isChecked_ = anIsChecked;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGSize imageSize = self.imageView.image.size;
    CGRect bounds = self.contentView.bounds;

    if ((imageSize.width <= bounds.size.width) &&
        (imageSize.height <= bounds.size.height)){
        return;
    }

    // scale it down to fit
    CGFloat hRatio = bounds.size.width / imageSize.width;
    CGFloat vRatio = bounds.size.height / imageSize.height;
    CGFloat ratio = MIN(hRatio, vRatio);

    [self.imageView sizeToFit];
    CGRect frame = self.imageView.frame;
    frame.size.width = floorf(imageSize.width * ratio);
    frame.size.height = floorf(imageSize.height * ratio);
    frame.origin.x = floorf((bounds.size.width - frame.size.width) * 0.5);
    frame.origin.y = floorf((bounds.size.height - frame.size.height) * 0.5);
    self.imageView.frame = frame;

    if (self.isChecked){
        self.checkImageView.hidden = NO;
        self.checkImageView.frame = CGRectMake(bounds.size.width - self.checkImageView.frame.size.width,
            bounds.size.height - self.checkImageView.frame.size.height,
            self.checkImageView.frame.size.width, self.checkImageView.frame.size.height);
    } else {
        self.checkImageView.hidden = YES;
    }
}

- (void)dealloc {
    [imageView_ release], imageView_ = nil;
    [checkImageView_ release], checkImageView_ = nil;
    [super dealloc];
}
@end
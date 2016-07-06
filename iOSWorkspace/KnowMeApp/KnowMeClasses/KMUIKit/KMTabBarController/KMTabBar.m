//
//  KMTabBar.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "KMTabBar.h"
#import "KMTabBarController.h"
#import "KMTabStyleGuide.h"


typedef void(^KMTabSelectedBlock)(NSInteger index);


@interface KMTabBar ()
{
    NSInteger                _index;
    NSArray                 *_items;
    NSMutableArray          *_itemRects;//事件响应
    CGFloat                  _maxWidthDivisor;//宽度被分成的份数
    UIColor                 *_normalTintColor;
    UIColor                 *_highlightTintColor;
    UIImageView             *_backgroudImageView;
    KMTabSelectedBlock       _selectedBlock;
}
@end

@implementation KMTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _itemRects = [[NSMutableArray alloc] init];
    
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [_backgroundImage drawInRect:self.bounds];
    
    __block UITabBarItem *it = nil;
    __block CGFloat lastOffsetX = 0;
    __block CGRect rc;
    
    __block itemHeight;
    [_items enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         it = obj;
         
         itemHeight = self.height;
         if (it.kmCustomView)
         {
             itemHeight = it.kmCustomView.height;
         }
         
         rc = CGRectMake(lastOffsetX, self.height-itemHeight, self.width*it.kmWidthRatio/_maxWidthDivisor, itemHeight);
         [_itemRects addObjectSafely:NSStringFromCGRect(rc)];
         
         
         if (it.kmCustomView)
         {
             CGRect frame = rc;
             frame.origin.x += (frame.size.width-it.kmCustomView.frame.size.width)/2;
             frame.size.width = it.kmCustomView.frame.size.width;
             it.kmCustomView.frame = frame;
             [self addSubview:it.kmCustomView];
         }
         else{
             UIImage *iconImage;
             if (idx == _index)
             {
                 [_highlightTintColor set];
                 iconImage = it.selectedImage;
             }
             else
             {
                 [_normalTintColor set];
                 iconImage = it.image;
             }
             CGFloat h = [it.title sizeWithFont:[KMTabStyleGuide titleFont]].height;
             
             //ICON
             CGRect rcIcon = CGRectMake(rc.origin.x+(rc.size.width-[KMTabStyleGuide normalIconSize].width)/2, [KMTabStyleGuide iconTopMargin], [KMTabStyleGuide normalIconSize].width, [KMTabStyleGuide normalIconSize].height);
             [iconImage drawInRect:rcIcon];
             //TITLE
             CGRect rcTitle = CGRectMake(rc.origin.x, rcIcon.origin.y+rcIcon.size.height+[KMTabStyleGuide titleIconSpacing], rc.size.width, rc.size.height);
             [it.title drawInRect:rcTitle withFont:[KMTabStyleGuide titleFont] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];

             if (it.kmBadgeValue)//飘字
             {
                 //计算字体最大宽度；badgeCornerRadius
                 CGSize size = [NSString km_sizeOfString:it.kmBadgeValue withFont:[KMTabStyleGuide badgeFont]];
                 CGFloat maxWidth = rc.size.width-rcIcon.size.width;
                 CGFloat fontWidth = MIN(size.width, maxWidth - 2*[KMTabStyleGuide badgeCornerRadius]);
                 //画badge背景
                 CGFloat badgeWidth = fontWidth+2*[KMTabStyleGuide badgeCornerRadius];
                 CGRect badgeRect = CGRectMake(lastOffsetX+rc.size.width-badgeWidth, rcIcon.origin.y+5.0-[KMTabStyleGuide badgeCornerRadius], badgeWidth, [KMTabStyleGuide badgeHeight]);
                 UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:badgeRect cornerRadius:[KMTabStyleGuide badgeCornerRadius]];
                 [[KMTabStyleGuide badgeColor] set];
                 [path fill];
                 //badge字
                 CGRect rcBadgeValue = badgeRect;
                 rcBadgeValue.origin.x += [KMTabStyleGuide badgeCornerRadius];
                 rcBadgeValue.size.width -= 2*[KMTabStyleGuide badgeCornerRadius];
                 rcBadgeValue.origin.y += (badgeRect.size.height-size.height)/2;
                 [[KMTabStyleGuide badgeFontColor] set];
                 [it.kmBadgeValue drawInRect:rcBadgeValue withFont:[KMTabStyleGuide badgeFont] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
             }
             else if (it.kmHasBadge)//飘点
             {
                 UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rcIcon.origin.x+rcIcon.size.width, rcIcon.origin.y+5.0)
                                                                     radius:[KMTabStyleGuide badgeDotRadius]
                                                                 startAngle:(-M_PI/2)
                                                                   endAngle:(3*M_PI/2)
                                                                  clockwise:YES];
                 [[KMTabStyleGuide badgeColor] set];
                 [path fill];
                 //加白边、防止深色背景情况下，背景色与badgeColor无法区分问题
                 path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rcIcon.origin.x+rcIcon.size.width, rcIcon.origin.y+5.0)
                                                       radius:[KMTabStyleGuide badgeDotRadius]+[KMTabStyleGuide badgeStrokeWidth]
                                                   startAngle:(-M_PI/2)
                                                     endAngle:(3*M_PI/2)
                                                    clockwise:YES];
                 path.lineWidth = [KMTabStyleGuide badgeStrokeWidth];
                 [[KMTabStyleGuide badgeStrokeColor] set];
                 [path stroke];
             }
         }
         
         lastOffsetX += rc.size.width;
         
     }];
}

- (void)updateWithItems:(nonnull NSArray*)items index:(NSInteger)index selected:(void (^ __nullable)(NSInteger index))completion
{
    //    [_backgroudImageView setImage:_backgroundImage];
    [_itemRects removeAllObjects];
    _maxWidthDivisor = 0;
    __block UITabBarItem *it = nil;
    [items enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         it = obj;
         if (it.kmWidthRatio >0)
         {
             _maxWidthDivisor += it.kmWidthRatio;//barItem的宽度不是固定的，有的宽一些
         }
         else
         {
             it.kmWidthRatio = 1.0;
             _maxWidthDivisor += 1;
         }
     }];
    
    _items = items;
    _index = index;
    _selectedBlock = completion;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!event) return;
    
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint tL = [touch locationInView:self];
    
    [_itemRects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(CGRectFromString(obj), tL))
        {
            UITabBarItem *it = [_items objectAtIndexSafely:idx];
            if (it &&!it.kmCustomView)
            {
                [self setNeedsDisplay];
                if (_selectedBlock)
                {
                    _index = idx;
                    _selectedBlock(idx);
                }
            }
            
            
            *stop = YES;
            
        }
    }];
    
    
}


- (CGRect)itemRect:(NSInteger)index
{
    return CGRectFromString([_itemRects objectAtIndexSafely:index]);
}

@end

//
//  PlaceTableViewCell.m
//  Cilent
//
//  Created by Steven Stewart on 1/10/15.
//  Copyright (c) 2015 Maaz Kamani. All rights reserved.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        AppState* appState = [AppState getInstance];
        
        UIView* vLine = [[UIView alloc] initWithFrame:CGRectMake(0, 70, appState.screenWidth, 1)];
        vLine.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:vLine];
        
        self.contentView.frame = CGRectMake(0, 0, appState.screenWidth, 70);
        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, appState.screenWidth-60, 30)];
        [self.contentView addSubview:self.lblName];
        
        UIImageView* ivNameRightArrow = [ViewUtil getImageView:appState.screenWidth-50 :20 :30 :30 :@"RightArrow.png"];
        [self.contentView addSubview:ivNameRightArrow];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

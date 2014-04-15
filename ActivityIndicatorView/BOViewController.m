//
//  BOViewController.m
//  ActivityIndicatorView
//
//  Created by iOS Dev 3 on 15/04/14.
//  Copyright (c) 2014 Bala. All rights reserved.
//

#import "BOViewController.h"

@interface BOViewController ()

@end

@implementation BOViewController
UISlider *loadingSpeedSlider;
UISwitch *directionSwitch;
BOOL clockWiseDirection;
int angle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    angle = 12;
    clockWiseDirection = TRUE;
    _activityTableView.scrollEnabled = NO;
	// Do any additional setup after loading the view, typically from a nib.
    loadingSpeedSlider = [[UISlider alloc]initWithFrame:CGRectMake(100, 0, 200, 30)];
    [loadingSpeedSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    loadingSpeedSlider.minimumValue = 1;
    loadingSpeedSlider.maximumValue = 10;
    
    directionSwitch  = [[UISwitch alloc]initWithFrame:CGRectMake(240, 5, 70, 30)];
    [directionSwitch addTarget:self action:@selector(directionChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIView *imageBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageBackView.backgroundColor = [UIColor colorWithRed:0.674 green:0.674 blue:0.674 alpha:0.8];
    imageBackView.center = self.view.center;
    imageBackView.layer.cornerRadius = 5.0;
    
    //    imageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading3.png"]];
    //    imageView.frame = CGRectMake(0, 0, 100, 100);
    //    imageView.contentMode = UIViewContentModeCenter;
    //    [imageBackView addSubview:imageView];
    //    [self.view addSubview:imageBackView];
    //    [self rotateImageView];
}

-(void)directionChanged:(UISwitch *)directionSwitch
{
    if(directionSwitch.isOn)
    {
        clockWiseDirection = FALSE;
        angle = -angle;
    }
    else{
        clockWiseDirection = TRUE;
        angle = -angle;
    }
    
    [_activityTableView reloadData];
}

-(void)sliderValueChanged:(UISlider *)slider
{
    angle = (slider.value * 12);
    [_activityTableView reloadData];
}

-(void)rotateImageView:(UIImageView *)imgView
{
    NSLog(@"rotateImageView");
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        NSLog(@"sample ");
        [imgView setTransform:CGAffineTransformRotate(imgView.transform, angle * (M_PI/180))];
    }completion:^(BOOL finished){
        if (finished) {
            [self rotateImageView:imgView];
        }
    }];
}

-(void)startRotating:(UIButton *)button
{
    if(button.tag == 101)
    {
        UIImageView *imgView =(UIImageView *) [_activityTableView viewWithTag:301];
        [self rotateImageView:imgView];
    }
    else  if(button.tag == 102)
    {
        UIImageView *imgView =(UIImageView *) [_activityTableView viewWithTag:302];
        [self rotateImageView:imgView];
    }
    
    else if(button.tag == 103)
    {
        UIImageView *imgView =(UIImageView *) [_activityTableView viewWithTag:303];
        [self rotateImageView:imgView];
    }
    
}

-(void)stopRotating:(UIButton *)button
{
    if(button.tag == 201)
    {
        UIImageView *imgView =(UIImageView *) [_activityTableView viewWithTag:301];
        [imgView stopAnimating];
          [imgView.layer removeAllAnimations ];
    }
    else  if(button.tag == 202)
    {
        UIImageView *imgView =(UIImageView *) [_activityTableView viewWithTag:302];
        [imgView stopAnimating];
          [imgView.layer removeAllAnimations ];

    }
    
    else if(button.tag == 203)
    {
        UIImageView *imgView =(UIImageView *) [_activityTableView viewWithTag:303];
        [imgView stopAnimating];
        [imgView.layer removeAllAnimations ];

    }

}

# pragma mark - tableview delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 2;
    }
    else if (section == 1)
    {
        return 3;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 40;
    }
    else if (indexPath.section == 1)
    {
        return 100;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            UILabel *directionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 240, 30)];
            directionLabel.text = @"Anti-ClockWise Direction";
            [cell addSubview:directionSwitch];
            [cell addSubview:directionLabel];
            directionSwitch.on = !clockWiseDirection;
        }
        else if (indexPath.row == 1)
        {
            UILabel *directionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 240, 30)];
            directionLabel.text = @"Speed";
            [cell addSubview:loadingSpeedSlider];
            [cell addSubview:directionLabel];
            
        }
        
    }
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 35, 80, 30)];
            [startButton setTitle:@"Start" forState:UIControlStateNormal];
            [startButton addTarget:self action:@selector(startRotating:) forControlEvents:UIControlEventTouchUpInside];
            [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            startButton.tag = 101;
            UIButton *stopButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 35, 80, 30)];
            [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
            [stopButton addTarget:self action:@selector(stopRotating:) forControlEvents:UIControlEventTouchUpInside];
            [stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            stopButton.tag = 201;
            
            UIImageView *imageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading1.png"]];
            imageView.frame = CGRectMake(200, 0, 100, 100);
            imageView.contentMode = UIViewContentModeCenter;
            imageView.tag = 301;
            
            [cell addSubview:imageView];
            [cell addSubview:startButton];
            [cell addSubview:stopButton];
        }
        else if (indexPath.row == 1)
        {
            UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 35, 80, 30)];
            [startButton setTitle:@"Start" forState:UIControlStateNormal];
            [startButton addTarget:self action:@selector(startRotating:) forControlEvents:UIControlEventTouchUpInside];
            [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            startButton.tag = 102;
            UIButton *stopButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 35, 80, 30)];
            [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
            [stopButton addTarget:self action:@selector(stopRotating:) forControlEvents:UIControlEventTouchUpInside];
            [stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            stopButton.tag = 202;
            
            UIImageView *imageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading2.png"]];
            imageView.frame = CGRectMake(200, 0, 100, 100);
            imageView.contentMode = UIViewContentModeCenter;
            imageView.tag = 302;
            
            [cell addSubview:imageView];
            [cell addSubview:startButton];
            [cell addSubview:stopButton];
        }
        else if (indexPath.row == 2)
        {
            UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 35, 80, 30)];
            [startButton setTitle:@"Start" forState:UIControlStateNormal];
            [startButton addTarget:self action:@selector(startRotating:) forControlEvents:UIControlEventTouchUpInside];
            [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            startButton.tag = 103;
            UIButton *stopButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 35, 80, 30)];
            [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
            [stopButton addTarget:self action:@selector(stopRotating:) forControlEvents:UIControlEventTouchUpInside];
            [stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            stopButton.tag = 203;
            
            UIImageView * imageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading3.png"]];
            imageView.frame = CGRectMake(200, 0, 100, 100);
            imageView.contentMode = UIViewContentModeCenter;
            imageView.tag = 303;
            
            [cell addSubview:imageView];
            [cell addSubview:startButton];
            [cell addSubview:stopButton];
        }
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerVew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    if(section == 0)
    {
        titleLabel.text =  @"Options";
    }
    else if (section == 1)
    {
         titleLabel.text =  @"Activity Indicators";
    }

    headerVew.backgroundColor = [UIColor grayColor];
    [headerVew addSubview:titleLabel];
    return headerVew;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

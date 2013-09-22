//
//  DateSelectViewController.m
//  M7MotionSample
//
//  Created by Zushi Tatsuya on 2013/09/22.
//  Copyright (c) 2013年 cyan-stivy.net. All rights reserved.
//

#import "DateSelectViewController.h"
#import "DatePickerCell.h"

@interface DateSelectViewController ()
@property (nonatomic, strong) DatePickerCell *datePickerCell;
@property (nonatomic, strong) UITableViewCell *fromDateCell;
@property (nonatomic, strong) UITableViewCell *toDateCell;
@property (nonatomic, strong) NSIndexPath *datePickerCellIndexPath;
@property (nonatomic, strong) NSIndexPath *datePickerCellOwnerIndexPath;
@property (nonatomic, assign) BOOL needsAppend;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong, readwrite) NSDate *fromDate;
@property (nonatomic, strong, readwrite) NSDate *toDate;
@end

@implementation DateSelectViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale systemLocale]];
        [_dateFormatter setDateFormat:@"yyyy/MM/dd"];

    }
    return _dateFormatter;
}

- (void)datePickerSelected:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    if (cell == self.fromDateCell) {
        self.fromDate = datePicker.date;
    } else {
        self.toDate = datePicker.date;
    }
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:datePicker.date];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.datePickerCellIndexPath) ? 3 : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([self.datePickerCellIndexPath isEqual:indexPath]) ? 178 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.datePickerCellIndexPath isEqual:indexPath]) {
        DatePickerCell *cell = (DatePickerCell *)[tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
        if (self.datePickerCell != cell) {
            self.datePickerCell = cell;
            [self.datePickerCell.datePicker addTarget:self action:@selector(datePickerSelected:) forControlEvents:UIControlEventValueChanged];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (indexPath.row == 0) {
            if (self.fromDateCell != cell) {
                self.fromDateCell = cell;
                self.fromDate = [NSDate date];
            }
            self.fromDateCell.textLabel.text = NSLocalizedString(@"Date From", nil);
            self.fromDateCell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.fromDate];
            return self.fromDateCell;
        } else if (indexPath.row == 1) {
            if (self.toDateCell != cell) {
                self.toDateCell = cell;
                self.toDate = [NSDate date];
            }
            self.toDateCell.textLabel.text = NSLocalizedString(@"Date To", nil);
            self.toDateCell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.toDate];
            return self.toDateCell;
        }
        return cell;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = YES;
    if ((self.datePickerCellIndexPath && [[tableView indexPathForSelectedRow] isEqual:indexPath])) {
        result = NO;
    }
   
    self.needsAppend = result;
    
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[DatePickerCell class]]) {
        return nil;
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *delete = self.datePickerCellIndexPath;
    
    if (delete) {
        self.datePickerCellIndexPath = nil;
        self.datePickerCellOwnerIndexPath = nil;
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[delete] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }

    if (self.needsAppend) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            self.datePickerCellIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        } else {
            self.datePickerCellIndexPath = indexPath;
        }
        
        self.datePickerCellOwnerIndexPath = indexPath;
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[self.datePickerCellIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }
}

@end

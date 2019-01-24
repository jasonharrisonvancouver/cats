//
//  ViewController.m
//  Cats
//
//  Created by jason harrison on 2019-01-24.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary *> *people;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController


- (void)anotherWay {
    
    
    // key 3b801d634be562e16044124f4c11f184
    // secret e4221c99ba57b9ef
    // url https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=3b801d634be562e16044124f4c11f184&tags=cat
    // https://farm5.staticflickr.com/4916/31919761287_72fbc8c25f.jpg
    // {"id":"31919761287","owner":"73299437@N00","secret":"72fbc8c25f","server":"4916","farm":5,"title":"Charly :(","ispublic":1,"isfriend":0,"isfamily":0},

    
    NSURL *url = [NSURL URLWithString:@"https://swapi.co/api/people/"];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"AHHHH ERRRORRRRR!!!!!!!!!! %@", error);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"AHHHH ERRRORRRRR!!!!!!!!!! %@", jsonError);
            return;
        }
        
        self.people = json[@"results"];
        
        // Update the ui on the main queue.
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    }];
    
    [task resume];
}
// end end


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self anotherWay];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"catCell"];
    
    NSDictionary *person = self.people[indexPath.row];
    
    cell.textLabel.text = person[@"name"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.people.count;
}

@end

//
//  ViewController.m
//  Cats
//
//  Created by jason harrison on 2019-01-24.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import "CatViewController.h"
#import "Photo.h"
#import "Album.h"
#import "MyTableViewCell.h"

@interface CatViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary *> *objects;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic, readwrite) Album *album;

@end

@implementation CatViewController


- (void)getAllImages:(NSString *)subject {
    
    
    // key 3b801d634be562e16044124f4c11f184
    // secret e4221c99ba57b9ef
    // url https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=3b801d634be562e16044124f4c11f184&tags=cat
    // https://farm5.staticflickr.com/4916/31919761287_72fbc8c25f.jpg
    // {"id":"31919761287","owner":"73299437@N00","secret":"72fbc8c25f","server":"4916","farm":5,"title":"Charly :(","ispublic":1,"isfriend":0,"isfamily":0},
    
    
    //NSURL *url = [NSURL URLWithString:@"https://swapi.co/api/people/"];
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=3b801d634be562e16044124f4c11f184&tags=%@", subject];
    NSURL *url = [NSURL URLWithString:urlString];
    
    
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
        
        self.objects = json[@"photos"][@"photo"];
        
        // NSLog(@"objects are %@", self.objects);
        
        NSLog(@"one object is %@", [self.objects objectAtIndex:5]);
        
        
        /* one cat's info includes:
         farm
         id
         isfamily
         isfriend
         ispublic
         owner
         secret
         server
         title
         */
        
        for(int i = 0; i < [self.objects count]; i++){
            
            NSString *photoId = [[self.objects objectAtIndex:i] objectForKey:@"id"];
            
            NSString *owner = [[self.objects objectAtIndex:i] objectForKey:@"owner"];
            NSString *secret = [[self.objects objectAtIndex:i] objectForKey:@"secret"];
            NSString *title = [[self.objects objectAtIndex:i] objectForKey:@"title"];
            NSString *server = [[self.objects objectAtIndex:i] objectForKey:@"server"];
            int farm = [[[self.objects objectAtIndex:i] objectForKey:@"farm"] intValue];
            BOOL isFamily = [[self.objects objectAtIndex:i] objectForKey:@"isfamily"];
            BOOL isFriend = [[self.objects objectAtIndex:i] objectForKey:@"isfriend"];
            BOOL isPublic = [[self.objects objectAtIndex:i] objectForKey:@"isPublic"];
            
            
            
            Photo *photo = [[Photo alloc] initWithId:photoId andOwner:owner andSecret:secret andServer:server andFarm:farm andTitle:title andIsPublic:isPublic andIsFriend:isFriend andIsFamily:isFamily];
            
            [self.album addPhotoToAlbum:photo];
            
        }
        
        // Update the ui on the main queue.
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    }];
    
    [task resume];
    
    //NSLog(@"%@", self.album);
}
// end end


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.album = [[Album alloc] init];
    [self getAllImages:@"cat"];
    
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"catCell"];
    
    NSDictionary *cat = self.objects[indexPath.row];
    
    //    cell.textLabel.text = cat[@"photo"];
    
    //NSLog(@"info: %@", [cat objectForKey:@"title"]);
    
    NSString *title = [NSString stringWithFormat:@"%@",[cat objectForKey:@"title"]];
    
    cell.textLabel.text = title;
    
    
    // cell.imageView.image = [[[UIImage imageNamed:[self.album getPhotoAtIndex:indexPath.row] url] ];
    
    Photo *photo = [self.album getPhotoAtIndex:(int)indexPath.row];
    NSString *url = [photo url];
    UIImage *image = [UIImage imageNamed:url];
    NSLog(@"showing image named %@", url);
    
    NSURL *urlObject = [NSURL URLWithString:url];

    /* this works but not asynchronously; use a download task instead:
     */
    //NSData *imageData = [NSData dataWithContentsOfURL:urlObject];
    //cell.imageView.image = [UIImage imageWithData:imageData];


    
    
    
    
    
    // start
  
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           NSURL *imageURL = [NSURL URLWithString:url];
                           NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                           
                           //completion handler
                           dispatch_sync(dispatch_get_main_queue(), ^{
                               
                               UIImage *im = [UIImage imageWithData:imageData];
                               
                               // back on main thread now
                               cell.imageView.image = im;
                               
                           });
                       });
        
    
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objects.count;
}

@end

//
//  CustomAnnotationView.m
//  customAnnotationViews

#import <MapKit/MapKit.h>
#import "CustomAnnotationView.h"

@implementation CustomAnnotationView
@synthesize selectedIndex;

-(id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)annotationIdentifier image:(NSString*)image
{
    self = [super initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    if (self)
    {
        //Create your UIImage to be used.
        UIImage *myImage = [UIImage imageNamed:image];
        //Set your view's image
        self.image = myImage;
        //Standardize your AnnotationView's size.
        self.frame = CGRectMake(0, 0, 40, 40);
        //Use contentMode to ensure best scaling of image
        self.contentMode = UIViewContentModeScaleAspectFill;
        //Use centerOffset to adjust the image's position
        self.centerOffset = CGPointMake(1, 1);
    }
    return self;
}

/*-(UIView *)leftCalloutAccessoryView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
    imageView.frame = CGRectMake(0, 0, 20, 20);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}
-(UIView *)rightCalloutAccessoryView
{
    return [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
}*/
@end

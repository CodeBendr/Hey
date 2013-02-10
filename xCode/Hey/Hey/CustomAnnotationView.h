//
//  CustomAnnotationView.h
//  customAnnotationViews

#import <MapKit/MapKit.h>

@interface CustomAnnotationView : MKAnnotationView

@property NSInteger selectedIndex;

-(id)initWithAnnotation:(id <MKAnnotation>) annotation reuseIdentifier:(NSString *)annotationIdentifier image:(NSString*)image;
@end

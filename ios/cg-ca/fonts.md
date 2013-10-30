- enumerate installed fonts

```objective-c
for (NSString* familyName in [UIFont familyNames]) {
  NSLog(@"%@",familyName);
  for (NSString* fontName in [UIFont fontNamesForFontFamilyName: familyName]) {
    NSLog(@"- %@", fontName);
  }
}
```

- set navigation controller title font

```objective-c
  self.title = "New Title";
  UIFont* newFount = [UIFont fontWithName:@"Helvetica" size: 12.0f];
  [self.navigationController.navigationBar setTitleTextAttributes:@{ UITextAttributeFont: newFount}];
```

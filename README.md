# 目的
練習Objective-C, NSURLSession, Block, Delegate, Framework和Testing，撰寫Web Service API（[httpbin.org](httpbin.org)）並包成SDK。

撰寫兩種版本的練習，HttpbinFramework是用Block寫法，HTTPBinOrgFramework是用Delegate寫法，並且會取消前一次的Task。

# 困難
## 1. 錯誤`Building for iOS Simulator, but the linked and embedded framework was built for iOS.`
使用網路上提供的Universal Run Script所產出的.framework檔會顯示`Building for iOS Simulator, but the linked and embedded framework was built for iOS.`錯誤。經了解模擬器使用x86_64架構，實體機使用arm64架構，在XCode12要使用XCFramework來整合不同架構的.framework，於是重寫了Run Script。
```bash
#!/bin/sh

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

xcodebuild archive \
  -scheme "${PROJECT_NAME}" \
  -sdk iphoneos \
  -archivePath "archives/ios_devices.xcarchive" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO
  
xcodebuild archive \
  -scheme "${PROJECT_NAME}" \
  -sdk iphonesimulator \
  -archivePath "archives/ios_simulators.xcarchive" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO
  
rm -r "build/${PROJECT_NAME}.xcframework"

xcodebuild -create-xcframework \
  -framework "archives/ios_devices.xcarchive/Products/Library/Frameworks/${PROJECT_NAME}.framework" \
  -framework "archives/ios_simulators.xcarchive/Products/Library/Frameworks/${PROJECT_NAME}.framework" \
  -output "build/${PROJECT_NAME}.xcframework"

open "${PROJECT_DIR}/build"
```

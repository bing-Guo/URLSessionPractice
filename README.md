# 目的
撰寫Web Service API（[httpbin.org](httpbin.org)）並包成SDK並使用，用於練習Objective-C, NSURLSession, Block, Delegate, Framework, NSOperation, NSOperationQueue和Testing。

* HttpbinFramework: 用Block寫法
* HTTPBinOrgFramework: 用Delegate寫法，並且會取消前一次的Task
* OperationPractice: 使用HttpbinFramework，實作簡易UI，有一個progressView呈現進度，和一個Button負責控制，點擊Button可執行Operation，再次點擊可取消Operation Queue。

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

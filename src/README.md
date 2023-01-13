
## 构建iOS

```bash
# 配置cmake工程
cmake --preset Default
# 使用xcodebuild构建
xcodebuild -project target/QuantumIOS.xcodeproj -scheme QuantumNative -destination generic/platform=iOS -configuration Release build
# 真机构建构建
cmake --build --preset iOS --config Release
# iOS模拟器构建
cmake --build --preset iOS --config Release -- -sdk iphonesimulator
# cmake安装
cmake --install output/ios --config Release --prefix `pwd`/install
```

## 构建macOS

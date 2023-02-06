## 编译配置libsimple库

simple目录通过git子树的形式引用第三方开源库
[https://github.com/wangfenjin/simple.git]

simple/CMakePresets.json为自己添加的文件，用于配置macOS和iOS下的编译

```shell
# 配置
cmake --preset macOS
# 编译
cmake --build --preset macOS --config Release
# 安装
cmake --install output/macos --config Release --prefix install
```
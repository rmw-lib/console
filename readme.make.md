# @rmw/console

##  安装

```
yarn add @rmw/console
```

或者

```
npm install @rmw/console
```

## 配置

比如你的`package.json`中的`name`是 `@rmw/xxx`

可以通过环境变量

`RMW_XXX_DEBUG` 来配置是否在屏幕上打印日志

可以配置 `RMW_XXX_LOG`，`RMW_XXX_ERR` 来控制输出日志的文件

`RMW_LOG`、`RMW_ERR`、`RMW_DEBUG`，则为项目的全局配置

也可以配置 `~/.config/rmw/console.yml` 来设置以上变量

## 使用

```
#include ./test/index.coffee
```

## 关于

本项目隶属于**人民网络([rmw.link](//rmw.link))** 代码计划。

![人民网络](https://raw.githubusercontent.com/rmw-link/logo/master/rmw.red.bg.svg)

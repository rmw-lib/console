<!-- 本文件由 ./readme.make.md 自动生成，请不要直接修改此文件 -->

# @rmw/console

##  安装

```
yarn add @rmw/console
```

或者

```
npm install @rmw/console
```

## 使用

```
#!/usr/bin/env coffee
import console from '@rmw/console'
# import {console as Xxx} from '@rmw/console'
import test from 'tape-catch'

test 'console', (t)=>
  t.equal console(1,2),3
  # t.deepEqual Xxx([1],[2]),[3]
  t.end()

```

## 关于

本项目隶属于**人民网络([rmw.link](//rmw.link))** 代码计划。

![人民网络](https://raw.githubusercontent.com/rmw-link/logo/master/rmw.red.bg.svg)

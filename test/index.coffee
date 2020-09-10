#!/usr/bin/env coffee
import console from '@rmw/console'
# import {console as Xxx} from '@rmw/console'
import test from 'tape-catch'

test 'console', (t)=>
  t.equal console(1,2),3
  # t.deepEqual Xxx([1],[2]),[3]
  t.end()

#!/usr/bin/env coffee
import Console from '@rmw/console'
# import {console as Xxx} from '@rmw/console'
import test from 'tape-catch'


test 'console', (t)=>
  console = Console()
  console.log "您好"
  console.error "test"
  t.end()

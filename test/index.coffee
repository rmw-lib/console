#!/usr/bin/env coffee
import Console from '@rmw/console'

do =>
  console = Console()
  console.log "您好"
  console.dir {a:b:[1,2,3]}
  console.dir {a:b:[1,2,3]}, {colors:false}
  console.trace()
  console.error "test"

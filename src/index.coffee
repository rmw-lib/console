#!/usr/bin/env coffee

export default (a,b)=>
  a + b

export xxx = (a,b)=>
  c = []
  for i, pos in a
    c.push i+b[pos]
  c

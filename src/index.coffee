#!/usr/bin/env coffee

import signale from 'signale'
{Signale} = signale
import {thisdir} from '@rmw/thisfile'
import {createWriteStream,readFileSync} from 'fs'
import {dirname,join} from 'path'
import * as CONFIG from '@rmw/config'
import {package_json, project_name} from "@rmw/env"

STREAM = {}

fs_stream = (path)=>
  log = STREAM[path]
  if not log
    STREAM[path] = log = createWriteStream path, flags:"a"
  log

CONFIG.set(a:1)

export default Log = =>
  config = CONFIG.get() or {}
  {name} = package_json(1)

  [project, name] = project_name name.toUpperCase()
  {env} = process

  stream = []
  error_stream = []

  get = (suffix)=>
    li = (
      prefix+"_"+suffix for prefix in [project+"_"+name, project]
    )
    for vars in [env, config]
      for varname in li
        if varname of vars
          return env[varname].toLowerCase()
    return

  console.log "DEBUG", DEBUG, config

  DEBUG = get 'DEBUG'
  if DEBUG
    try
      DEBUG = JSON.parse(DEBUG) - 0
    catch
      null

  if DEBUG
    stream.push process.stdout
    error_stream.push process.stderr

  ERR = get 'ERR'
  LOG = get "LOG"

  if LOG
    log = fs_stream LOG
    stream.push(log)
    if not ERR
      error_stream.push log

  if ERR
    error_stream.push(fs_stream ERR)

  console.log stream.length
  console.log error_stream.length

  new Signale {
    stream
    types: {
      error: {
        stream: error_stream
      }
    }
  }

con = Log `import.meta`
con.log 'yes',new Date()
con.error 'no',new Date()

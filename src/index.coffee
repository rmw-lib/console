#!/usr/bin/env coffee

import signale from 'signale'
{Signale} = signale
import {thisdir} from '@rmw/thisfile'
import {createWriteStream,readFileSync} from 'fs'
import {dirname,join} from 'path'

STREAM = {}

fs_stream = (path)=>
  log = STREAM[path]
  if not log
    STREAM[path] = log = createWriteStream path, flags:"a"
  log

export default Log = (meta)=>
  {name} = JSON.parse(readFileSync(join(dirname(thisdir(meta)),'package.json'), 'utf8'))

  name = name.toUpperCase()

  pos = name.indexOf("/")
  project = name[...pos].replace("@",'')
  name = name[pos+1..]

  {env} = process

  stream = []
  error_stream = []

  get = (suffix)=>
    for prefix in [project+"_"+name, project]
      varname = prefix+"_"+suffix
      if varname of env
        return env[varname].toLowerCase()

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

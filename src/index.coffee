#!/usr/bin/env coffee

import signale from '@rmw/signale'
{Signale} = signale
import {createWriteStream,readFileSync} from 'fs'
import {dirname,join} from 'path'
import CONF from '@rmw/config'
import {package_json, project_name} from "@rmw/env"
import util from 'util'

STREAM = {}

fs_stream = (path)=>
  log = STREAM[path]
  if not log
    STREAM[path] = log = createWriteStream path, flags:"a"
  log

colors = process.stdout.hasColors()

export class Console extends Signale
  dir:(obj, options={})->
    options = {
      colors
      ...options
    }
    @log util.inspect(obj, options)


  trace:(...args)->
    args.push "\n"+(new Error()).stack
    @error.apply @, args

CONFIG = {
  date:CONF.date
  file:CONF.file
}

if CONFIG.date == undefined
  CONFIG.date = "YYYY-MM-DD HH:mm:ss"
if CONFIG.file == undefined
  CONFIG.file = true

IS_DEV = process.NODE_ENV != "production"

export default =>
  {name} = package_json(1)

  [project, name] = project_name name.toUpperCase()

  stream = []
  error_stream = []

  get = (suffix)=>
    li = (
      prefix+"_"+suffix for prefix in [project+"_"+name, project]
    )
    for vars in [process.env, CONF]
      for varname in li
        val = vars[varname]
        if val != undefined
          return val.toString().toLowerCase()
    return

  DEBUG = get('DEBUG')
  if DEBUG == undefined
    DEBUG = IS_DEV
  else
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

  c = new Console {
    stream
    types: {
      error: {
        stream: error_stream
      }
    }
  }
  opt = {
  }
  if CONFIG.file
    opt.displayFilename = true
  if CONFIG.date
    opt.formatDate = CONFIG.date
    opt.displayDate = true
  c.config opt
  c

process.on 'exit', =>
  for s from Object.values STREAM
    s.close()

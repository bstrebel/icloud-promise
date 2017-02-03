assert = require 'cassert'
_ = require 'lodash'

describe "login", ->
  icloud = require 'icloud-promise'
  client = icloud.ICloudClient('apple_id','password')
  it "should be instantiated", (done) ->
    assert client not instanceof icloud.ICloudClient
    done()

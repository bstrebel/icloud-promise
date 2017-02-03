assert = require 'cassert'
_ = require 'lodash'

describe "login", ->
  icloud = require 'icloud-promise'
  apple_id = process.env.ICLOUD_USERNAME
  password = process.env.ICLOUD_PASSWORD
  client = icloud.ICloudClient(apple_id,password)
  it "should be instantiated", (done) ->
    assert client not instanceof icloud.ICloudClient
    console.log(apple_id, password)
    done()

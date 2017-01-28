# icloud-promise \[work in progress]

Session based iCloud Client using request-promise based on [Picklepete Pyicloud](https://github.com/picklepete/pyicloud)
The module is implemented in pure coffee-script and requires _coffee-script/register_
as shown in the example. The code is used in my [Pimatic Phone](https://github.com/bstrebel/pimatic-phone) plugin.

**Some remarks on iOS devices**

- Notification emails: A notification email from Apple is generated when
    the iCloud session is established.

- Two factor authentication: If activated, a notification dialog pops up
    on your device requiring a confirmation for the session. Also a
    verification code is displayed. It seems that neither the confirmation
    nor the verification code is necessary to access the iCloud device
    information.

- Update interval: Requesting location information from the iPhone triggers
    the device to push the data to the iCloud. A short period increases
    power consumption significantly and may drain your battery.


## Installation
```
npm install icloud-promise
```

## Example
```coffeescript
require 'coffee-script/register'
iCloud = require('icloud-promise')
_ = require 'lodash'

apple_id = process.env.ICLOUD_USERNAME
password = process.env.ICLOUD_PASSWORD
device = process.env.ICLOUD_DEVICE

client = new iCloud.ICloudClient(apple_id, password)
client.login()
.then( (response) ->
  if client.authenticated
    client.refreshClient()
    .then( (response) ->
      found = _.find(client.devices, name: device)
      if found
        console.log("#{found.name} location:", found.location)
      else
        console.log("Device #{device} not found!")
    )
    .catch((error) ->
      console.log('Update device failed, ', error.message)
    )
)
.catch( (error) ->
  console.log('Login failed, ' + error.message)
)
```

## API

The documentation is incomlete. If in doubt, look at the source code ;-)

##### new ICloudClient(apple_id, password) => ICloudClient
```coffeescript
require 'coffee-script/register'
iCloud = require('icloud-promise')
client = new iCloud.ICloudClient(apple_id, password)
```
##### ICloudClientLogin() => Promise
The returned promise (request response or error)
```
client.login()
.then( (response) ->
  do something ...       
).catch( (error) ->
  handle errors ...
)
```
##### ICloudClient.authenticated => Boolean
Returns true after a successful login request

##### ICloudClient.refreshClient() => Promise
Updates the ICloudClient.devices list current information
```
client.refreshClient()
.then( () ->
  do something with client.devices       
).catch( (error) ->
  handle errors ...
)
```

##### More API calls ...
... will be implemented in the near future.

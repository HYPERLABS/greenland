# Channel Management SCPI API
The channel managment SCPI API is used to manage channels for multi channel functions.

## **Error Codes**
The following error codes are supported:
|Number |Name |Desription |
|-------|-----|-----------|
|   0   |no error |this value is returned when there is no error and the error event queue is completely empty |
|-101   |invalid character error |parser encountered an illegal character |
|-103   |invalid separator |parser was excpecting a separator and encountered an illegal character |
|-104   |data type error |parser detected a data element different than the one allowed |
|-108   |parameter not allowed |more parameters were received than expected |
|-109   |missing parameter |fewer parameters were received than required |
|-113   |undefined header |command is undefined for this device although sintactically correct |
|-151   |string data not allowed |encountered a string data were no string data was allowed |
|-170   |expression error |expression error (e.g. parentheses not matching or illegal characters found) |
|-200   |execution error |general error while executing |
|-224   |illegal parameter value |a given parameter was not in the list of possible options that are accepted with the entered command |
|-310   |system error |general system error |
|-350   |scpi error queue overflow error |the scpi error queue overflowed |
|-363   |input buffer overrun error |the scpi input buffer has overrun |

## **Command Reference list**
|SCPI |Command Description |
|-----|--------------------|
|**[Channel Management Commands And Queries](#channel-management-commands-and-queries)** ||
|[`CHANnel:LIST?`](#channellist) |Queries For A List Containing All The Available Channels |
|[`CHANnel:ACTive`](#channelactive) |Configures The Active Channel |
|[`CHANnel:ACTive?`](#channelactive) |Queries For The Active Channel |

## **Command Set Details**
### **Channel Management Commands And Queries**
#### `CHANnel:LIST?`
This query returns a list of all the available channels.
* Query Syntax: `CHANnel:LIST?`
* Query Parameters: None
* Query Examples: `CHANnel:LIST?`
* Query Return Parameters: An array of numeric real which containts the identifiers of all channels
* Reset Value: N/A

#### `CHANnel:ACTive`
This command configures the active channel.
* Command Syntax: `CHANnel:ACTive <cmd> [,channel]`
* Command Parameters: `cmd` is a discrete parameter `ADD|REMOVE|CLEAR`, `channel` is numeric
* Command Examples: `CHANnel:ACTive ADD, 1`, `CHANnel:ACTive REMOVE, 1`, `CHANnel:ACTive CLEAR`
* Query Syntax: `CHANnel:ACTive? [channel]`
* Query Parameters: Optional, provide a channel number to check if it is active
* Query Examples: `CHANnel:ACTive? 0`, `CHANnel:ACTive?`
* Query Return Parameters: Numeric boolean if a channel is given such as in `CHANnel:ACTive? 0`, Otherwise, an array of numeric real for `CHANnel:ACTive?` which containts all the active channels
* Reset Value: 0

# Platform SCPI API
The platform SCPI API controls general platform functions

## **Error Codes**
The following error codes are defined:
|Number |Name |Desription |
|-------|-----|-----------|
|   0   |no error |this value is returned when there is no error and the error event queue is completely empty |
|-100   |command error |command error which corresponds to channel configuration (no channel is active, or the command is a query and more than one channel is active which is illegal) |
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
|**[Platform Commands And Queries](#platform-commands-and-queries)** ||
|[`CARBON:PLATform:LOGINManage`](#carbonplatformloginmanage) |Sends Login Management Commands |
|[`CARBON:PLATform:ENDSession`](#carbonplatformendsession) |End The Current Session Or Cancel A Pending Session Closure |
|[`CARBON:PLATform:GPIO`](#carbonplatformgpio) |Drives The Platform GPIO To A Given State |
|[`CARBON:PLATform:GPIO?`](#carbonplatformgpio) |Queries The State Of The Platform GPIO |
|[`CARBON:PLATform:LISTENGPIOevent?`](#carbonplatformlistengpioevent) |Listen To Supported GPIO Events |
|[`CARBON:PLATform:LISTENENDSessionevent?`](#carbonplatformlistenendsessionevent) |Listen To End Session\Cancel Pending Session Closure Events |

## **Command Set Details**
### **Platform Commands And Queries**
#### `CARBON:PLATform:LOGINManage`
This command sends login management commands.
* Command Syntax: `CARBON:PLATform:LOGINManage <method>`
* Command Parameters: Discrete parameter `REBOOT|POWEROFF`
* Command Examples: `CARBON:PLATform:LOGINManage REBOOT`, `CARBON:PLATform:LOGINManage POWEROFF`
* Reset Value: N/A

#### `CARBON:PLATform:ENDSession`
This command ends the current session or cancels a pending session closure.
* Command Syntax: `CARBON:PLATform:ENDSession <value>`
* Command Parameters: Boolean
* Command Examples: `CARBON:PLATform:ENDSession 1`, `CARBON:PLATform:ENDSession ON`, `CARBON:PLATform:ENDSession OFF`
* Reset Value: N/A

#### `CARBON:PLATform:GPIO`
This command drives or queries the platform GPIO. By default all GPIOs, besides those which are reserved (product dependent), are initialized as inputs. If a GPIO pin is driven using this command, it will be converted to an output and the query will return the value it is driven with.
* Command Syntax: `CARBON:PLATform:GPIO <sink> <mask> <value>`
* Command Parameters:
	* `sink` Discrete parameter which could be any of the following:
		* `C0` - GPIO sink corresponds to C0 (io expander expansion gpio based)
	* `mask` Numeric parameter which specifies the GPIO to address
	* `pin_state` Numeric parameter which specifies the new state of the GPIO pins set in `mask`
* Command Examples: `CARBON:PLATform:GPIO C0, #H8, #H8`, `CARBON:PLATform:GPIO C0, #HC, #H0`, `CARBON:PLATform:GPIO C0, #HC, #HC`
* Query Syntax: `CARBON:PLATform:GPIO? <sink>`
* Query Parameters: See `sink` under Command Parameters
* Query Examples: `CARBON:PLATform:GPIO? C0`
* Query Return Parameters: Integer in hex\decimal format
* Reset Value: N/A

#### `CARBON:PLATform:LISTENGPIOevent?`
This command configures a dedicated listener for the issuing controller. The listener will output a message for each **supported** gpio event that occurs. The controller should keep listening and reading from the interface to receive the messages. Any subsequent commands sent on the interface by the controller will stop its listener.
* Query Syntax: `CARBON:PLATform:LISTENGPIOevent? <src>`
* Query Parameters: `src` is a discrete parameter which could be any of the following:
	* `C0` - GPIO source corresponds to C0 (io expander expansion gpio based)
* Query Examples: `CARBON:PLATform:LISTENGPIOevent? C0`
* Query Return Parameters:
	* As soon as the query is issued the `Subscribed` string is returned.
	* A GPIO event will trigger the message `,<mask>,<pin_state>,` where `mask` is an integer in hex\decimal format that indicates which GPIO pins the event corresponds to and `pin_state` is also an integer in hex\decimal format that indicates the new state of the pins specified in `mask`. For example `,#H2, #H0,` followed by `,#H2, #H2,` means that GPIO pin 1 has changed state to low and then back to high. Similarly `,#H3, #H0,` followed by `,#H2, #H2,` means that both GPIOs 0 and 1 have changed state to low and then only GPIO pin 1 changed state back to high.
* Reset Value: N/A

#### `CARBON:PLATform:LISTENENDSessionevent?`
This command configures a dedicated listener for the issuing controller. The listener will output a message for each end session event that occurs. The controller should keep listening and reading from the interface to receive the messages. Any subsequent commands sent on the interface by the controller will stop its listener.
* Query Syntax: `CARBON:PLATform:LISTENENDSessionevent?`
* Query Parameters: None
* Query Examples: `CARBON:PLATform:LISTENENDSessionevent?`
* Query Return Parameters:
	* As soon as the query is issued the `Subscribed` string is returned.
	* An end session event will trigger the message `,1,<delay>,` where `delay` is a numeric parameter specifiying the delay to the actual session termination is milliseconds. For example `1,60000`
	* An end session cancellation event will trigger the message `,0,`
* Reset Value: N/A

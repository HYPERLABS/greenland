# IEEE488 SCPI API
IEEE488 SCPI API is a set of standardized status registers, error codes and commands.

## **Status Register System**
Status registers are used for monitoring the state of the device. The following abbrevations and nomenclature are used to describe the registers:
* `NU` - Not Used
* `RO` - Read Only
* `W1C` - Write 1 To Clear
* `RW` - Read and Write
* `|(A)` - Indicates a bitwise OR operation on `A`. For example `A = 0001` -> `|A = 1`
* `A & B` - Bitwise AND operation between `A` and `B`. For example `A = 0001`, `B = 0010` -> `A & B = 0000`

### Status Byte Register (`REG_STB`)
`REG_STB` is a `RO` register which contains the bit fields defined below. It can be queried using `*STB?`.\
ℹ️ The following is relevant only if a GPIB interface is available:
* The GPIB interface includes command and data messages, the major difference between the two is the state of the GPIB `ATN` line, which is one of the bus management line. If the `ATN` line is asserted, any messages sent on the data lines are heard by all devices, and they are understood to be command messages. If the `ATN` line is not asserted, only the devices that were addressed to listen may receive the messages on the data lines.
* The value from `REG_STB` register is returned when the bus controller executes a serial poll, after which, the `REG_STB` register will reset back to `0`
* The GPIB `SRQ#` line asserts (active low) if the SRQ bit is set. As mentioned above, after a serial poll, SRQ line is de-asserted and status byte is set to 0.
* The GPIB `SRQ#` lines is also de-asserted and the status byte is cleared if a `DEVICE CLEAR` (`DCL`) command message, or a `SELECTED DEVICE CLEAR` (`SDC`) command message, are received from the GPIB controller.

|Bit |Weight |Abbreviation |Description |Default |
|----|-------|-------------|------------|--------|
|0 |1 |`NU` |Not Used |0 |
|1 |2 |`NU` |Not Used |0 |
|2 |4 |`NU` |Not Used |0 |
|3 |8 |`NU` |Not Used|0 |
|4 |16 |`NU` |Not Used|0 |
|5 |32 |`ESR` |`\|(REG_ESR & REG_ESE)`|0 |
|6 |64 |`SRQ` |Service Request |0 |
|7 |128 |`NU` |Not Used |0 |

### Event Status Register (`REG_ESR`) and Event Status Enable Register (`REG_ESE`)
`REG_ESR` is a `RO` register which contains the bit fields defined below. It can be queried using `*ESR?`.\
`REG_ESE` is a `RW` register which contains enable bits corresponding to the bit fields of `REG_ESR`. It can be set using `*ESE <value>` and queried using `*ESE?`.
|Bit |Weight |Abbreviation |Description |Default |
|----|-------|-------------|------------|--------|
|0 |1 |`OPC` |Operation Complete |1 |
|1 |2 |`NU` |Not Used |0 |
|2 |4 |`NU` |Not Used |0 |
|3 |8 |`NU` |Not Used |0 |
|4 |16 |`NU` |Not Used |0 |
|5 |32 |`NU` |Not Used |0 |
|6 |64 |`NU` |Not Used |0 |
|7 |128 |`NU` |Not Used |0 |

### Service Request Enable Register (`REG_SRE`)
`REG_SRE` is a `RW` register which contains enable bit fields corresponding to `REG_STB`. If a given bit field is set, then the corresponding function will generate a service request. This register can be set using `*SRE <value>` and queried using `*SRE?`.
|Bit |Weight |Abbreviation |Description |Default |
|----|-------|-------------|------------|--------|
|0 |1 |`NU` |Not Used |0 |
|1 |2 |`NU` |Not Used |0 |
|2 |4 |`NU` |Not Used |0 |
|3 |8 |`NU` |Not Used |0 |
|4 |16 |`NU` |Not Used |0 |
|5 |32 |`ESR` |If one of the bits in `REG_ESR` is set, and this bit is set, a service request will be generated |0 |
|6 |64 |`NU` |Not Used |0 |
|7 |128 |`NU` |Not Used |0 |

## **Error Codes**
The following error codes are defined:
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
|**[IEEE Commands And Queries (SCPI std V1999.0 4.1.1)](#ieee-commands-and-queries-scpi-std-v19990-411)** ||
|[`*STB?`](#stb) |Status Byte Query |
|[`*ESR?`](#esr) |Standard Event Status Register Query |
|[`*ESE`](#ese) |Standard Event Status Enable Command |
|[`*ESE?`](#ese) |Standard Event Status Enable Query |
|[`*OPC`](#opc) |Operation Complete Command |
|[`*OPC?`](#opc) |Operation Complete Query |
|[`*CLS`](#cls) |Clear Status Command |
|[`*IDN?`](#idn) |Identification Query |
|[`*RST`](#rst) |Reset Command |
|[`*WAI`](#wai) |Wait To Continue Command |
|**[IEEE Commands And Queries (SCPI std V1999.0 4.2.1)](#ieee-commands-and-queries-scpi-std-v19990-421)** ||
|[`SYSTem:ERRor[:NEXT]?`](#systemerrornext)|Reads The Next Error From The Error Queue |
|[`SYSTem:ERRor:COUNt?`](#systemerrorcount)|Returns The Number Of Items In The Error Queue |
|[`SYSTem:VERSion?`](#systemversion)|Returns The SCPI Standard Version Supported |

## **Command Set Details**
### **IEEE Commands And Queries (SCPI std V1999.0 4.1.1)**
#### `*STB?`
This query returns the Status Byte Register (`REG_STB`). Bits are cleared only when the signals feeding it are cleared.
* Query Syntax: `*STB?`
* Query Parameters: None
* Query Examples: `*STB?`
* Query Return Parameters: Integer
* Reset Value: N/A

#### `*ESR?`
This query reads the Event Status Register (`REG_ESR`). This register is cleared after using this query.
* Query Syntax: `*ESR?`
* Query Parameters: None
* Query Examples: `*ESR?`
* Query Return Parameters: Integer
* Reset Value: N/A

#### `*ESE`
This command programs the Event Status Enable Register (`REG_ESE`) which masks bit in `REG_ESR` when they are summarized (logically OR’d) into the Status Byte Register
* Command Syntax: `*ESE <value>`
* Command Parameters: Register Bit Position
* Command Examples: `*ESE 255`, `*ESE #HFF`
* Query Syntax: `*ESE?`
* Query Parameters: None
* Query Examples: `*ESE?`
* Query Return Parameters: Integer
* Reset Value: N/A

#### `*OPC`
This command clears the operation complete bit found in the Event Status Register (`REG_ESR`). It could be used in application programming when delay exists between sending a SCPI command and the execution of the command. When all commands have completed, the `OPC` bit is set back to `1`. The query `*OPC?` can be used for the same purpose. It will hold the communication bus until the operation complete bit asserts, after which it will return `1`.
* Command Syntax: `*OPC`
* Command Parameters: None
* Command Examples: `*OPC`
* Query Syntax: `*OPC?`
* Query Parameters: None
* Query Examples: `*OPC?`
* Query Return Parameters: Integer
* Reset Value: N/A

#### `*CLS`
This command clears the error queue.
* Command Syntax: `*CLS`
* Command Parameters: None
* Command Examples: `*CLS`
* Reset Value: N/A

#### `*IDN?`
This query requests the device to identify itself, returning a string composed of three fields separated by commas.
* Query Syntax: `*IDN?`
* Query Parameters: None
* Query Examples: `*IDN?`
* Query Return Parameters: String containing: Company Name, Device Model, Serial Number, Version. For example `Hyperlabs,HL10300,#500,1.0.0.0`
* Reset Value: N/A

#### `*RST`
This command triggers a reinitializiation routine.
* Command Syntax: `*RST`
* Command Parameters: None
* Command Examples: `*RST`
* Reset Value: N/A

#### `*WAI`
This command causes the device to wait until all commands received previously have been completed.
* Command Syntax: `*WAI`
* Command Parameters: None
* Command Examples: `*WAI`
* Reset Value: N/A

### **IEEE Commands And Queries (SCPI std V1999.0 4.2.1)**
#### `SYSTem:ERRor[:NEXT]?`
This query returns the next error from the error queue.
* Query Syntax: `SYSTem:ERRor:NEXT?`
* Query Parameters: None
* Query Examples: `SYSTem:ERRor:NEXT?`
* Query Return Parameters: Integer [Error Codes](#error-codes)
* Reset Value: `0`

#### `SYSTem:ERRor:COUNt?`
This query returns the error count in the queue. The query `SYSTem:ERRor:NEXT?` will pop the queue and reduce the count by 1.
* Query Syntax: `SYSTem:ERRor:COUNt?`
* Query Parameters: None
* Query Examples: `SYSTem:ERRor:COUNt?`
* Query Return Parameters: Integer
* Reset Value: `0`

#### `SYSTem:VERSion?`
This query returns the SCPI standard version.
* Query Syntax: `SYSTem:VERSion?`
* Query Parameters: None
* Query Examples: `SYSTem:VERSion?`
* Query Return Parameters: String containing the SCPI standard version. For example `1999.0`
* Reset Value: N/A

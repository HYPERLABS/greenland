# DC Coupled Amplifier SCPI API
The DC coupled amplifier SCPI API controls the DC coupled amplifier functions.

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
|-1101  |operation not supported | operation not supported |
|-1104  |invalid calibration data | calibration data is invalid or missing |

## **Command Reference list**
|SCPI |Command Description |
|-----|--------------------|
|**[Low Level Access Commands And Queries](#low-level-access-commands-and-queries)** ||
|[`BORON:LOWLevel:ACCEss:WRREgister`](#boronlowlevelaccesswrregister) |Write Register Command |
|[`BORON:LOWLevel:ACCEss:RDREgister?`](#boronlowlevelaccessrdregister) |Read Register Command |
|[`BORON:LOWLevel:ACCEss:RWREgister`](#boronlowlevelaccessrwregister) |Read Modify Write Register Command |
|**[Calibration Commands And Queries](#calibration-commands-and-queries)** ||
|[`BORON:CALIbration:LOAD`](#boroncalibrationload) |Loads Calibration Data |
|[`BORON:CALIbration:CLEAR`](#boroncalibrationclear) |Clears Calibration Data |
|**[Control Commands And Queries](#control-commands-and-queries)** ||
|[`BORON:CTRL:DCOFFset`](#boronctrldcoffset) |Set The DC Offset Voltage |
|[`BORON:CTRL:DCOFFset?`](#boronctrldcoffset) |Queries For The DC Offset Voltage |
|[`BORON:CTRL:DCOUTPUTENable`](#boronctrldcoutputenable) |Enables\Disables The DC Restore Circuit Which Determines The DC Offset At The Output |
|[`BORON:CTRL:DCOUTPUTENable?`](#boronctrldcoutputenable) |Queries The Enable State Of The DC Restore Circuit |
|**[General State Commands And Queries](#general-state-commands-and-queries)** ||
|[`BORON:STATE:EMULated?`](#boronstateemulated) |Queries Whether Emulation Is Used |
|[`BORON:STATE:RESET`](#boronstatereset) |Triggers A Reinitialization |
|[`BORON:STATE:GET?`](#boronstateget) |Atomic Get State |
|[`BORON:STATE:LISTENevent?`](#boronstatelistenevent) |Listen To General State Event Changes |
|[`BORON:STATE:TEMPerature?`](#boronstatetemperature) |Queries The Board Temperature |

## **Command Set Details**
### **Low Level Access Commands And Queries**
#### `BORON:LOWLevel:ACCEss:WRREgister`
This command writes a peripheral register.
* Command Syntax: `BORON:LOWLevel:ACCEss:WRREgister <peripheral>, <address>, <value>`
* Command Parameters:
	* `peripheral` Discrete parameter which could be any of the following: `DC_OFFSET_DAC|STAGE1_VG2_STAGE2_VG1_DAC|STAGE2_VG2_DAC`
	* `address` Numeric parameter which specifies the register address
	* `value` Numeric parameter which specifies the register data to write
* Command Examples: `BORON:LOWLevel:ACCEss:WRREgister DC_OFFSET_DAC, #H4, #H5F`
* Reset Value: N/A
* ℹ️ DAC `peripheral` aliases are:
	* `STAGE1_VG2_STAGE2_VG1_DAC` is the temperature controlled DAC
	* `STAGE2_VG2_DAC` is the smart DAC

#### `BORON:LOWLevel:ACCEss:RDREgister?`
This command reads a peripheral register.
* Query Syntax: `BORON:LOWLevel:ACCEss:RDREgister? <peripheral>, <address>`
* Query Parameters:
	* `peripheral` Discrete parameter which could be any of the following: `STAGE1_VG2_STAGE2_VG1_DAC|STAGE2_VG2_DAC`
	* `address` Numeric parameter which specifies the register address
* Query Examples: `BORON:LOWLevel:ACCEss:RDREgister? STAGE2_VG2_DAC, #H4`
* Query Return Parameters: Integer in hex\decimal format
* Reset Value: N/A
* ℹ️ DAC `peripheral` aliases are:
	* `STAGE1_VG2_STAGE2_VG1_DAC` is the temperature controlled DAC
	* `STAGE2_VG2_DAC` is the smart DAC

#### `BORON:LOWLevel:ACCEss:RWREgister`
This command reads modifies and writes back a peripheral register.
* Command Syntax: `BORON:LOWLevel:ACCEss:RDREgister? <peripheral>, <address>, <value>, <mask>`
* Command Parameters: see [BORON:LOWLevel:ACCEss:WRREgister](#boronlowlevelaccesswrregister)
* Command Examples: `BORON:LOWLevel:ACCEss:RWREgister? DC_OFFSET_DAC, #H4 #HFF #H40`
* Reset Value: N/A

### **Calibration Commands And Queries**
#### `BORON:CALIbration:LOAD`
This command loads the calibration files which resides in the given directory. **double quotes around the directory are required**.
* Command Syntax: `BORON:CALIbration:LOAD "<directory>"`
* Command Parameters: directory is a string which contains a path to the calibration directory
* Command Examples: `BORON:CALIbration:LOAD "/media/hl/E280-DC97/"`
* Reset Value: N/A
* ℹ️ The following calibration naming convention must be used:
	* for dc offset: `*dc-offset-map.csv`. For example:
		* `dc-offset-map.csv`
* ℹ️ The file format allows any additional prefix string (marked by `*`) although this is not recommended. Instead it is suggested to name the directory as desired and simply follow the format described above for the file names.

#### `BORON:CALIbration:CLEAR`
This command clears the current calibration data.
* Command Syntax: `BORON:CALIbration:CLEAR`
* Command Parameters: N/A
* Command Examples: `BORON:CALIbration:CLEAR`
* Reset Value: N/A

### **Control Commands And Queries**
#### `BORON:CTRL:DCOFFset`
This command configures the DC Offset voltage of the amplifier.
* Command Syntax: `BORON:CTRL:DCOFFset <value>`
* Command Parameters: Numeric real
* Command Examples: `BORON:CTRL:DCOFFset 3.0`, `BORON:CTRL:DCOFFset MIN`, `BORON:CTRL:DCOFFset MAX`
* Query Syntax: `BORON:CTRL:DCOFFset?`
* Query Parameters: None
* Query Examples: `BORON:CTRL:DCOFFset?`
* Query Return Parameters: Numeric real
* Reset Value: 0
* ℹ️ The following constraints apply to the DC offset:
	* Minimum is $-5\text{V}$
	* Maximum is $+5\text{V}$

#### `BORON:CTRL:DCOUTPUTENable`
This command enables or disables the DC Restore circuit which determines the DC offset at the output.
* Command Syntax: `BORON:CTRL:DCOUTPUTENable <value>`
* Command Parameters: Boolean
* Command Examples: `BORON:CTRL:DCOUTPUTENable 1`, `BORON:CTRL:DCOUTPUTENable ON`, `BORON:CTRL:DCOUTPUTENable OFF`
* Query Syntax: `BORON:CTRL:DCOUTPUTENable?`
* Query Parameters: None
* Query Examples: `BORON:CTRL:DCOUTPUTENable?`
* Query Return Parameters: Numeric boolean
* Reset Value: 0

### **General State Commands And Queries**
#### `BORON:STATE:EMULated?`
* This query returns true if emulation is used instead of real hardware.
* Query Syntax: `BORON:STATE:EMULated?`
* Query Parameters: None
* Query Examples: `BORON:STATE:EMULated?`
* Query Return Parameters: Numeric boolean
* Reset Value: N/A

#### `BORON:STATE:RESET`
This command triggers a reinitializiation routine.
* Command Syntax: `BORON:STATE:RESET`
* Command Parameters: None
* Command Examples: `BORON:STATE:RESET`
* Reset Value: N/A

#### `BORON:STATE:GET?`
This query will return the general state in a single atomic call.
* Query Syntax: `BORON:STATE:GET?`
* Query Parameters: None
* Query Examples: `BORON:STATE:GET?`
* Query Return Parameters: Mixed, a collection of comma separated queries from this document where each one is followed by its corresponding response. For example:\
`BORON:CTRL:DCOFFset?,3.0,BORON:CTRL:DCOUTPUTENable?,1`\
Note that if a given state property is invalid, it will not be included in the response.
* Reset Value: N/A

#### `BORON:STATE:LISTENevent?`
This query configures a dedicated listener for the issuing controller. The listener will output a message when a state change event has occured. The controller should keep listening and reading from the interface to receive additional messages. Any subsequent commands sent on the interface by the controller will stop its listener.
* Query Syntax: `BORON:STATE:LISTENevent?`
* Query Parameters: None
* Query Examples: `BORON:STATE:LISTENevent?`
* Query Return Parameters:
	* As soon as the query is issued the `Subscribed` string is returned.
	* A state change event will trigger the message `,1,`
* Reset Value: N/A
* ℹ️ Events will be generated when the following SCPI commands (not queries) are received:
	* All commands belong to the node `BORON:CTRL`

#### `BORON:STATE:TEMPerature?`
* This query returns the board temperature.
* Query Syntax: `BORON:STATE:TEMPerature?`
* Query Parameters: None
* Query Examples: `BORON:STATE:TEMPerature?`
* Query Return Parameters: Numeric real in degree Celsius
* Reset Value: N/A

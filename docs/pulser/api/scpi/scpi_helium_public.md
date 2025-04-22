# Pulser SCPI API
The pulser SCPI API controls the pulser functions.

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
|-1001  |operation not supported | operation not supported |
|-1002  |alignment required | alignment required |
|-1003  |source clock problem | source clock is invalid or out of range |
|-1004  |invalid calibration data | calibration data is invalid or missing |
|-1005  |invalid configuration | configuration is invalid |
|-1006  |out of range calibration data | configuration requires out of range calibration data |
|-1007  |frequency unknown | frequency unknown and must be measured |

## **Command Reference list**
|SCPI |Command Description |
|-----|--------------------|
|**[Clock Configuration Commands And Queries](#clock-configuration-commands-and-queries)** ||
|[`HELIUM:CLK:SOURce`](#heliumclksource) |Configures The Clock Source |
|[`HELIUM:CLK:SOURce?`](#heliumclksource) |Queries For The Configured Clock Source |
|[`HELIUM:CLK:FREQ`](#heliumclkfreq) |Configures The Internal Clock Frequency |
|[`HELIUM:CLK:FREQ?`](#heliumclkfreq) |Queries For The Frequency Of The Clock Source |
|[`HELIUM:CLK:LISTENevent?`](#heliumclklistenevent) |Listen To Source Clock Events |
|**[Pulse Forming Configuration Commands And Queries](#pulse-forming-configuration-commands-and-queries)** ||
|[`HELIUM:PULSeform:DIVIder`](#heliumpulseformdivider) |Configures A Divider |
|[`HELIUM:PULSeform:DIVIder?`](#heliumpulseformdivider) |Queries The Value Of A Given Divider |
|[`HELIUM:PULSeform:CFGFREQintclksource?`](#heliumpulseformcfgfreqintclksource) |Queries For the Configuration Of The Internal Source Clock And Dividers Required For Synthesizing The Given Pulse Frequency |
|[`HELIUM:PULSeform:FREQintclksource`](#heliumpulseformfreqintclksource) |Configures The Pulse Frequency Based On Internal Source Clock |
|[`HELIUM:PULSeform:FREQ?`](#heliumpulseformfreq) |Queries For the Pulse Frequency |
|[`HELIUM:PULSeform:ALIGn`](#heliumpulseformalign) |Aligns The Pulse Forming Network |
|[`HELIUM:PULSeform:ALIGn?`](#heliumpulseformalign) |Queries For The Alignment Status |
|[`HELIUM:PULSeform:WIDTHADj`](#heliumpulseformwidthadj) |Configures The Pulse Width Adjustment Mode |
|[`HELIUM:PULSeform:WIDTHADj?`](#heliumpulseformwidthadj) |Queries For The Pulse Width Adjustment Mode |
|[`HELIUM:PULSeform:WIDTh`](#heliumpulseformwidth) |Configures The Output Pulse Width |
|[`HELIUM:PULSeform:WIDTh?`](#heliumpulseformwidth) |Queries For The Output Pulse Width |
|[`HELIUM:PULSeform:WIDTHReset`](#heliumpulseformwidthreset) |Resets The Pulse Width To No Pulse |
|[`HELIUM:PULSeform:GATE`](#heliumpulseformgate) |Configures The Pulse Gating Function |
|[`HELIUM:PULSeform:GATE?`](#heliumpulseformgate) |Queries For The Pulse Gating Function |
|**[Output Control Commands And Queries](#output-control-commands-and-queries)** ||
|[`HELIUM:OUTPut:ENABle`](#heliumoutputenable) |Enables\Disables The Pulse Output |
|[`HELIUM:OUTPut:ENABle?`](#heliumoutputenable) |Queries The Pulse Output State |
|[`HELIUM:OUTPut:CLKOutdiv`](#heliumoutputclkoutdiv) |Sets The Divider Value (Power of $2$ in the range $1$-$32$) Of `CLK_OUT` |
|[`HELIUM:OUTPut:CLKOutdiv?`](#heliumoutputclkoutdiv) |Queries The Divider Value Of `CLK_OUT` |
|**[General State Commands And Queries](#general-state-commands-and-queries)** ||
|[`HELIUM:STATE:EMULated?`](#heliumstateemulated) |Queries Whether Emulation Is Used |
|[`HELIUM:STATE:RESET`](#heliumstatereset) |Triggers A Reinitialization |
|[`HELIUM:STATE:GET?`](#heliumstateget) |Atomic Get State |
|[`HELIUM:STATE:LISTENevent?`](#heliumstatelistenevent) |Listen To General State Event Changes |
|[`HELIUM:STATE:TEMPerature?`](#heliumstatetemperature) |Queries The Board Temperature |

## **Command Set Details**
### **Clock Configuration Commands And Queries**
#### `HELIUM:CLK:SOURce`
This command configures the device clock source.
* Command Syntax: `HELIUM:CLK:SOURce <value>`
* Command Parameters: Discrete parameter `INT|EXT`
* Command Examples: `HELIUM:CLK:SOURce INT`, `HELIUM:CLK:SOURce EXT`
* Query Syntax: `HELIUM:CLK:SOURce?`
* Query Parameters: None
* Query Examples: `HELIUM:CLK:SOURce?`
* Query Return Parameters: Discrete parameter
* Reset Value: `INT`

#### `HELIUM:CLK:FREQ`
This command configures the **internal** clock frequency. If no units are specified, the default is Hz. This command will have no effect on the outputs of the device if the configured clock source is external.
* Command Syntax: `HELIUM:CLK:FREQ <value>`
* Command Parameters: Extended numeric
* Command Examples: `HELIUM:CLK:FREQ 1.2GHz`, `HELIUM:CLK:FREQ 1.2E9`, `HELIUM:CLK:FREQ MIN`, `HELIUM:CLK:FREQ MAX`
* Query Syntax: `HELIUM:CLK:FREQ? [KNOWN]`
* Query Parameters: Optional, if `KNOWN` is provided with the query then the result will indicate if the source clock frequency is known. When the query is called without a parameter the actual source clock frequency is returned.
* Query Examples: `HELIUM:CLK:FREQ?`, `HELIUM:CLK:FREQ? KNOWN`
* Query Return Parameters: Numeric real in **Hz** or if `KNOWN` is specified `1`|`0`
* Reset Value: N/A
* ℹ️ The following constraints apply to the internal clock frequency:
	* The internal clock frequency resolution is $1\text{PPB}$
	* Minimum is $312.5\text{MHz}$
	* Maximum is $3\text{GHz}$
	* Frequencies in the band $(2.62444\text{GHz} - 2.7\text{GHz})$ are not obtainable
* ℹ️ Source clock frequency measurement:
	* If the source clock frequency is unknown the query `HELIUM:CLK:FREQ?` will trigger a measurement process which will delay the response by a few hundereds of milliseconds
	* The query `HELIUM:CLK:FREQ? KNOWN` will never trigger the measurement process. It will simply return the current `known` state stored by the device

#### `HELIUM:CLK:LISTENevent?`
This query configures a dedicated listener for the issuing controller. The listener will output a message when a source clock event occured. The controller should keep listening and reading from the interface to receive additional messages. Any subsequent commands sent on the interface by the controller will stop its listener.
* Query Syntax: `HELIUM:CLK:LISTENevent?`
* Query Parameters: None
* Query Examples: `HELIUM:CLK:LISTENevent?`
* Query Return Parameters:
	* As soon as the query is issued the `Subscribed` string is returned.
	* A clk event will trigger the message `,<event>,` where `event` is a numeric parameter which corresponds to the following (for example `,1,`):
		* `1` - Source clock glitched
		* `2` - Source clock is too slow
		* `3` - Source clock is too fast
		* `4` - Source clock stopped
* Reset Value: N/A


### **Pulse Forming Configuration Commands And Queries**
#### `HELIUM:PULSEform:DIVIder`
This command configures the given divider. Divider values which are not powers of 2 are not allowed. Changing the divider requires [realignment](#heliumpulseformalign).
* Command Syntax: `HELIUM:PULSEform:DIVIder <type>, <value>`
* Command Parameters: `type` is a discrete parameter `PFN_INPUT|PFN_INTERNAL`, `value` is an extended numeric parameter
* Command Examples: `HELIUM:PULSEform:DIVIder PFN_INTERNAL, 1`, `HELIUM:PULSEform:DIVIder PFN_INPUT, 4`, `HELIUM:PULSEform:DIVIder PFN_INPUT, MAX`
* Query Syntax: `HELIUM:PULSEform:DIVIder? <type>`
* Query Parameters: See `type` under Command Parameters. In addition, the query also supports `PFN_TOTAL` for `type`. This equals to a multiplication of the divider values given by `PFN_INPUT` and `PFN_INTERNAL`.
* Query Examples: `HELIUM:PULSEform:DIVIder? PFN_INTERNAL`, `HELIUM:PULSEform:DIVIder? PFN_TOTAL`
* Query Return Parameters: Numeric real
* Reset Value: N/A
* ℹ️ The following constraints apply to the divider:
	* `PFN_INPUT`: Minimum is $1$, Maximum is $2048$
	* `PFN_INTERNAL`: Minimum is $1$, Maximum is $32$
* ℹ️ The following table summarizes the state of the dividers when source clock is internal:
  ||`PFN_INPUT` |`PFN_INTERNAL` |
  |-|-|-|
  |$F_{pulse} \lt 9.765625\text{MHz}$ |$\text{ceil to next power of 2 of }(\frac{9.765625\text{MHz}}{F_{pulse}})$ |$32$ |
  |$9.765625\text{MHz} \leq F_{pulse} \lt 19.53125\text{MHz}$ |$1$ |$32$ |
  |$19.53125\text{MHz} \leq F_{pulse} \lt 39.0625\text{MHz}$ |$1$ |$16$ |
  |$39.0625\text{MHz} \leq F_{pulse} \lt 78.125\text{MHz}$ |$1$ |$8$ |
  |$78.125\text{MHz} \leq F_{pulse} \lt 156.25\text{MHz}$ |$1$ |$4$ |
  |$156.25\text{MHz} \leq F_{pulse} \lt 312.5\text{MHz}$ |$1$ |$2$ |
  |$312.5\text{MHz} \leq F_{pulse} \leq 625\text{MHz}$ |$1$ |$1$ |
  |$F_{pulse} \gt 625\text{MHz (Impulse)}$ |$1$ |$1$ |

#### `HELIUM:PULSEform:CFGFREQintclksource?`
This query returns the configuration of the internal source clock and dividers required for synthesizing the given pulse frequency.
* Query Syntax: `HELIUM:PULSEform:CFGFREQintclksource? <INT_SRC_CLK_FREQ|PFN_INPUT_DIVIDER|PFN_INTERNAL_DIVIDER|PFN_TOTAL_DIVIDER>, <pulse_freq>`
* Query Parameters: `INT_SRC_CLK_FREQ|PFN_INPUT_DIVIDER|PFN_INTERNAL_DIVIDER|PFN_TOTAL_DIVIDER` to individually return each option
* Query Examples: `HELIUM:PULSEform:CFGFREQintclksource? INT_SRC_CLK_FREQ, 400MHz`, `HELIUM:PULSEform:CFGFREQintclksource? PFN_INPUT_DIVIDER, 400MHz`
* Query Return Parameters: Numeric real
* Reset Value: N/A

#### `HELIUM:PULSEform:FREQintclksource`
This command configures the pulse frequency and is supported only when the clock source is configured to internal. If no units are specified, the default is Hz.
* Command Syntax: `HELIUM:PULSEform:FREQintclksource <value>`
* Command Parameters: Extended numeric
* Command Examples: `HELIUM:PULSEform:FREQintclksource 150MHz`, `HELIUM:PULSEform:FREQintclksource MIN`, `HELIUM:PULSEform:FREQintclksource MAX`
* Reset Value: N/A
* ℹ️ The following constraints apply to the pulse frequency:
	* The pulse frequency resolution is the higher between $1\text{PPB}$ and $0.3\text{Hz}$
	* Minimum is $312.5\text{MHz}/(2048 \cdot 32) = 4768.4\text{Hz}$
	* Maximum is $3\text{GHz}$

#### `HELIUM:PULSEform:FREQ?`
This query returns the **non-gated (gate equals `PASS_ALL`)** pulse frequency.
* Query Syntax: `HELIUM:PULSEform:FREQ?`
* Query Parameters: None
* Query Examples: `HELIUM:PULSEform:FREQ?`
* Query Return Parameters: Numeric real in Hz
* Reset Value: N/A
* ℹ️ If the non-gated pulse frequency is unknown the query `HELIUM:PULSEform:FREQ?` will trigger a measurement process which will delay the response by a few hundereds of milliseconds

#### `HELIUM:PULSEform:ALIGn`
This command aligns the pulse forming network.\
**ℹ️ This is an asynchronous operation. Synchronization methods such as the `*WAI` command, `*OPC?` command or polling should be used after invoking it**
* Command Syntax: `HELIUM:PULSeform:ALIGn`
* Command Parameters: None
* Command Examples: `HELIUM:PULSEform:ALIGn`
* Query Syntax: `HELIUM:PULSEform:ALIGn?`
* Query Parameters: None
* Query Examples: `HELIUM:PULSEform:ALIGn?`
* Query Return Parameters: Numeric real (`1` or `0`)
* Reset Value: N/A

#### `HELIUM:PULSEform:WIDTHADj`
This command configures the pulse width adjustment mode.
* Command Syntax: `HELIUM:PULSEform:PULSeform:WIDTHADj <mode>`
* Command Parameters: mode is discrete parameter `HIGH_RES|LOW_RES`
* Command Examples: `HELIUM:PULSEform:WIDTHADj HIGH_RES`
* Query Syntax: `HELIUM:PULSEform:WIDTHADj? [MAX_FREQ]`
* Query Parameters: Optional, if `MAX_FREQ` is provided with the query the max pulse frequency which allows width adjustment is returned.
* Query Examples: `HELIUM:PULSEform:WIDTHADj?`, `HELIUM:PULSEform:WIDTHADj? MAX_FREQ`
* Query Return Parameters: Discrete parameter
* Reset Value: `HIGH_RES`

#### `HELIUM:PULSEform:WIDTh`
This command configures the output pulse width. If no units are specified, the default is seconds. **Alignment must be performed before setting the pulse width**.
* Command Syntax: `HELIUM:PULSEform:PULSeform:WIDTh <value>`
* Command Parameters: Extended numeric
* Command Examples: `WIDTh 8E-9`, `WIDTh 8ns`, `WIDTh 50ps`, `WIDTh 50us`, `WIDTh MIN`, `WIDTh MAX`
* Query Syntax: `HELIUM:PULSEform:WIDTh? [MIN|MAX|RES]`
* Query Parameters: Optional, if `MIN` or `MAX` are provided with the query, the minimum or maximum pulse width corresponding to the current configuration is returned. If `RES` is provided, the pulse width adjustment resolution is returned. When the query is called without a parameter the actual pulse width is returned
* Query Examples: `HELIUM:PULSEform:WIDTh?`, `HELIUM:PULSEform:WIDTh? MAX`, `HELIUM:PULSEform:WIDTh? RES`
* Query Return Parameters: Numeric real in **seconds**
* Reset Value: N/A
* ℹ️ The following constraints apply to the pulse width adjustment resolution, $W_{res}$, minimum pulse width, $W_{min}$, and maximum pulse width, $W_{max}$, as a function of the adjustment resolution mode (given by `HELIUM:PULSEform:WIDTHADj?`) and the pulse frequency, $F_{pulse}$ (given by `HELIUM:PULSEform:FREQ?`):
  |Resolution mode |$W_{res}$|
  |-|-|
  |High resolution |$1\text{ps}$ |
  |Low resolution |$\frac{1}{D_{pfn\_internal} \cdot F_{pulse}}$<sup>[1][2][3]</sup> |

  |Resolution mode |$W_{min}$|
  |-|-|
  |High resolution |$50\text{ps}$ |
  |Low resolution |$\frac{1}{D_{pfn\_internal} \cdot F_{pulse}}$<sup>[1][2][3]</sup> |

  $W_{max}$ when **$D_{pfn\_internal}$ matches $F_{pulse}$** on the [summary table under `HELIUM:PULSEform:DIVIder`](#heliumpulseformdivider):<sup>[1][2][3]</sup>
  ||$F_{pulse} \lt 9.765625\text{MHz}$ |$9.765625\text{MHz} \leq F_{pulse} \leq 625\text{MHz}$ | $F_{pulse} \gt 625\text{MHz (Impulse)}$ |
  |-|-|-|-|
  |High resolution |$\approx 1200\text{ps}$ |$\approx \frac{1}{2 \cdot F_{pulse}}$ |$50\text{ps}$ |
  |Low resolution |$\frac{1}{2 \cdot F_{pulse}}$ |$\frac{1}{2 \cdot F_{pulse}}$ |$\text{N/A}$ |

  $W_{max}$ when **$D_{pfn\_internal}$ does not match $F_{pulse}$** on the [summary table under `HELIUM:PULSEform:DIVIder`](#heliumpulseformdivider):<sup>[1][2][3][4]</sup>
  ||$F_{pulse} \leq 625\text{MHz}$ | $F_{pulse} \gt 625\text{MHz (Impulse)}$ |
  |-|-|-|
  |High resolution |$\approx 1200\text{ps}$ |$50\text{ps}$ |
  |Low resolution |$\frac{1}{2 \cdot F_{pulse}}$<sup>[1]</sup> |$\text{N/A}$ |

  <sup>[1]</sup>As long as the divider given by `HELIUM:PULSEform:DIVIder? PFN_INTERNAL` is larger than $1$, otherwise a pulse cannot be formed\
  <sup>[2]</sup>$D_{pfn\_internal}$ is given by `HELIUM:PULSEform:DIVIder? PFN_INTERNAL`\
  <sup>[3]</sup>When source clock is internal, $D_{pfn\_internal}$ is pre-determined based on the table described under [`HELIUM:PULSEform:DIVIder`](#heliumpulseformdivider)
  <sup>[4]</sup>This state can only occur when the source clock is external

* ℹ️ **When the source clock is external, the pulse width setting accuracy highly depends on the duty cycle distortion from $50\%$ of the input external clock**


#### `HELIUM:PULSEform:WIDTHReset`
This command resets the output pulse width to null.
* Command Syntax: `HELIUM:PULSeform:WIDTHReset`
* Command Parameters: None
* Command Examples: `HELIUM:PULSEform:WIDTHReset`
* Reset Value: N/A

#### `HELIUM:PULSEform:GATE`
This command configures the gate function. The `pass` parameter specifies how many pulses should be passed while the `block` parameter specifies how many pulses should be blocked. If `type` is `PERIODIC` both parameters should be provided and the output gated waveform will be periodic with a period $P_r = \verb|passed|+\verb|blocked|$ and a duty cycle $D_C = \dfrac{\verb|passed|}{P_r}$. If `type` is `SINGLE_SHOT` then the output gated waveform is single shot and the `block` parameter should not be provided. The parameter `type` can also be `PASS_ALL` (pass all pulses) or `BLOCK_ALL` (block all pulses), in that case the `pass` and `block` paramters should not be provided.\
**ℹ️ This is an asynchronous operation. Synchronization methods such as the `*WAI` command, `*OPC?` command or polling should be used after invoking it**
* Command Syntax: `HELIUM:PULSeform:GATE <type>, [,pass] [,block]`
* Command Parameters: `type` is a discrete parameter `PASS_ALL|BLOCK_ALL|PERIODIC|SINGLE_SHOT`, `pass` and `block` are numeric
* Command Examples: `HELIUM:PULSEform:GATE PERIODIC, 4, 8`, `HELIUM:PULSEform:GATE SINGLE_SHOT, 4`, `HELIUM:PULSEform:GATE PASS_ALL`, `HELIUM:PULSEform:GATE BLOCK_ALL`
* Query Syntax: `HELIUM:PULSEform:GATE? <TYPE|PASS|BLOCK>`
* Query Parameters: `TYPE|PASS|BLOCK` to individually return each command option
* Query Examples: `HELIUM:PULSEform:GATE? TYPE` and `HELIUM:PULSEform:GATE? PASS` and `HELIUM:PULSEform:GATE? BLOCK`
* Query Return Parameters: Discrete parameter for `HELIUM:PULSEform:GATE? TYPE`, numeric real for `HELIUM:PULSEform:GATE? PASS` and `HELIUM:PULSEform:GATE? BLOCK`
* Reset Value: N/A
* ℹ️ The following constraints apply in periodic and single shot modes considering $F_{pulse}$ given by `HELIUM:PULSEform:FREQ?`:
	* $F_{pulse} \geq 312.5\text{MHz}$, periodic and single shot modes are supported when the pulse width is at or below $25\%$ of the pulse period
	* $2500\text{MHz} \geq F_{pulse} \gt 1250\text{MHz}$, the parameters `block` (only relevant in periodic mode) and `pass` must be multiples of $2$ and the period must be a multiple of $16$ or a power of $2$
	* $3000\text{MHz} \geq F_{pulse} \gt 2500\text{MHz}$, the parameters `block` (only relevant in periodic mode) and `pass` must be multiples of $4$ and the period must be a multiple of $32$ or a power of $2$
* ℹ️ The following **additional** constraints apply in **periodic mode when the source clock is external**:
	* Total divider given by `HELIUM:PULSEform:DIVIder? PFN_TOTAL` is $1$: $P_r$ must be a multiple of $8$ or a power of $2$
	* Total divider given by `HELIUM:PULSEform:DIVIder? PFN_TOTAL` is $2$: $P_r$ must be a multiple $2$

### **Output Control Commands And Queries**
#### `HELIUM:OUTPut:ENABle`
This command enables or disables the pulse output.
* Command Syntax: `HELIUM:OUTPut:ENABle <value>`
* Command Parameters: Boolean
* Command Examples: `HELIUM:OUTPut:ENABle 1`, `HELIUM:OUTPut:ENABle ON`, `HELIUM:OUTPut:ENABle OFF`
* Query Syntax: `HELIUM:OUTPut:ENABle?`
* Query Parameters: None
* Query Examples: `HELIUM:OUTPut:ENABle?`
* Query Return Parameters: Numeric boolean
* Reset Value: 0

#### `HELIUM:OUTPut:CLKOutdiv`
This command queries the divider on CLK_OUT output.
* Command Syntax: `HELIUM:OUTPut:CLKOutdiv <value>`
* Command Parameters: Numeric real
* Command Examples: `HELIUM:OUTPut:CLKOutdiv 16`, `HELIUM:OUTPut:CLKOutdiv 2`, `HELIUM:OUTPut:CLKOutdiv MIN`, `HELIUM:OUTPut:CLKOutdiv MAX`
* Query Syntax: `HELIUM:OUTPut:CLKOutdiv?`
* Query Parameters: None
* Query Examples: `HELIUM:OUTPut:CLKOutdiv?`
* Query Return Parameters: Numeric real
* Reset Value: N/A
* ℹ️ The following constraints apply to the divider value:
	* Minimum is $1$
	* Maximum is $32$
	* The divider value must be a power of $2$

### **General State Commands And Queries**
#### `HELIUM:STATE:EMULated?`
* This query returns true if emulation is used instead of real hardware.
* Query Syntax: `HELIUM:STATE:EMULated?`
* Query Parameters: None
* Query Examples: `HELIUM:STATE:EMULated?`
* Query Return Parameters: Numeric boolean
* Reset Value: N/A

#### `HELIUM:STATE:RESET`
This command triggers a reinitializiation routine.
* Command Syntax: `HELIUM:STATE:RESET`
* Command Parameters: None
* Command Examples: `HELIUM:STATE:RESET`
* Reset Value: N/A

#### `HELIUM:STATE:GET?`
This query will return the general state in a single atomic call.
* Query Syntax: `HELIUM:STATE:GET?`
* Query Parameters: None
* Query Examples: `HELIUM:STATE:GET?`
* Query Return Parameters: Mixed, a collection of comma separated queries from this document where each one is followed by its corresponding response. For example:\
`HELIUM:CLK:SOURce?,INT,HELIUM:CLK:FREQ?,400000000,HELIUM:PULSEform:DIVIder? PFN_INTERNAL,4,HELIUM:PULSEform:CFGFREQintclksource?,100000000,HELIUM:PULSEform:ALIGn?,1,HELIUM:PULSEform:WIDTh?,5e-11,HELIUM:PULSEform:WIDTh? MIN,5e-11,HELIUM:PULSEform:WIDTh? MAX,4.97e-09,HELIUM:PULSEform:WIDTh? RES,4.97e-09,HELIUM:PULSEform:WIDTHADj?,HIGH_RES,HELIUM:PULSEform:GATE? TYPE,PASS_ALL,HELIUM:OUTPut:ENABle?,0,HELIUM:OUTPut:CLKOutdiv?,4"`\
Note that if a given state property is invalid, it will not be included in the response.
* Reset Value: N/A

#### `HELIUM:STATE:LISTENevent?`
This query configures a dedicated listener for the issuing controller. The listener will output a message when a state change event has occured. The controller should keep listening and reading from the interface to receive additional messages. Any subsequent commands sent on the interface by the controller will stop its listener.
* Query Syntax: `HELIUM:STATE:LISTENevent?`
* Query Parameters: None
* Query Examples: `HELIUM:STATE:LISTENevent?`
* Query Return Parameters:
	* As soon as the query is issued the `Subscribed` string is returned.
	* A state change event will trigger the message `,1,`
* Reset Value: N/A
* ℹ️ Events will be generated when the following SCPI commands (not queries) are received:
	* The commands `HELIUM:CALIbration:LOAD` and `HELIUM:CALIbration:CLEAR`
	* All commands belong to the node `HELIUM:CLK`
	* All commands belong to the node `HELIUM:PULSeform`
	* All commands belong to the node `HELIUM:OUTPut`

#### `HELIUM:STATE:TEMPerature?`
* This query returns the board temperature.
* Query Syntax: `HELIUM:STATE:TEMPerature?`
* Query Parameters: None
* Query Examples: `HELIUM:STATE:TEMPerature?`
* Query Return Parameters: Numeric real in degree Celsius
* Reset Value: N/A

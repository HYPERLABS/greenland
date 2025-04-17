# The SCPI Language
## **Overview**
SCPI stands for Standard Commands for Programmable devices and it is mainly used for communicating with test and measurement devices. It is an ASCII language that provides a standardized command set for various functions of measurement devices. It is hierarchically ordered in a tree structure and each device is free to implement certain subsystems. The basic syntax is `:INPUt:CLKFreq 1.2GHz`.\
The command set is case-INsensitive. For each command exists a short and a long version. In the example above `:INPU:CLKF 1.2GHz` would be the short version and `:INPUT:CLKFREQ 1.2GHz` would be the long version. In each hierarchy level the short OR the long version can be used, but everything in between is not valid (e.g. `:INPUT:CLKFreq 1.2GHz` is valid but `:INPUT:CLKFre 1.2GHz` is not valid because `CLKFre` is neither the short nor the long version).

## **Command Structure**
There are two types of SCPI messages: program and response.
* A program message consists of one or more properly formatted SCPI commands sent from the controller to the device. The message, which may be sent at any time, requests the device to perform some action.
* A response message consists of data in a specific SCPI format sent from the device to the controller. The device sends the message only when requested from a program message query.

### Data Formats
SCPI defines different data formats for use in program and response messages. It does this to accommodate the principle of forgiving listening and precise talking. For more information on program data types refer to IEEE 488.2. Forgiving listening means the command and parameter formats are flexible. For example, with the `OUTPut:ENABle: <ON|OFF|1|0>` command, the device accepts `OUTPut:ENABle ON`, `OUTPut:ENABle 1`, `OUTP:ENAB ON`, `OUTP:ENAB:STAT 1` to enable its output.\
Each parameter type has one or more corresponding response data types. For example, a setting programed using a numeric parameter returns either a real or an integer response data when queried. The response is more concise and restricted and is called precise talking. Precise talking means that the response format for a particular query is always the same. For example, an output state query using `OUTPut:ENABle?` during a scenario that the output is enabled, will always receive a response of `1`, regardless of whether previously sent commands to enable the output were `OUTPut:ENABle ON` or `OUTPut:ENABle 1`.\
The following table shows responses for a given parameter type:
|Parameter Types |Response Data Types |
|----------------|--------------------|
|Numeric |Real or Integer |
|Extended Numeric |Real or Integer |
|Discrete |Discrete |
|Boolean |Numeric Boolean |
|String | String |

#### Parameter Data Formats
##### Numeric Parameters
Numeric parameters are used in many commands and these commands accept all commonly used decimal representations of numbers including optional signs, decimal points, and scientific notation. If an device setting is programmed with a numeric parameter, which can only assume a finite value, it automatically rounds any entered parameter which is greater or less than the finite value. For example, if a signal generator has a programmable output impedance of $50\varOmega$ or $75\varOmega$, and you specified $76.1\varOmega$ for the output impedance, the value is rounded to $75\varOmega$. The following are examples of numeric parameters: `100`, `-1.23`, `+256`, `.5`, `-7.89E-001`

##### Extended Numeric Parameters
When specifying physical quantities, most commands use extended numeric parameters. Extended numeric parameters accept all numeric parameter values and other special values as well. The following are examples of extended numeric parameters: `100`, `1.2GHz`, `200MHz`.\
The following suffixes are allowed:
* Frequency, `Hz`, `MHz`, `GHz`. If a frequency suffix is not provided, the default is `Hz`
* Time, `s`, `ms`, `us`, `ns`, `ps`. If a time suffix is not provided, the default is `s`

Unless specifically indicated, extended numeric parameters also include the following special parameters:
* `MINimum`, sets the parameter to the smallest possible value
* `MAXimum`, sets the parameter to the largest possible value

##### Discrete Parameters
Discrete parameters use mnemonics to represent each valid setting. They have a long and a short form, just like command mnemonics. You can mix upper and lower case letters for discrete parameters.

##### Boolean Parameters
Boolean parameters represent a single binary condition that is either true or false. The following arguments are acceptable: `ON`, `OFF`, `1`, `0`

##### String Parameters
String parameters allow ASCII strings to be sent as parameters. Single or double quotes are used as delimiters. The following are examples of string parameters: `'This is valid'`, `"This is also valid"`

#### Response Data Formats
##### Real Response Data
Real response data represents decimal numbers in either fixed decimal or scientific notation. Most high-level programming languages that support device input/output (I/O) handle either decimal or scientific notation transparently. The following are examples of real response data:
`+4.000000E+010`, `-2.000000E+004`, `0`

##### Integer Response Data
Integer response data are decimal representations of integer values including optional signs. The following are examples of integer response data: `0`, `+100`, `-100`, `256`

##### Discrete Response Data
Discrete response data are similar to discrete parameters. The main difference is that discrete response data only returns the short form of a particular mnemonic, in all upper case letters.

##### Numeric Boolean Response
Boolean response data returns a binary numeric value of one or zero.

##### String Response Data
String response data is similar to a string parameter. The main difference is that string response data returns double quotes, rather than single quotes. Embedded double quotes may be present in string response data. Embedded quotes appear as two adjacent double quotes with no characters between them. The following are examples of string response data: `"This is a string"`, `"one double quote inside brackets: [""]"`

#### Binary, Decimal, Hexadecimal, and Octal Formats
Command values may be entered using a binary, decimal, hexadecimal, or octal format. When the binary, hexadecimal, or octal format is used, their values must be preceded with the proper identifier. The decimal format (default format) requires no identifier and an device assumes this format when a numeric value is entered without one. The identifiers for the formats that require them are as follows:
* #B identifies the number as a binary numeric value (base-2)
* #H identifies the number as a hexadecimal alphanumeric value (base-16)
* #Q identifies the number as a octal alphanumeric value (base-8)

The following are examples of SCPI command values and identifiers for the decimal value 45:
* #B101101 binary equivalent
* #H2D hexadecimal equivalent
* #Q55 octal equivalent

Response data could also be formatted. Queries, which return data in a format different than decimal, specifically mention it and consistently keep the data format.

### Command Separators
A colon ( `:` ) separates consecutive keywords. You must insert a blank space to separate a parameter from a command keyword. If a command requires more than one parameter, separate adjacent parameters using a comma: `DIVIder PFN_INPUT, 4`. A semicolon ( `;` ) separates commands within the same subsystem and can also minimize typing. For example, the following string: `PULSEform:FREQ?;ALIGn` is equivalent to the following two commands:
```
PULSEform:FREQ?
PULSEform:ALIGn
```
**Use a colon and a semicolon to link commands from different subsystems**. In the following example an error is generated if you do not use both the colon and semicolon: `PULSEform:FREQ?;:OUTPut:ENABle ON`

### Parameter separation
The first whitespace is used to separate the command and the parameters. Each following whitespace is ignored. When using multiple parameters, the individual parameters are separated by a comma `,`. If more (or less) parameters than needed are added to a command, an error (either `-108`, Parameter not allowed or `-109`, Parameter missing) is generated and the command is NOT executed. Some queries do not need parameters. If a parameter is added to a query that does not expect a parameter an error (`-108`, Parameter not allowed) is generated. The expected return value is returned nonetheless, so that the end user gets to see the error message. Otherwise the program could block the execution because a return value is expected and none is received.

### Termination
A new line `\n` character must be sent to the device to terminate a SCPI command string. The IEEE-488 EOI (End-Or-Identify) message is interpreted as a `\n` character and can be used to terminate a command string in place of an `\n`. A carriage return followed by a new line `\r\n` is also accepted. Command string termination will always reset the current SCPI command path to the root level.

### Syntax Conventions
* Square brackets `[]` are used to enclose a parameter that is optional when programming the command. That is, the device shall process the command to have the same effect whether the option node is omitted by the programmer or not.
* Angle brackets `<>` are set to enclose mandatory parameters or to indicate a returned parameter.
* Vertical bar `|` is used to separate multiple parameter choices for the command string.

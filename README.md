# Betaflight Target Configuration Repository

> [!IMPORTANT]
>
> Unified-Targets are being sunsetted in favor of Target Configuration (config.h) files.  Please see https://betaflight.com/docs/development/manufacturer/creating-configuration for creating targets in the https://github.com/betaflight/config repository.

## ATTENTION

Please see the [Manufacturer Guildlines](https://betaflight.com/docs/development/manufacturer/manufacturer-design-guidelines) for hardware certification.

Manufacturers can contact us on [Discord](https://discord.betaflight.com/) to be part of our certification program.


## Manufacturer Design Guidelines

Read the [hardware specification](https://betaflight.com/docs/development/manufacturer/manufacturer-design-guidelines).


## Build API

All targets need to include #defines for drivers to be included for hardware drivers, including accelerometer, gyro and OSD chip (if present).

Note that hardware such as barometer and magnetometer, even if on the hardware, can be activated by the user select MAG or BARO in the configurator, and the system will load all the drivers. 

Please describe in comments what hardware is on the actual board, to assist in future endeavours in managing the cloud build system.

Please update all existing targets. See instructions below for more details.

Betaflight will include a certified flag as new hardware specification requirements will be in place to improve quality. Documentation with more detailed guidelines will be provided on further notice.

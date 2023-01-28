# Betaflight Target Configuration Repository


## ATTENTION

Instructions have been updated as Betaflight requires certification as we are migrating to a new build API.

Manufacturers can contact us on Discord to be part of our certification program.


## Manufacturer Design Guidelines

Read the [hardware specification](https://betaflight.com/docs/manufacturer/manufacturer-design-guidelines).


## Build API

All targets need to include #defines for drivers to be included for hardware drivers, including accelerometer, gyro and OSD chip (if present).

Note that hardware such as barometer and magnetometer, even if on the hardware, can be activated by the user select MAG or BARO in the configurator, and the system will load all the drivers. 

Please describe in comments what hardware is on the actual board, to assist in future endeavours in managing the cloud build system.

Please update all existing targets. See instructions below for more details.

Betaflight will include a certified flag as new hardware specification requirements will be in place to improve quality. Documentation with more detailed guidelines will be provided on further notice.


## Instructions

Please follow [these instructions](https://betaflight.com/docs/manufacturer/creating-an-unified-target) to create and publish a Target configuration.

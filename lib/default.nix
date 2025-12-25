{ lib, ... }:

with lib;

{
  # Create a standard enable option
  mkEnableOpt = description: mkEnableOption description;

  # Create an option with type and default
  mkOpt = type: default: description:
    mkOption {
      inherit type default description;
    };

  # Create a boolean option with default value
  mkBoolOpt = default: description:
    mkOption {
      type = types.bool;
      inherit default description;
    };
}

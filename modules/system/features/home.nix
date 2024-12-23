# TODO: cleanup
{
  config,
  inputs,
  myLib,
  outputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  home-manager = {
    backupFileExtension = "backup";

    extraSpecialArgs = {
      inherit inputs;
      inherit myLib;
      outputs = inputs.self.outputs;
    };

    users =
      builtins.mapAttrs (name: user: {...}: {
        imports = [
          (import user.userConfig)
          outputs.homeManagerModules.default
        ];
      })
      (config.mySystem.home-users);
  };
}
# AfterShot Pro Nix package

This is Nix package for trial version of AfterShot Pro 3. You get 30 days to test it out or enter license key to permanently unlock full functionality.

## Running straight from GitHub with flakes

```sh
nix run github:mprasil/aftershot-nix
```

## Using in NixOS

Add to inputs:

```nix
aftershot.url = "github:mprasil/aftershot-nix";
```

In your nix config:

```nix
environment.systemPackages = [
    inputs.aftershot.packages.${config.nixpkgs.system}.aftershot
];
```

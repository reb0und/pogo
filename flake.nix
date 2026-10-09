{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
		flake-utils.url = "github:numtide/flake-utils";

		iloader.url = "github:nab138/iloader";
	};

	outputs = { self, nixpkgs, flake-utils, iloader, ... }:
		flake-utils.lib.eachDefaultSystem (system: 
		let 
			pkgs = import nixpkgs {
				inherit system;
			};
		in 
		{
			devShells.default = with pkgs; mkShell {
				buildInputs = [
					usbmuxd
					libimobiledevice

					iloader.packages.${system}.iloader
				];

				shellHook = ''
					alias ls=eza
					alias find=fd
					alias cat=bat
				'';
			};
		}
	);
}


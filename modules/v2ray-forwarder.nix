{ lib, pkgs, config, ... }: with lib; let cfg = config.services.v2ray-forwarder; in
{
	options.services.v2ray-forwarder = 
	{
		enable = mkEnableOption "v2ray-forwarder service";
		proxyPort = mkOption { type = types.int; default = 1080; description = "The port of the proxy server"; };
		xmuPort = mkOption { type = types.int; default = 1081; description = "The port of the xmu vpn forwader"; };
		uidExclude = mkOption { type = types.int; default = 1000; description = "The uid to exclude"; };
	};

	config = mkIf cfg.enable
	{
		systemd.services.v2ray-forwarder =
		{
			description = "v2ray-forwarder Daemon";
			after = [ "network.target" ];
			wantedBy = [ "multi-user.target" ];
			environment =
			{
				proxyPort = "${toString cfg.proxyPort}";
				xmuPort = "${toString cfg.xmuPort}";
				uidExclude = "${toString cfg.uidExclude}";
			};
			serviceConfig =
			{
				Type = "simple";
				RemainAfterExit = true;
				ExecStart = "${pkgs.touchix.v2ray-forwarder}/bin/v2ray-forwarder.start";
				ExecStop = "${pkgs.touchix.v2ray-forwarder}/bin/v2ray-forwarder.stop";
			};
		};
	};
}

{ stdenv } : stdenv.mkDerivation rec
{
	pname = "v2ray-forwarder";
	version = "0";
	src = ./.;
	buildInputs = with pkgs; [ ipset iptables iproute2 ];
	nativeBuildInputs = with pkgs; [ makeWrapper ];
	installPhase = ''
		mkdir -p $out/bin
		for script in start stop
		do
			cp ${pname}.$script $out/bin
			chmod +x $out/bin/${pname}.$script
			wrapProgram $out/bin/${pname}.$script --prefix PATH : ${lib.makeBinPath [ ipset iptables iproute2 ]}
		done
	'';
}

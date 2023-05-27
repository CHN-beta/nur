{ stdenv } :
stdenv.mkDerivation rec {
	pname = "v2ray-forwarder";
	version = "0";
	src = ./.;
	buildInputs = with pkgs; [ 

  # 传给 CMake 的配置参数，控制 liboqs 的功能
  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=ON"
    "-DOQS_BUILD_ONLY_LIB=1"
    "-DOQS_USE_OPENSSL=OFF"
    "-DOQS_DIST_BUILD=ON"
  ];

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}
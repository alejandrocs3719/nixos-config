final: prev: {
  autopsy = prev.autopsy.overrideAttrs (old: {
    postUnpack = (old.postUnpack or "") + ''
      # Upstream zip trae CRLF; bash luego revienta con $'\r'
      find "$sourceRoot" -type f \
        \( -name "*.sh" -o -name "*.conf" -o -name "*.cfg" -o -name "*.properties" -o -name "*.ini" \) \
        -print0 | xargs -0 -r sed -i 's/\r$//'
    '';
  });
}


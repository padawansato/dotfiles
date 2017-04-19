zmodload zsh/zprof && zprof

# Add GHC 7.10.3 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/private/var/folders/r0/lyh8j8g91w5d_rgcjgpm1p3r0000gn/T/AppTranslocation/3C9683CF-CEFD-40F8-BBB8-6FD5D46BB413/d/ghc-7.10.3.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi


PATH=$PATH:~/.cabal/bin

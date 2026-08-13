{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lua-language-server

    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    svelte-language-server
    emmet-ls

    ruby-lsp

    nil
  ];
}

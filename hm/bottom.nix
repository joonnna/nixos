{
  programs.bottom = {
    enable = true;
  };

  xdg.configFile."bottom/bottom.toml".text = ''
    [flags]
    enable_gpu = true
    mem_as_value = true

    [[row]]
      [[row.child]]
      type="cpu"
    [[row]]
      ratio=2
      [[row.child]]
        ratio=4
        type="proc"
      [[row.child]]
        ratio=3
        [[row.child.child]]
          type="mem"
        [[row.child.child]]
          type="net"
    [colors]
    highlighted_border_color="Green"
  '';
}

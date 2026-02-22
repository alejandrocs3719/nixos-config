{ config, ... }: # Add 'config' here
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";
      "image/jpeg" = "feh.desktop";
      "image/png" = "feh.desktop";
      "image/gif" = "feh.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
        "libreoffice-writer.desktop";
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";
      "x-scheme-handler/mailto" = "emacsclient-mail.desktop";

      # Default web browser:
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      # Default terminal:
      "x-scheme-handler/terminal" = "alacritty.desktop";

      # Default file manager
      "inode/directory" = [ "nemo.desktop" ];
      "application/x-gnome-saved-search" = [ "nemo.desktop" ];
    };
  };

  # Exports XDG_* environment variables, creates XDG dirs automatically, etc.
  xdg.enable = true;

  home.sessionVariables = {
    TERMINAL = "alacritty"; # Default terminal
  };

  dconf.settings = {
    "org/cinnamon/desktop/default-applications/terminal" = {
      exec = "alacritty";
      exec-arg = "-e";
    };
  };
}

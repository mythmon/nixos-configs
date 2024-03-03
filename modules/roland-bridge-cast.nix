{ pkgs, ... }:

{
  # TODO This is different in Nixos 24.05 https://nixos.wiki/wiki/PipeWire

  environment.etc = let
    json = pkgs.formats.json {};

    makeSink = { name, position }: {
      name = "libpipewire-module-loopback";
      args = {
        "node.description" = "RBC " + name;
        "capture.props" = {
          "node.name" = "RBC_" + name;
          "media.class" = "Audio/Sink";
          "audio.position" = [ "FL" "FR" ];
        };
        "playback.props" = {
          "node.name" = "playback.RBC_" + name;
          "audio.position" = position;
          "target.object" = "alsa_output.usb-Roland_BRIDGE_CAST_3D005D0002504D5930313720-01.pro-output-0";
          "stream.dont-remix" = true;
          "node.passive" = true;
        };
      };
    };
  in {
    "pipewire/pipewire.conf.d/90-roland-bridge-cast.conf".source = json.generate "90-roland-bridge-cast.conf" {
      "context.objects" = [
        (makeSink {name = "chat"; position = [ "AUX0" "AUX1" ]; })
        (makeSink {name = "game"; position = [ "AUX2" "AUX3" ]; })
        (makeSink {name = "mic"; position = [ "AUX4" "AUX5" ]; })
        (makeSink {name = "aux"; position = [ "AUX6" "AUX7" ]; })
      ];
    };
  };
}

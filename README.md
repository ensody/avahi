# Avahi Docker image

This is a simple Avahi Docker image.

The CI automatically checks for updates 3x daily and publishes a new image when necessary. So, this image could be used with podman-auto-update or Watchtower.

## Defaults

There's a [default avahi-daemon.conf](https://github.com/ensody/avahi/blob/main/avahi-daemon.conf).

## Volumes

Usually you can just add one or more service definitions to `/etc/avahi/services`.

For more customization you can add your own `/etc/avahi/avahi-daemon.conf` or override the whole `/etc/avahi` folder.

## Example

This will add a Samba service for auto-discovery on Linux and macOS, including Time Machine support.

```sh
AVAHI_ROOT=/var/data/samba-avahi
mkdir -p "$AVAHI_ROOT/services"
cat > "$AVAHI_ROOT/smb.service" <<EOF
<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_adisk._tcp</type>
    <txt-record>sys=waMa=0,adVF=0x100</txt-record>
    <txt-record>dk0=adVN=TimeMachine,adVF=0x82</txt-record>
  </service>
  <service>
    <type>_smb._tcp</type>
    <port>445</port>
  </service>
</service-group>
EOF

docker run --restart always -d --name samba-avahi --net=host -v "$AVAHI_ROOT/services/:/etc/avahi/services/" ghcr.io/ensody/avahi:latest
```

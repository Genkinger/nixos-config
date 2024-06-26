{...}:{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  boot.initrd.kernelModules = ["vfio_pci" "vfio" "vfio_iommu_type1" "amdgpu"];
  boot.kernelParams = ["amd_iommu=on" "vfio-pci.ids=10de:13c2,10de:0fbb"];
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0600 leah libvirtd -"
  ];
  systemd.services.libvirtd.preStart = let
    qemuHook = pkgs.writeScript "qemu-hook" ''
      #!${pkgs.stdenv.shell}
      if [ "$1" = "Windows" ]; then

         	# Update the following variables to fit your setup
         	GUEST_IP="192.168.122.15"
         	GUEST_PORT="7777"
         	HOST_PORT="7777"

         	if [ "$2" = "stopped" ] || [ "$2" = "reconnect" ]; then
      		${pkgs.iptables}/bin/iptables -D FORWARD -o virbr0 -d  $GUEST_IP -j ACCEPT
      		${pkgs.iptables}/bin/iptables -t nat -D PREROUTING -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
         	fi
         	if [ "$2" = "start" ] || [ "$2" = "reconnect" ]; then
      		${pkgs.iptables}/bin/iptables -I FORWARD -o virbr0 -d  $GUEST_IP -j ACCEPT
      		${pkgs.iptables}/bin/iptables -t nat -I PREROUTING -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
         	fi
      fi
    '';
  in ''
    mkdir -p /var/lib/libvirt/hooks
    chmod 755 /var/lib/libvirt/hooks

    # Copy hook files
    ln -sf ${qemuHook} /var/lib/libvirt/hooks/qemu
  '';
}

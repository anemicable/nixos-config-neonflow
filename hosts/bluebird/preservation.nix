{
  preservation = {
    enable = true;

    preserveAt."/persist" = {
      directories = [
        "/etc/nixos"
        "/var/lib/bluetooth"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      # Preserve user files
      users.mistflow = {
         directories = [
           ".ssh"
           ".mozilla"
           "nixos-config"
         ];
      
         files = [
      
         ];
       };
    };
  };
}

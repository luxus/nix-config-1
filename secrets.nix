let
  bbigras = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP2Eo0xWZ1VPs5iHlDd3j+O+3I1qx4VqDaXpkL6phB6Z";
  users = [ bbigras ];

  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOeKDFWYxxGsWsyL9vs/sIKDTaguQR8MB1KY5jBVk16R";
  vps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJR1xNIAyBg6ghMWmDKEfL+rmuicBLYiIjPhyxspM14f";
  work = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKEfhY66gBDU0xgjaQgm9V991wuxI/R3bm3Yt6Kdv9Au";
  systems = [ desktop ];
in
{
  # "secret1.age".publicKeys = [ user1 system1 ];
  "secret1.age".publicKeys = users ++ systems;
}

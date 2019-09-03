#--- Browsers ---
# --ignorechecksum is not ideal but prevents failure between chrome release and package approval
choco install googlechrome -y --ignorechecksum 
# useful to have ublock even on VMs where I'm not signing into chrome
choco install ublockorigin-chrome -y
choco install firefox -y

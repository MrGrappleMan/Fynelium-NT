# 🔋 Power Configuration ( PowerCfg ) - Energy efficiency

# Fast startup
powercfg /H ON # For fast startup, wear is less

 # Turn screen off after 3 min
powercfg /Change monitor-timeout-ac 3
powercfg /Change monitor-timeout-dc 3

# Disk timeout after 1 min, SSD only system assumed. Harmful for HDDs due to spin-down and thus, wear.
# Saves energy.
powercfg /Change disk-timeout-ac 1 # If the device is a NAS or a file or disk recovery station dealing w/ HDDs, set this to 0.
powercfg /Change disk-timeout-dc 1

# Sleep faster, if this annoys you, disable login requirements after sleep in settings
# Or get a fingerprint reader
powercfg /Change standby-timeout-ac 10 # Sleep after 10 min
powercfg /Change standby-timeout-dc 5 # Sleep after 5 min on battery

# Avoid hibernation in favour of S3 or even S0i3 sleep
# Use hibernation only in critical situations, or your area is prone to power outages.
powercfg /Change hibernate-timeout-ac 360 # Hibernate after 6 hours
powercfg /Change hibernate-timeout-dc 15 # Hibernate after 3 hours on battery

# Power Plan
#powercfg.exe -import "!cd!\powerplan.pow">nul

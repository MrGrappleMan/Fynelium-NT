# 🔋 Power Configuration ( PowerCfg ) - Energy efficiency
powercfg /H ON # For fast startup and getting back to working faster from where you left off
powercfg /Change monitor-timeout-ac 3 # Turn screen off after 3 min while charging
powercfg /Change monitor-timeout-dc 3 # Turn screen off after 3 min on battery
powercfg /Change disk-timeout-ac 1 # Turns drive off after 1 min while charging. If the device is a NAS or a file or disk recovery station dealing w/ HDDs, set this to 0.
powercfg /Change disk-timeout-dc 1 # Turns drive off after 1 min while on battery. Assuming you use SSDs, this will save you A LOT of energy, despite SSDs aready being efficient.
powercfg /Change standby-timeout-ac 0 # Never sleep while charging
powercfg /Change standby-timeout-dc 5 # Sleep after 5 min on battery
powercfg /Change hibernate-timeout-ac 0 # Never hibernate while charging
powercfg /Change hibernate-timeout-dc 15 # Hibernate after 15 min on battery
##powercfg.exe -import "!cd!\powerplan.pow">nul

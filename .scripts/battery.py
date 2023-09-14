power_cfg = open("/sys/class/power_supply/BAT0/charge_control_end_threshold", "w")
power_cfg.write("90");

crontab -r
(crontab -l 2>/dev/null; cat ~/.config/cron/autosave.cron) | crontab -

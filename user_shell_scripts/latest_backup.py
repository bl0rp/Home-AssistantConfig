import os.path, time
print("%s" % time.strftime('%d.%m.%Y %H:%M', time.gmtime(os.path.getmtime("/root/backups"))))

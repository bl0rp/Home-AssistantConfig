import os.path, time
print("%s" % time.ctime(os.path.getmtime("/root/backups")))

/opt/tachyon/bin/tachyon bootstrap-conf $1
/opt/tachyon/bin/tachyon-start.sh worker Mount

tail -f /opt/tachyon/logs/*

/opt/tachyon/bin/tachyon bootstrap-conf $1
/opt/tachyon/bin/tachyon format
/opt/tachyon/bin/tachyon-start.sh local

tail -f /opt/tachyon/logs/*

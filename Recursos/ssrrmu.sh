#!/bin/bash
echo ""
wget -q -O /tmp/ssr https://raw.githubusercontent.com/CuervoCool/chukkmod/main/msg-bar/msg 
cat /tmp/ssr > /tmp/ssrrmu.sh
wget -q -O /tmp/ssr https://raw.githubusercontent.com/CuervoCool/chukkmod/main/Recursos/menu_inst/C-SSR.sh
cat /tmp/ssr >> /tmp/ssrrmu.sh
#curl  https://www.dropbox.com/s/re3lbbkxro23h4g/C-SSR.sh >> 
sed -i "s;VPS•MX;ChuKK-SCRIPT;g" /tmp/ssrrmu.sh
#sed -i "s;@Kalix1;ChuKK-SCRIPT;g" /tmp/ssrrmu.sh
sed -i "s;VPS-MX;chumogh;g" /tmp/ssrrmu.sh
chmod +x /tmp/ssrrmu.sh && bash /tmp/ssrrmu.sh
#sed '/gnula.sh/ d' /tmp/ssrrmu.sh > /bin/ejecutar/crontab

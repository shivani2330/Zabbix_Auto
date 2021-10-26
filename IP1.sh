NOFILE=64
[ -z $1 ] &&  echo "xmlgen.sh <filename>" && exit $NOFILE

myfile=${1}
basefile=$(basename $myfile .txt)

#Construct the frame

header='<?xml version="1.0" encoding="UTF-8"?>
<zabbix_export>
    <version>5.4</version>
    <date>2021-09-29T08:07:42Z</date>'

fmt=' <groups>
        <group>
            <uuid>3123961b07f14dbb8b1b643a3f323d9d</uuid>
            <name>rdpdseu10</name>
        </group>
    </groups>'

body='<hosts>
        <host>
            <host>rdpdseu10-elk-000001</host>
            <name>rdpdseu10-elk-000001</name>'
temp='<templates>
            <template>
                <name>Template Module ICMP Ping</name>
            </template>
      </templates>'
            
grp='<groups>
            <group>
                <name>rdpdseu10</name>
            </group>
    </groups>'     


int='<interfaces>
            <interface>
                <ip>%s</ip>
                <interface_ref>if1</interface_ref>
            </interface>
    </interfaces>
    <inventory_mode>DISABLED</inventory_mode>'

footer=' </host>
    </hosts>
</zabbix_export>'

#Printing
{
printf "%s\n" "$header"
  while read host ip
     do
        printf "$fmt" "$basefile"
        printf "$body" "$host" "$host"
        printf "$temp" 
        printf "$grp" "$basefile"
        printf "$int" "$ip"
     done < "$myfile" 
printf "%s\n" "$footer"
} > $basefile.xml

echo "Output xml is $basefile.xml"

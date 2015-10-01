#/bin/sh

funct_on()
{
	echo "I am function one!" $1 $2
	
	return 10
}

funct_on 123 456

ret=$?

echo $ret
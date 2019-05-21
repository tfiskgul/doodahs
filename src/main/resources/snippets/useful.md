# Useful snippets

## URL encode password with Python

python -c 'import urllib; import getpass; print(urllib.quote_plus(getpass.getpass()))'

## Copy into paste buffer

cat | xsel -b

## TLS info

openssl s_client -connect localhost:8080  
nmap --script +ssl-enum-ciphers -p 8080 localhost

## Perl multi-line replace

perl -0pe 's/match/replacement/smg'

## Maven: Eclipse with docs + sources

mvn eclipse:eclipse -DdownloadSources=true -DdownloadJavadocs=true

## Maven: Skip verification

-Dmaven.test.skip=true -Dfindbugs.skip=true -Dpmd.skip=true  
-Dmaven.javadoc.skip=true

## Limit line length

cut -c 1-80

## Perl print regex group

perl -wne '/([\w]+)/ and print $1'

## Command line trim stdin

awk '{$1=$1};1'

## Docker cleanup

docker system prune

## Parallel tar

tar --use-compress-program=pbzip2

## Exception formatter

(?m)^(?!(\d{4,4}-\d{2,2}-\d{2,2} \d{2,2}:\d{2,2}:\d{2,2}\.\d{3,3})|(\s+at [\n\w\d$\.]+\()|([\w\d\.]+Exception:)|(Caused by: [\w\d\.]+Exception:)|(\s+\.\.\. \d+ common frames omitted)).*?$



There is a inherent access issue with calling remote webpages from within javascript.
Typically you get an error:
"Origin is not allowed by Access-Control-Allow-Origin"

There are many workarounds out there, see:
http://stackoverflow.com/questions/3076414/ways-to-circumvent-the-same-origin-policy

for the javascript in testGet, you can see that a php proxy is applied.

As an exercise, since this script is just accessing a solr index, try to apply the following:

http://skipperkongen.dk/2011/01/11/solr-with-jsonp-with-jquery/


so create a new version of the script that instead of calling the php script, uses
the jsonp style query as shown in the documentation.

For additonal background:
http://wiki.apache.org/solr/SolJSON

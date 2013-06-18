1) first test that you can load testGet.html from apache. (if you're on mac this is maybe through MAMP, and for windows through WAMP)
http://localhost:8888/testGet.html

2) open testGet.html and see that we are using a proxy workaround for access webpages external (see discussion below).

3) copy the html file to a new name and have it make the GET request using the skipper kogen appropriate (described below).

4) Once that is complete you are ready to begin the project!
The goal is to take as input a text string, and call two different services with that string for query expansion.

you will expand a search term based on topics:
http://alchemist.nceas.ucsb.edu/tmosearch/get_results_topic_expansion.php?q=insect%20herbivore

and also expand a search term based on taxonomic classification:
http://data1.tw.rpi.edu/tomcat/VocabularyServer/ServeSparql?term=passeriformes&Submit=Submit&domain=organism&getTree=true&upward=true&level=1
 
Once expansion is done the terms are fed into the service:
http://cn-orc-1.dataone.org/cn/v1/query/solr/?

For example if you search the abstract field just for the term ecology:
https://cn-orc-1.dataone.org/cn/v1/query/solr/?q=abstract:ecology&wt=json&rows=100
you get 4817 results.

if you search the abstract field for ecology or hydrology:
https://cn-orc-1.dataone.org/cn/v1/query/solr/?q=abstract:ecology+OR+hydrology&wt=json&rows=100
you get 13269 results.

see Lucene documentation for more details:
http://lucene.apache.org/core/old_versioned_docs/versions/2_9_1/queryparsersyntax.html

as shown in the current testGet.html, you will output the different result sets in different tables. However, what we want to see if the results that the topic based expansion provides that the taxonomic classication does not, and vice versa. The primary task is to output those as two different result sets. However you implement the calculations of these difference set is up to you, but please do so efficiently. 



--------------------------------------

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

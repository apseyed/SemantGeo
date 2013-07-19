<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
			 xmlns:db="http://drugbank.ca" exclude-result-prefixes="db">
<xsl:output method="text" encoding="UTF-8"/>
<xsl:template match="/">
@prefix drugbank: &lt;http://bio2rdf.org/drugbank:&gt; .
@prefix dcterms: &lt;http://purl.org/dc/terms/&gt; .
@prefix nanopub: &lt;http://www.nanopub.org/nschema#&gt; .
@prefix opm: &lt;http://purl.org/net/opmv/ns#&gt; .
@prefix pav: &lt;http://swan.mindinformatics.org/ontologies/1.2/pav/&gt; .
@prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .
@prefix sio: &lt;http://semanticscience.org/resource/&gt; .
@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix : &lt;http://purl.org/twc/healthdata/source/drugbank/nanopub&gt; .

<xsl:for-each select="db:drugs/db:drug">
{
       :<xsl:value-of select="db:drugbank-id"/> a nanopub:Nanopublication ;
            nanopub:hasAssertion :NanoPub_1_Assertion ;
            nanopub:hasProvenance :NanoPub_1_Provenance .
 
       :<xsl:value-of select="db:drugbank-id"/>_Provenance nanopub:hasAttribution :<xsl:value-of select="db:drugbank-id"/>_Attribution ;
       		nanopub:hasSupporting :<xsl:value-of select="db:drugbank-id"/>_Supporting .
 
       :<xsl:value-of select="db:drugbank-id"/>_Assertion a nanopub:Assertion .
       :<xsl:value-of select="db:drugbank-id"/>_Provenance a nanopub:Provenance .
       :<xsl:value-of select="db:drugbank-id"/>_Attribution a nanopub:Attribution .
       :<xsl:value-of select="db:drugbank-id"/>_Supporting a nanopub:Supporting .
}
:<xsl:value-of select="db:drugbank-id"/>_Assertion {
    drugbank:<xsl:value-of select="db:drugbank-id"/> a sio:drug;
        rdfs:label &quot;<xsl:value-of select="db:name"/>&quot;;
        	dcterms:description &quot;<xsl:value-of select="normalize-space(db:description/text())"/>&quot;;
        	dcterms:substrate &quot;<xsl:value-of select="normalize-space(db:substrate/text())"/>&quot;;
        	dcterms:enzymes &quot;<xsl:value-of select="normalize-space(db:enzymes)"/>&quot;;
        	dcterms:mechanism-of-action &quot;<xsl:value-of select="normalize-space(db:mechanism-of-action/text())"/>&quot;;
        	dcterms:targets &quot;<xsl:value-of select="normalize-space(db:targets)"/>&quot;;
}
:<xsl:value-of select="db:drugbank-id"/>_Attribution {
       	:<xsl:value-of select="db:drugbank-id"/>_Assertion prov:wasAttributedTo &lt;http://drugbank.ca&gt;;
          	dcterms:created &quot;<xsl:value-of select="@created"/>&quot;^^xsd:dateTime .
          	dcterms:updated &quot;<xsl:value-of select="@updated"/>&quot;^^xsd:dateTime .
}
:<xsl:value-of select="db:drugbank-id"/>_Supporting {
		:<xsl:value-of select="db:drugbank-id"/>_Assertion prov:wasDerivedFrom &lt;http://drugbank.ca&gt;;
			dcterms:general-references &quot;<xsl:value-of select="normalize-space(db:general-references/text())"/>&quot;;
}
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>



	
<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY copy "&#169;">
<!ENTITY middot "&#183;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" version="1.0" extension-element-prefixes="date">
  <!-- using encoding="US-ASCII" would make the output compatible with
       both ISO-8859-1 and UTF-8 -->
  <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
  <!-- the root directory for the website -->
  <xsl:param name="root" select="''"/>
  <xsl:template match="html">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </html>
  </xsl:template>
  <xsl:template match="head">
    <head xmlns="http://www.w3.org/1999/xhtml">
      <link rel="stylesheet" type="text/css" href="http://www.documentfoundation.org/themes/tdf/css/layout.css?m=1300292397"/>
      <link rel="stylesheet" type="text/css" href="http://www.documentfoundation.org/themes/tdf/css/typography.css?m=1292094211"/>
      <link rel="stylesheet" type="text/css" href="http://www.documentfoundation.org/themes/tdf/css/form.css?m=1305575430"/>
      <link rel="icon" href="http://www.documentfoundation.org/favicon.ico"/>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="node()"/>
    </head>
  </xsl:template>
  <xsl:template match="body">
    <body xmlns="http://www.w3.org/1999/xhtml">
      <div id="BgContainer">
        <div id="Container">
          <div id="Header">
            <h1>The Document Foundation</h1>
            <p>The home of LibreOffice</p>
          </div>
          <div id="Navigation">
            <ul>
              <li>
                <a href="http://www.documentfoundation.org/" title="Go to the Welcome page" class="link">
                  <span>Welcome</span>
                </a>
              </li>
              <li>
                <a href="http://www.documentfoundation.org/foundation/" title="Go to the The Document Foundation page" class="link">
                  <span>Foundation</span>
                </a>
              </li>
              <li>
                <a href="http://www.documentfoundation.org/develop/" title="Go to the Get Involved Developing LibreOffice page" class="link">
                  <span>Develop</span>
                </a>
              </li>
              <li>
                <a href="http://www.documentfoundation.org/contribution/" title="Go to the Contribute to the Foundation page" class="link">
                  <span>Contribute</span>
                </a>
              </li>
              <li>
                <a href="http://www.documentfoundation.org/supporters/" title="Go to the Our Supporters page" class="link">
                  <span>Supporters</span>
                </a>
              </li>
              <li>
                <a href="http://www.documentfoundation.org/contact/" title="Go to the Contact Us page" class="current">
                  <span>Contact</span>
                </a>
              </li>
              <li>
                <a href="http://www.documentfoundation.org/faq/" title="Go to the Frequently Asked Questions - FAQ page" class="link">
                  <span>FAQ</span>
                </a>
              </li>
            </ul>
          </div>
          <div class="clear">
            <!-- -->
          </div>
          <div id="Layout">
<div class="typography">
              <xsl:copy-of select="@*"/>
              <xsl:apply-templates select="node()"/>
            </div>
          </div>
          <div class="clear">
            <!-- -->
          </div>
        </div>
        <div id="Footer">
          <div class="footerTop">
            <!-- -->
          </div>
          <table>
            <tr>
              <td><a href="/privacy">Privacy Policy</a> | <a href="/imprint">Impressum (Legal Info)</a> | Copyright information: Unless otherwise specified, all text 
     and images on this website are licensed under the <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons 
     Attribution-Share Alike 3.0 License</a>. This does not include the source code of LibreOffice, which is licensed under the GNU Lesser General 
     Public License (<a href="http://www.libreoffice.org/download/license/">LGPLv3</a>).<br/>
     "LibreOffice" and "The Document Foundation" are registered trademarks. Their respective logos and icons are subject to 
     international copyright laws. The use of these therefore is subject to our
     <a href="http://wiki.documentfoundation.org/TradeMark_Policy">trademark policy</a>.
  </td>
            </tr>
          </table>
        </div>
      </div>
    </body>
  </xsl:template>
  <!-- copy elements, adding the XHTML namespace to elements with an
       empty namespace URI -->
  <xsl:template match="*">
    <xsl:choose>
      <xsl:when test="namespace-uri() = ''">
        <xsl:element namespace="http://www.w3.org/1999/xhtml" name="{local-name()}">
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates select="node()"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates select="node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- get rid of processing instructions -->
  <xsl:template match="processing-instruction()">
  </xsl:template>
  <!-- copy everything else -->
  <xsl:template match="node()" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

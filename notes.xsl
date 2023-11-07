<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  <xsl:template match="notes">
    <fo:root font-family="serif" font-size="16pt">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" page-height="297mm" page-width="210mm" margin-top="1cm">
          <fo:region-body margin="1in" />
          <fo:region-before extent="1in" />
          <fo:region-after extent="1in" />
          <fo:region-start extent="1in" />
          <fo:region-end extent="1in" />
        </fo:simple-page-master>
      </fo:layout-master-set>

      <!-- Титульник -->
      <fo:page-sequence master-reference="A4">
        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="right">
            <fo:external-graphic content-width="40pt" content-height="40pt"
              src="https://petrsu.ru/files/user/fdbd9903df09bb6f04f397450a13732b/petrsu_logo_blue_2.png" />
          </fo:block>


          <fo:block font-size="18pt" font-family="serif" text-align="center">
            Petrozavodsk State University
          </fo:block>

          <fo:block font-size="18pt" font-family="serif" text-align="center">
            Software engineering
          </fo:block>

          <fo:block margin-top="55%" />

          <fo:block font-size="24pt" text-align="center">
            Notes
          </fo:block>

          <fo:block margin-top="55%" />

          <fo:block font-size="16pt" font-family="serif" text-align="right">
            Author: Zhidov Nikita
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="A4">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block text-align="right">Notes</fo:block>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="right">
            <fo:page-number/>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <fo:block margin-top="40pt">
            <fo:block margin-bottom="10pt" font-weight="bold" font-size="32pt" text-align="center">Quiz: XML</fo:block>
            <xsl:apply-templates select="note[reference/@xlink:href='XML']" />

            <fo:block margin-top="40pt" margin-bottom="10pt" font-weight="bold" font-size="32pt" text-align="center">Quiz: DTD</fo:block>
            <xsl:apply-templates select="note[reference/@xlink:href='DTD']" />
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="note">
    <fo:block margin-bottom="5pt">
      Date: <fo:inline font-weight="bold"><xsl:value-of select="date"/></fo:inline> |
      Author: <fo:inline font-weight="bold"><xsl:value-of select="author"/></fo:inline> |
      Content: <fo:inline font-weight="bold"><xsl:value-of select="content"/></fo:inline>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
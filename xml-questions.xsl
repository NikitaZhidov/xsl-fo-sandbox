<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:template match="rootElem">
    <fo:root font-family="serif" font-size="16pt">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" page-height="297mm" page-width="210mm" margin-top="1cm">
          <fo:region-body margin="1in" />
          <fo:region-before extent="1in" />
          <fo:region-after extent="1in" />
          <fo:region-start extent="1in" />
          <fo:region-end extent="1in" />
        </fo:simple-page-master>

        <fo:simple-page-master master-name="leftPage" page-height="297mm" page-width="210mm" margin-top="1cm" margin-right="1cm">
          <fo:region-body margin="1in" />
          <fo:region-before extent="1in" />
          <fo:region-after extent="1in" />
          <fo:region-start extent="1in" />
          <fo:region-end extent="1in" />
        </fo:simple-page-master>

        <fo:simple-page-master master-name="rightPage" page-height="297mm" page-width="210mm" margin-top="1cm" margin-left="1cm">
          <fo:region-body margin="1in" />
          <fo:region-before extent="1in" />
          <fo:region-after extent="1in" />
          <fo:region-start extent="1in" />
          <fo:region-end extent="1in" />
        </fo:simple-page-master>

        <fo:page-sequence-master master-name="contents">
          <fo:repeatable-page-master-alternatives>
            <!-- левые страницы -->
            <fo:conditional-page-master-reference page-position="any" odd-or-even="odd" master-reference="leftPage"/>
            <!-- правые страницы -->
            <fo:conditional-page-master-reference page-position="any" odd-or-even="even" master-reference="rightPage"/>
          </fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
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
            XML questions
          </fo:block>

          <fo:block margin-top="55%" />

          <fo:block font-size="16pt" font-family="serif" text-align="right">
            Author: Zhidov Nikita
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <!-- TOC -->
      <fo:page-sequence master-reference="A4">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block text-align="right">Quizzes</fo:block>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="right">
            <fo:page-number/>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="center" font-size="32pt" font-weight="700">Table of contents</fo:block>

          <fo:block margin-top="40pt">
            <xsl:apply-templates mode="hoc" select="quiz" />
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <!-- Вопросы -->
      <fo:page-sequence master-reference="contents">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block text-align="right">Quizzes</fo:block>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="right">
            <fo:page-number/>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="center" font-size="32pt" font-weight="700">Questions</fo:block>

          <fo:block margin-top="40pt">
            <xsl:apply-templates mode="quizzes" select="quiz" />
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <!-- Ответы -->
      <fo:page-sequence master-reference="contents">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block text-align="right">Quizzes</fo:block>
        </fo:static-content>

        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="right">
            <fo:page-number/>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="center" font-size="32pt" font-weight="700">Answers</fo:block>

          <fo:block margin-top="40pt">
            <xsl:apply-templates mode="quizzes-answers" select="quiz" />
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template mode="hoc" match="quiz">
    <fo:block margin-top="6pt">
      <xsl:value-of select="@name"/>
    </fo:block>
  </xsl:template>

  <xsl:template mode="quizzes" match="quiz">
    <fo:block margin-bottom="20pt">
      <fo:block font-size="24pt" margin-bottom="6pt" font-weight="700">
        <xsl:value-of select="@name"/>
      </fo:block>

      <xsl:apply-templates mode="question-q" select="question" />
    </fo:block>
  </xsl:template>

  <xsl:template mode="quizzes-answers" match="quiz">
    <fo:block margin-bottom="20pt">
      <fo:block font-size="24pt" margin-bottom="6pt" font-weight="700">
        <xsl:value-of select="@name"/>
      </fo:block>

      <xsl:apply-templates mode="question-a" select="question" />
    </fo:block>
  </xsl:template>

  <xsl:template mode="question-q" match="question">
    <fo:block margin-bottom="8pt">
      <fo:block font-weight="700">
        <xsl:value-of select="position()"/>. <xsl:value-of select="question-text"/>
      </fo:block>

      <xsl:for-each select="answer-options/answer-option">
        <fo:block>
          <xsl:value-of select="position()"/>) <xsl:value-of select="."/>
        </fo:block>
      </xsl:for-each>
    </fo:block>
  </xsl:template>

  <xsl:template mode="question-a" match="question">
    <fo:block>
      <fo:inline>
        <xsl:value-of select="position()"/>. <xsl:value-of select="question-text"/> -
      </fo:inline>

      <fo:inline font-weight="700">
        <xsl:value-of select="correct-answer"/>
      </fo:inline>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
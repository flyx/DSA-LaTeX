%% dsa.cls
%% Copyright 2014 Felix Krause <contact@flyx.org>
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Felix Krause
%
% This work consists of the dsa.cls, fanpaket-setup.sh and fanpaket-setup.ps1.
% Other accompanying files may have different licenses, see their source code
% for details

\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{dsa}[2014/02/06 v0.1]

\newif\if@wallpaper\@wallpapertrue

\DeclareOption{nowallpaper}{
    \@wallpaperfalse
}
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{scrartcl}
}

\ProcessOptions

\LoadClass[a4paper, fontsize=11pt]{scrartcl}

\usepackage[top=1.5cm, bottom=1.5cm, left=2.1cm, right=1.5cm]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package imports
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% language stuff

\usepackage{polyglossia}
\setdefaultlanguage{german}

% font stuff

\usepackage{xunicode}
\usepackage{fontspec}
\usepackage{titlesec}

\setlength{\parindent}{0pt}
\setlength{\parskip}{7pt} 

% coloring, drawing, picturing

\usepackage[table]{xcolor}
\usepackage{pgf}
\usepackage{wallpaper}
\usepackage{graphicx}

% eforms (optional)

\usepackage[hidelinks, unicode]{hyperref}
\IfFileExists{eforms.sty}{
   \usepackage[xetex,useui]{eforms}
   \everyTextField{\textFont{GaramondNo8}\textSize{12}\W{0}}
   \everyComboBox{\textFont{GaramondNo8}\textSize{12}\W{0}}
   \newcommand{\dsaTextInput}[3][12]{\textField[\ui{textsize={##1}}]{##2}{##3}{18pt}}
}{}

% font in TOC

\usepackage{tocloft}
\renewcommand{\cfttoctitlefont}{\dsaHeadingFont}
\renewcommand{\cftsecfont}{\dsaHeadingFont}

% misc

\usepackage{environ}
\usepackage{multicol}

% tabulars

\usepackage{makecell}
\usepackage{tabu}

% graphics

\usepackage{tikz}
\usepackage{calc}
\usetikzlibrary{positioning,fit,calc}

% default side images

\newcommand{\dsaSetDefaultPageBorders}{
   \ULCornerWallPaper{}{fanpaket/balken-links.png}
   \URCornerWallPaper{}{fanpaket/balken-rechts.png}
}
\dsaSetDefaultPageBorders

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% font selection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\dsaSectionStyle}{\Huge\bfseries}
\newcommand{\dsaSubsectionStyle}{\Large\bfseries}

\newcommand{\dsaSetHeadingFont}[1]{
   \newfontfamily\dsaHeadingFont{#1}
   \titleformat{\section}%
      {\dsaHeadingFont\dsaSectionStyle} % format
      {} % label
      {10pt} % sep
      {} % before
      [\normalfont] % after
   \titleformat{\subsection}%
      {\dsaHeadingFont\dsaSubsectionStyle}%
      {}
      {10pt}
      {}
      [\normalfont]
}

\setmainfont{GaramondNo8}
\dsaSetHeadingFont{Manson}
\newfontfamily{\mansontt}{Manson}
\DeclareTextFontCommand{\textmansontt}{\mansontt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength\dsaOldParindent
\newenvironment{dsaCharacterSheet}{
   \pagebreak
   \onecolumn
   \dsaHeadingFont\bfseries
   \newgeometry{top=0.5cm, bottom=0.5cm, left=1cm, right=1cm}
   \setlength{\dsaOldParindent}{\parindent}
   \setlength{\parindent}{0pt}
   \ClearWallPaper
   \if@wallpaper%
       \IfFileExists{fanpaket/wallpaper.png}{
          % wallpaper image is bigger than actual page
          \setlength{\wpXoffset}{-0.3cm}
          \setlength{\wpYoffset}{-0.1cm}
          \ThisCenterWallPaper{1.0275}{fanpaket/wallpaper.png}
       }{}
   \fi
   
   \titleformat{\section}%
      {\dsaHeadingFont\Huge\bfseries\centering} % format
      {} % label
      {6pt} % sep
      {} % before
      [\normalfont] % after
   \titleformat{\subsection}%
      {\dsaHeadingFont\LARGE\bfseries\centering} % format
      {} % label
      {3pt} % sep
      {} % before
      [\normalfont] % after
}{
   \newpage
   \restoregeometry
   \normalfont
   \dsaSetDefaultPageBorders
   \setlength{\parindent}{\dsaOldParindent}
}

\newsavebox\blockbox
\NewEnviron{dsaSheetBox}[1][\textwidth]{%
  \begin{lrbox}{\blockbox}%
    \noindent\hspace{\fboxsep}\begin{minipage}{#1-2\fboxsep}
      \vspace{\fboxsep}%
      \BODY%
      \vspace{.66\fboxsep}%
    \end{minipage}%
  \end{lrbox}
  \noindent
  \begin{tikzpicture}
    \node[text width=#1,fill=white,fill opacity=0.4,text opacity=1,outer sep=0pt,inner sep=0pt](textwidth){\usebox\blockbox};
    % Rahmen oben
    \fill[black!60] (textwidth.north west) -- ($(textwidth.north west) + (0.02,-0.02)$) -- ($(textwidth.north east) - (0.02,0.02)$) -- (textwidth.north east) -- cycle;
    \fill[black!80] ($(textwidth.north west) + (0.02,-0.02)$) -- ($(textwidth.north west) + (0.08, -0.08)$) -- ($(textwidth.north east) - (0.08, 0.08)$) -- ($(textwidth.north east) - (0.02, 0.02)$) -- cycle;
    \fill[black!90] ($(textwidth.north west) + (0.08,-0.08)$) -- ($(textwidth.north west) + (0.1, -0.1)$) -- ($(textwidth.north east) - (0.1, 0.1)$) -- ($(textwidth.north east) - (0.08, 0.08)$) -- cycle;
    % Rahmen links
    \fill[black!60] (textwidth.north west) -- ($(textwidth.north west) + (0.02,-0.02)$) -- ($(textwidth.south west) + (0.02,0.02)$) -- (textwidth.south west) -- cycle;
    \fill[black!80] ($(textwidth.north west) + (0.02,-0.02)$) -- ($(textwidth.north west) + (0.08, -0.08)$) -- ($(textwidth.south west) + (0.08, 0.08)$) -- ($(textwidth.south west) + (0.02, 0.02)$) -- cycle;
    \fill[black!90] ($(textwidth.north west) + (0.08,-0.08)$) -- ($(textwidth.north west) + (0.1, -0.1)$) -- ($(textwidth.south west) + (0.1, 0.1)$) -- ($(textwidth.south west) + (0.08, 0.08)$) -- cycle;
    % Rahmen rechts
    \fill[black!90] (textwidth.south east) -- ($(textwidth.south east) - (0.02,-0.02)$) -- ($(textwidth.north east) - (0.02,0.02)$) -- (textwidth.north east) -- cycle;
    \fill[black!80] ($(textwidth.south east) - (0.02,-0.02)$) -- ($(textwidth.south east) - (0.08, -0.08)$) -- ($(textwidth.north east) - (0.08, 0.08)$) -- ($(textwidth.north east) - (0.02, 0.02)$) -- cycle;
    \fill[black!60] ($(textwidth.south east) - (0.08,-0.08)$) -- ($(textwidth.south east) - (0.1, -0.1)$) -- ($(textwidth.north east) - (0.1, 0.1)$) -- ($(textwidth.north east) - (0.08, 0.08)$) -- cycle;
    % Rahmen unten
    \fill[black!90] (textwidth.south east) -- ($(textwidth.south east) - (0.02,-0.02)$) -- ($(textwidth.south west) + (0.02,0.02)$) -- (textwidth.south west) -- cycle;
    \fill[black!80] ($(textwidth.south east) - (0.02,-0.02)$) -- ($(textwidth.south east) - (0.08, -0.08)$) -- ($(textwidth.south west) + (0.08, 0.08)$) -- ($(textwidth.south west) + (0.02, 0.02)$) -- cycle;
    \fill[black!60] ($(textwidth.south east) - (0.08,-0.08)$) -- ($(textwidth.south east) - (0.1, -0.1)$) -- ($(textwidth.south west) + (0.1, 0.1)$) -- ($(textwidth.south west) + (0.08, 0.08)$) -- cycle;
  \end{tikzpicture}
}

\newenvironment{dsaTitlePage}{
   \onecolumn
   \ClearWallPaper
   \ThisULCornerWallPaper{}{fanpaket/balken-symbole-links.png}
   \ThisURCornerWallPaper{}{fanpaket/balken-symbole-rechts.png}
   \centering
   \includegraphics[width=12cm]{fanpaket/logo-fanprodukt.png}
   \vfill
   \dsaHeadingFont
}{
   \vfill
   \normalfont
   {\tiny Dieses Dokument verwendet Grafiken aus dem DSA-Fanpaket der Ulisses Medien \& Spiel Distribution GmbH.}
   \newpage
   \dsaSetDefaultPageBorders
}

\newlength{\dsaBoxLeftPadding}
\newlength{\dsaBoxRightPadding}
\newlength{\dsaBoxTopPadding}
\newlength{\dsaBoxBottomPadding}
\setlength{\dsaBoxLeftPadding}{12pt}
\setlength{\dsaBoxRightPadding}{14pt}
\setlength{\dsaBoxTopPadding}{7pt}
\setlength{\dsaBoxBottomPadding}{14pt}
\newcommand{\dsaBoxPadding}{\dsaBoxLeftPadding+\dsaBoxRightPadding}

\newsavebox\langscapeSafebox
\newenvironment{dsaBoxLandscape}[1][\linewidth]{%
  \vspace{4pt}
  \def\imgcmd{%
    \includegraphics[
      width=\dimexpr\wd\langscapeSafebox+\dsaBoxPadding\relax,
      height=\dimexpr\ht\langscapeSafebox+\dp\langscapeSafebox+\dsaBoxTopPadding+\dsaBoxBottomPadding\relax
    ]{fanpaket/kasten-halbseiter.png}}%
  \begin{lrbox}{\langscapeSafebox}%
  \begin{minipage}{#1 - \dsaBoxLeftPadding - \dsaBoxRightPadding}
}{%
   \centering%
   \end{minipage}
   \end{lrbox}%
   \noindent
   \makebox[0pt][l]{%
     \raisebox{\dimexpr-\dp\langscapeSafebox-\dsaBoxBottomPadding}{\imgcmd}%
   }%
   \hspace{\dsaBoxLeftPadding}
   \usebox\langscapeSafebox
}

\newsavebox\langscapeSmallSafebox
\newenvironment{dsaBoxLandscapeSmall}[1][\linewidth]{%
  \vspace{4pt}
  \def\imgcmd{%
    \includegraphics[
      width=\dimexpr\wd\langscapeSmallSafebox+\dsaBoxPadding\relax,
      height=\dimexpr\ht\langscapeSmallSafebox+\dp\langscapeSmallSafebox+\dsaBoxTopPadding+\dsaBoxBottomPadding\relax
    ]{fanpaket/kasten-achtelseiter.png}}%
  \begin{lrbox}{\langscapeSmallSafebox}%
  \begin{minipage}{#1 - \dsaBoxLeftPadding - \dsaBoxRightPadding}
}{%
   \centering%
   \end{minipage}
   \end{lrbox}%
   \noindent
   \makebox[0pt][l]{%
     \raisebox{\dimexpr-\dp\langscapeSmallSafebox-\dsaBoxBottomPadding}{\imgcmd}%
   }%
   \hspace{\dsaBoxLeftPadding}
   \usebox\langscapeSmallSafebox
}

\newsavebox\portraitSafebox
\newenvironment{dsaBoxPortrait}[1][\linewidth]{%
  \vspace{4pt}%
  \def\imgcmd{%
    \includegraphics[
      width=\dimexpr\wd\portraitSafebox+\dsaBoxPadding\relax,
      height=\dimexpr\ht\portraitSafebox+\dp\portraitSafebox+\dsaBoxTopPadding+\dsaBoxBottomPadding\relax
    ]{fanpaket/kasten-viertelseiter.png}}%
  \centering%
  \begin{lrbox}{\portraitSafebox}%
  \begin{minipage}{#1 - \dsaBoxLeftPadding - \dsaBoxRightPadding}
}{%
   \end{minipage}
   \end{lrbox}%
   \noindent
   \makebox[0pt][l]{%
     \raisebox{\dimexpr-\dp\portraitSafebox-\dsaBoxBottomPadding}{\imgcmd}%
   }%
   \hspace{\dsaBoxLeftPadding}
   \usebox\portraitSafebox
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Character sheet macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Internal - for making tiny rows in tables
\makeatletter
\newsavebox\saved@arstrutbox
\newcommand*{\setarstrut}[1]{%
  \noalign{%
    \begingroup
      \global\setbox\saved@arstrutbox\copy\@arstrutbox
      #1%
      \global\setbox\@arstrutbox\hbox{%
        \vrule \@height\arraystretch\ht\strutbox
               \@depth\arraystretch \dp\strutbox
               \@width\z@
      }%
    \endgroup
  }%
}
\newcommand*{\restorearstrut}{%
  \noalign{%
    \global\setbox\@arstrutbox\copy\saved@arstrutbox
  }%
}
\makeatother

\newcommand{\dsaRow}[3]{\setarstrut{#1}\rowfont{#2}#3\\ \restorearstrut}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% misc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\dsaBar}[1]{\includegraphics[width=#1, height=0.5em]{images/bar.png}}
\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{dsa}[2014/02/06 v0.1]

\LoadClass[paper=a4, fontsize=11pt]{scrartcl}

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

\IfFileExists{eforms.sty}{
   \usepackage[xetex]{eforms}
   \everyTextField{\textFont{GaramondNo8}\textSize{12}}
   \newcommand{\dsaTextInput}[3][12]{\raisebox{-0.35ex}{\textField[\textSize{##1}]{##2}{##3}{1em}}}
}{}

% misc

\usepackage{environ}
\usepackage{multicol}

%

\usepackage{makecell}
\usepackage{tabu}

% default side images

\ULCornerWallPaper{}{./fanpaket/balken-links.png}
\URCornerWallPaper{}{./fanpaket/balken-rechts.png}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% font selection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\dsaSetHeadingFont}[1]{
   \newfontfamily\dsaHeadingFont{#1}
   \titleformat{\section}%
      {\dsaHeadingFont\Huge\bfseries} % format
      {} % label
      {10pt} % sep
      {} % before
      [\normalfont] % after
   \titleformat{\subsection}%
      {\dsaHeadingFont\Large\bfseries}%
      {}
      {10pt}
      {}
      [\normalfont]
}

\setmainfont{GaramondNo8}
\dsaSetHeadingFont{Manson}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{dsaCharacterSheet}{
   \pagebreak
   \onecolumn
   \dsaHeadingFont\bfseries
   \newgeometry{top=0.5cm, bottom=0.5cm, left=1cm, right=1cm}
   \IfFileExists{./fanpaket/wallpaper.png}{
      \ClearWallPaper
      \ThisCenterWallPaper{1.0}{./fanpaket/wallpaper.png}
   }{
      \ThisULCornerWallPaper{}{./fanpaket/symbol-balken-links.png}
      \ThisURCornerWallPaper{}{./fanpaket/symbol-balken-rechts.png}
   }
   
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
   \pagebreak
   \restoregeometry
   \normalfont
}

\NewEnviron{dsaSheetBox}[1][\linewidth]{
   \begin{center}
      \pgfsetfillopacity{0.5}
      \setlength\fboxrule{2pt}
      \fcolorbox{black}{white}{
         \pgfsetfillopacity{1.0}
         \begin{minipage}{#1}
            \BODY
         \end{minipage}
      }
   \end{center}
}

\newenvironment{dsaTitlePage}{
   \onecolumn
   \ThisULCornerWallPaper{}{./fanpaket/symbol-balken-links.png}
   \ThisURCornerWallPaper{}{./fanpaket/symbol-balken-rechts.png}
   \centering
   \includegraphics[width=12cm]{./fanpaket/logo-fanprodukt.png}
   \vfill
   \dsaHeadingFont
}{
   \vfill
   \pagebreak
   \normalfont
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
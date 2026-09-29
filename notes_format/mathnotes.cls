%% mathnotes.cls
%% Lecture-notes class matching the "Notes Design" mockup.
%% Compile with XeLaTeX or LuaLaTeX (uses fontspec for Source Serif 4 / JetBrains Mono).

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mathnotes}[2026/09/29 math lecture notes]
\LoadClass[11pt]{article}

%% ---- Paragraphs: flush left, no first-line indent ----
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.6em}

%% ---- Page geometry: Letter, narrow margins ----
\RequirePackage[letterpaper,margin=1in]{geometry}

%% ---- Fonts (bundled under notes_format/fonts/) ----
%% Locate this class via kpsewhich (allowed in restricted \write18), then
%% point fontspec at the sibling fonts/ directory. Absolute Path is required:
%% XeTeX does not search TEXINPUTS for OpenType files, and \@filef@und is only
%% the basename when the class is found through TEXINPUTS.
\RequirePackage{expl3}
\ExplSyntaxOn
\sys_get_shell:nnN { kpsewhich ~ mathnotes.cls } { } \l_tmpa_tl
\tl_set:Nx \l_tmpa_tl { \tl_trim_spaces:V \l_tmpa_tl }
\cs_gset:Npx \mathnotes@clsfile { \l_tmpa_tl }
\ExplSyntaxOff
\expandafter\filename@parse\expandafter{\mathnotes@clsfile}
\edef\mathnotes@fontdir{\filename@area fonts/}
\RequirePackage{fontspec}
\setmainfont{SourceSerif4}[
  Path=\mathnotes@fontdir,
  Extension=.otf,
  UprightFont=*-Regular,
  ItalicFont=*-It,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldIt,
]
\setmonofont{JetBrainsMono}[
  Path=\mathnotes@fontdir,
  Extension=.ttf,
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldItalic,
  Scale=0.9,
]

%% ---- Colors (paper tone + accents from the design) ----
\RequirePackage{xcolor}
\definecolor{papertone}{HTML}{FDFCFA}   % warm off-white page
\definecolor{inktext}{HTML}{1A1A1A}     % near-black body text
\definecolor{rulegray}{HTML}{CCCCCC}    % header/footer rule
\definecolor{metagray}{HTML}{595959}    % header/footer text
\definecolor{codebg}{HTML}{262626}      % dark code block background
\definecolor{codefg}{HTML}{E6E6E6}      % code block text
\definecolor{codekw}{HTML}{9B8BD4}      % keyword purple
\definecolor{codefn}{HTML}{74C2DD}      % builtin/function teal

\pagecolor{papertone}
\color{inktext}

%% ---- Header / footer ----
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.6pt}
\renewcommand{\headrule}{\hbox to\headwidth{\color{rulegray}\leaders\hrule height \headrulewidth\hfill}}
\fancyhead[L]{\small\color{metagray}\@course}
\fancyhead[R]{\small\color{metagray}\@notedate}
\fancyfoot[R]{\small\color{metagray}\thepage}

\newcommand{\@course}{}
\newcommand{\course}[1]{\renewcommand{\@course}{#1}}
\newcommand{\@notedate}{\today}
\newcommand{\notedate}[1]{\renewcommand{\@notedate}{#1}}

%% ---- Note title: number + name, bold, no subtitle ----
\newcommand{\notetitle}[2]{%
  \begingroup
  \bfseries\fontsize{18}{22}\selectfont
  #1\quad\quad #2
  \endgroup
  \par\vspace{18pt}
}

%% ---- Definition / Theorem environments ----
\RequirePackage{amsthm}
\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\theoremstyle{remark}
\newtheorem*{remark}{Remark}

%% ---- Code blocks (listings, dark background, two-tone keywords) ----
%% Shared chrome; language-specific keywords live in notes-python / notes-sql.
%% Use \begin{python}...\end{python} or \begin{sql}...\end{sql}.
%% Bare lstlisting stays Python so existing notes keep highlighting.
\RequirePackage{listings}
\lstdefinestyle{notes}{
  backgroundcolor=\color{codebg},
  basicstyle=\ttfamily\small\color{codefg},
  keywordstyle=\color{codekw}\bfseries,
  keywordstyle=[2]\color{codefn},
  showstringspaces=false,
  breaklines=true,
  xleftmargin=18pt,
  xrightmargin=18pt,
  framexleftmargin=18pt,
  framexrightmargin=18pt,
  frame=single,
  framerule=0pt,
  rulecolor=\color{codebg},
  aboveskip=12pt,
  belowskip=12pt,
}
\lstdefinestyle{notes-python}{
  style=notes,
  language=Python,
  morekeywords=[2]{abs,len,range,print,int,float,str,sum,min,max},
}
\lstdefinestyle{notes-sql}{
  style=notes,
  language=SQL,
  morekeywords=[2]{COUNT,SUM,AVG,MIN,MAX,COALESCE,NULLIF,CAST,EXTRACT},
}
\lstset{style=notes-python}
\lstnewenvironment{python}[1][]{\lstset{style=notes-python,#1}}{}
\lstnewenvironment{sql}[1][]{\lstset{style=notes-sql,#1}}{}

%% ---- Math shortcuts used often in these notes ----
\RequirePackage{amsmath,amssymb}
\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\eps}{\varepsilon}

\endinput

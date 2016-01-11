\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{style}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ProcessOptions

\LoadClass{book}

\RequirePackage{fancyhdr}

% Load Standard Packages:
%---------------------------------------------------------------------------
\usepackage[standard-baselineskips]{cmbright}
\usepackage[utf8]{inputenc} 											% encoding
\usepackage[german]{babel} 												% language
\usepackage{textcomp}													% additional symbols
\usepackage{fancyhdr}													% simple manipulation of header and footer 
\usepackage{etoolbox}													% color manipulation of header and footer
\usepackage{graphicx}                      								% integration of images
\usepackage{float}														% floating objects
\usepackage{caption}													% for captions of figures and tables
\usepackage{booktabs}													% package for nicer tables
\usepackage{tocvsec2}													% provides means of controlling the sectional numbering
\usepackage[nottoc]{tocbibind}
\usepackage{subscript}
\usepackage{subfigure}
\usepackage{bbm}
\usepackage{framed}
\usepackage{titlesec}
\usepackage{lastpage}
%---------------------------------------------------------------------------

% Load Math Packages
%---------------------------------------------------------------------------
\usepackage{amsmath}                    	   							% various features to facilitate writing math formulas
\usepackage{amsthm}                       	 							% enhanced version of latex's newtheorem
\usepackage{amsfonts}                      								% set of miscellaneous TeX fonts that augment the standard CM
\usepackage{amssymb}													% mathematical special characters
\usepackage{exscale}													% mathematical size corresponds to textsize
%---------------------------------------------------------------------------

% Package to facilitate placement of boxes at absolute positions
%---------------------------------------------------------------------------
\usepackage[absolute]{textpos}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
%---------------------------------------------------------------------------

% Definition of Colors
%---------------------------------------------------------------------------
\RequirePackage{color}                          						% Color (not xcolor!)
\definecolor{linkblue}{rgb}{0,0,0.8}            						% Standard
\definecolor{darkblue}{rgb}{0,0.08,0.45}        						% Dark blue
\definecolor{grey}{rgb}{0.41,0.49,0.57}      						% grey
%\definecolor{linkcolor}{rgb}{0,0,0.8}     								% Blue for the web- and cd-version!
\definecolor{linkcolor}{rgb}{0,0,0}        								% Black for the print-version!
\definecolor{orange}{rgb}{1,0.5,0}
\definecolor{green}{rgb}{0.09,0.49,0.211}
\definecolor{violet}{rgb}{0.6,0.4,0.8}
%---------------------------------------------------------------------------

% Hyperref Package (Create links in a pdf)
%---------------------------------------------------------------------------
\usepackage[
	pdftex,ngerman,bookmarks,plainpages=false,pdfpagelabels,
	backref = {false},													% No index backreference
	colorlinks = {true},                  								% Color links in a PDF
	hypertexnames = {true},               								% no failures "same page(i)"
	bookmarksopen = {true},               								% opens the bar on the left side
	bookmarksopenlevel = {0},             								% depth of opened bookmarksa
	linkcolor = {linkcolor},              								% Color of Links
	citecolor = {linkcolor},              								% Color of Cite-Links
	urlcolor = {linkcolor},               								% Color of URLs
]{hyperref}

%---------------------------------------------------------------------------
% Set up page dimension
%---------------------------------------------------------------------------
\usepackage{geometry}
\geometry{
	a4paper,
	left=28mm,
	right=15mm,
	top=30mm,
	headheight=20mm,
	headsep=10mm,
	textheight=242mm,
	footskip=15mm
}

% Set up header and footer
%---------------------------------------------------------------------------
\makeatletter

\pagestyle{fancy}
\lhead{\type}
\chead{\thechapter\space\rightmark}
\rhead{\mydate}
\lfoot{\myfield}
\cfoot{\myname}
\rfoot{\thepage / \pageref*{LastPage}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
\patchcmd{\@fancyhead}{\rlap}{\color{grey}\rlap}{}{}					% new color of header
\patchcmd{\@fancyfoot}{\rlap}{\color{grey}\rlap}{}{}					% new color of footer
\patchcmd{\chapter}{plain}{fancy}{}{}

\renewcommand{\chaptermark}[1]{\markright{#1}}
\renewcommand{\sectionmark}[1]{}
\renewcommand{\subsectionmark}[1]{}


\fancypagestyle{titlepage}{
	\fancyhf{}
	\fancyfoot[C]{Berner Fachhochschule | Haute école spécialisée bernoise | Bern University of Applied Sciences}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{toc}{
	\fancyhead[C]{\contentsname}
	\fancyfoot[R]{\thepage}
}


\def\@makechapterhead#1{%
\vspace*{30\p@}%
\hbox{%	
    \huge 
    %\hspace{-0.5cm}%
    \bfseries\thechapter
    \hspace{0.2cm}\hbox{#1}%
}\par\vskip 1cm}
\def\@makeschapterhead#1{%
    \vspace*{30\p@}%
\hbox{%
    \bfseries\huge 
    \hbox{#1}%
}\par\vskip 1cm}

\makeatother

%---------------------------------------------------------------------------

\setlength{\parindent}{0pt}												% no indent for new paragraph
\settocdepth{section}													% Set depth of toc
\input{title.tex} 													% title template
\endinput
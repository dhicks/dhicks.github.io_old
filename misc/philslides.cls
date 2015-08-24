% This extremely underdocumented class, based on Beamer, does some basic formatting and provides a kit of macros useful in philosophy lectures.  
% summary list of macros:  
% highlighting
	% \blue{}
	% \green{}
	% \red{}
	% \technical{} -- based on \alert
	% \yellow{}
	% \burl{} -- boxed URLs
	% \bhref{link}{text} -- boxed hyperlinks
% symbols and spaces
	% \hence
	% \blank -- a one-line blank space
% slide types
	% \argument[listtype]{frametitle}{list} -- a slide with an argument (or other list)
	% \announcements{list}
	% \firstslide{title}{date} -- the title frame
	% \interpret[glossframe#]{frametitle}{quote}{gloss} -- quote, then gloss
	% \lasttime{list}
	% \pic[caption]{frametitle}{jpeg}
% slide elements
	% \bio{name}{pic}{list} -- some basic information about the philosopher
	% \bioflip{name}{pic}{list} -- as \bio, with the picture on the right
	% \class -- container for name of the class
	% \diagram{TiKZ picture}
	% \instructor -- container for the instructor's name, &c.
	% \piclist{pic}{list} -- pic on left, list on right
	% \piclistflip{pic}{list} -- pic on right, list on left
	% \picquote{pic}{quote}
	% \picquoteflip{jpeg}{quote}
	% \threecolumns{left}{center}{right}
	% \twocolumns{left}{right}
% package options
	% footname -- add \instructor to the footer of each slide
	% footnums -- add a frame counter to the footer of each slide

\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{philslides}[2012/25/07  v0.2 Philosophy Slides]

% Based on Beamer; most options are just passed along directly to Beamer
\LoadClass{beamer}
%\RequirePackage{etex}  % TO-DO:  figure out what this was for
\RequirePackage{tikz}
\RequirePackage{ifthen}
\RequirePackage[normalem]{ulem}

\newboolean{footname}
	\setboolean{footname}{false}
\DeclareOption{footname}{\setboolean{footname}{true}}
\newboolean{footnums}
	\setboolean{footnums}{true}
\DeclareOption{nofootnums}{\setboolean{footnums}{false}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions

% Beamer themes  -------------------------------------------
% Beamer's \usetheme and similar macros call packages.  So they can't be used before or after \ProcessOptions.  These lines set up a `default' theme that I like for teaching; they can be overridden simply by using \usetheme, &c., in the document preamble.  

%\usetheme{Rochester}
\input beamerthemeRochester.sty
%\usecolortheme{sidebartab}
\input beamercolorthemesidebartab.sty
%\useinnertheme{rounded}
\input beamerinnerthemerounded.sty
%\usecolortheme{rose}
\input beamercolorthemerose.sty
%\usecolortheme{dolphin}
\input beamercolorthemedolphin.sty

% Macros -------------------------------------------------------

% Modifications to hyperref macros
\newcommand{\bhref}[2]{\href{#1}{\uline{#2}}}
\newcommand{\burl}[1]{\uline{\url{#1}}}

% New package macros
\newcommand{\blue}[1]{\textcolor{blue}{#1}}
	\definecolor{DarkGreen}{cmyk}{1,0,1,0.05}
\newcommand{\green}[1]{\textcolor{DarkGreen}{\textbf{#1}}}
	\definecolor{DarkYellow}{cmyk}{0,0,1,0}
	\definecolor{Gray}{cmyk}{0,0,0,.2}
	\definecolor{purple}{rgb}{1,0,1}
\newcommand{\purple}[1]{\textcolor{purple}{{#1}}}
\newcommand{\gray}[1]{\textcolor{gray}{{#1}}}
\newcommand{\grey}[1]{\gray{#1}}
%\newcommand{\yellow}[1]{\colorbox{Gray}{\textcolor{DarkYellow}{\textbf{#1}}}}
%\newcommand{\yellow}[1]{\fcolorbox{Gray}{DarkYellow}{#1}}
\newcommand{\technical}[1]{\alert{#1}}
\newcommand{\red}[1]{\technical{#1}}
\newcommand{\hence}{\ensuremath{\therefore}~}
\newcommand{\blank}{\vspace{\baselineskip}}

\newcommand{\instructor}{\bhref{mailto:dhicks1@nd.edu}{Dan Hicks}}
\newcommand{\class}{Intro to Philosophy, Fall 2011}

\newcommand{\firstslide}[2]{
	\title{#1}
	\date
	{
		\class\\
		\instructor\\
		#2
	}
	\frame{\titlepage}
	
	\setcounter{framenumber}{0}
	\setbeamertemplate{footline}
	{
		\vspace{-1\baselineskip}
		\ifthenelse
			{\boolean{footnums}}
			{\qquad \fbox{\insertframenumber}}
			{}
		\ifthenelse
			{\boolean{footname}}
			{\qquad {\instructor}}
			{}
	}
}

\newcommand{\lasttime}[1]{
	\frame
	{
		\frametitle{Last Time}
		\begin{itemize}
		#1
		\end{itemize}
	}
}

\newcommand{\argument}[3][enumerate]{
	\frame
	{
		\frametitle{#2}
		\begin{#1}
		#3
		\end{#1}
	}
}
	
\newcommand{\announcements}[1]{
	\section{Announcements}
	\frame
	{
		\frametitle{Announcements}
		\begin{itemize}
		#1
		\end{itemize}
	}
}

%\newcommand{\twocolumns}[2]{
%	\begin{center}
%	\begin{tabular}{p{2in}p{2in}}
%	#1 & #2
%	\end{tabular}
%	\end{center}
%}

\newcommand{\twocolumns}[2]{
	\begin{columns}
	\begin{column}{.5\textwidth}
	#1
	\end{column}
	\begin{column}{0.5\textwidth}
	#2
	\end{column}
	\end{columns}
}

%\newcommand{\threecolumns}[3]{
%	\begin{center}
%	\begin{tabular}{p{1.3in}p{1.3in}p{1.3in}}
%	#1 & #2 & #3
%	\end{tabular}
%	\end{center}
%}

\newcommand{\threecolumns}[3]{
	\begin{columns}
	\begin{column}{0.33\textwidth}
	#1
	\end{column}
	\begin{column}{0.33\textwidth}
	#2
	\end{column}
	\begin{column}{0.33\textwidth}
	#3
	\end{column}
	\end{columns}
}

\newcommand{\pic}[3][]{
	\frame
	{
		\frametitle{#2}
		\center
		\includegraphics[width=\textwidth, height=.9\textheight, keepaspectratio=true]{#3}\\
		{\tiny #1}
	}
}
	
\newcommand{\piclist}[3][]{
	\twocolumns
		{\center\includegraphics[width=\textwidth, height=\textheight, keepaspectratio=true]{#2}\\ {\tiny #1}}
		{
			\begin{itemize}
			#3
			\end{itemize}
		}
}

\newcommand{\piclistflip}[2]{
	\twocolumns
		{
			\begin{itemize}
			#2
			\end{itemize}
		}
		{\includegraphics[width=\textwidth]{#1}}
}

\newcommand{\picquote}[2]{
	\twocolumns
	{\includegraphics[width=\textwidth]{#1}}
	{
		\begin{quote}
		#2
		\end{quote}
	}
}

\newcommand{\picquoteflip}[2]{
	\twocolumns
	{
		\begin{quote}
		#2
		\end{quote}
	}
	{\includegraphics[width=\textwidth]{#1}}
}

\newcommand{\bio}[3]{
	\frame
	{
		\frametitle{#1}
		\piclist{#2}{#3}
	}
}

\newcommand{\bioflip}[3]{
	\frame
	{
		\frametitle{#1}
		\piclistflip{#2}{#3}
	}
}

\newcommand{\interpret}[4][2]{
	\frame
	{
		\frametitle{#2}
		\begin{quote}
		#3
		\end{quote}
		\onslide<#1->
%		\begin{center}
		#4
%		\end{center}
	}
}

\newcommand{\diagram}[1]
{
	\noindent\makebox[\textwidth]
	{
		\begin{center}
		\begin{tikzpicture}
			{#1}
		\end{tikzpicture}
		\end{center}
	}
}
	
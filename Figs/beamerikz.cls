% A class allowing to create purely TikZ based Beamer presentations.
%
% author: Michal Skrzypczak
% http://www.mimuw.edu.pl/~mskrzypczak
% e-mail: mskrzypczak@mimuw.edu.pl
%
% With help of dr Szczepan Hummel and comments from dr Filip Mazowiecki!
%
% Propagate with preservation of the above info.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{beamerikz}[2020/02/17 BeamerikZ class]

% OPTIONS =====================================================================

% what mode is being used (the name: FINAL, READY, INTERIM, SHORT, or DRAFT
\newcommand{\bzUseMode}{FINAL}
% should the non-[show] frames be drawn in a full manner: TRUE or FALSE
\newcommand{\bzUseFull}{TRUE}
% should the non-[show] frames be drawn in a short manner: TRUE or FALSE
\newcommand{\bzUseShort}{FALSE}
% should the grid be used: TRUE or FALSE
\newcommand{\bzUseGrid}{FALSE}
% should the Powered by note be visible: TRUE or FALSE
\newcommand{\bzUseThanks}{TRUE}

% should Beamer use the option draft: either '' or ', draft'
\newcommand{\bzUseDraft}{}

% which font should be used by Beamer
\newcommand{\bzUseFont}{17pt}
% what is the size of the used font
\newcommand{\bzUseScale}{17}
% what is the width of the lines
\newcommand{\bzUseWidth}{1.2pt}

% ready - compile everything, add compile time to the first plain frame
\DeclareOption{ready}{
	\renewcommand{\bzUseMode}{READY}
	\renewcommand{\bzUseFull}{TRUE}
	\renewcommand{\bzUseShort}{FALSE}
	\renewcommand{\bzUseGrid}{FALSE}
	\renewcommand{\bzUseDraft}{}
}

% final - compile everything, no compile time
\DeclareOption{final}{
	\renewcommand{\bzUseMode}{FINAL}
	\renewcommand{\bzUseFull}{TRUE}
	\renewcommand{\bzUseShort}{FALSE}
	\renewcommand{\bzUseGrid}{FALSE}
	\renewcommand{\bzUseDraft}{}
}

% draft - compile all the frames,
%		those with parameter [show] in full step-by-step manner,
%		others in preview mode (one slide per frame),
%		show grid on all frames
%       show slide counter on [show] frames
\DeclareOption{draft}{
	\renewcommand{\bzUseMode}{DRAFT}
	\renewcommand{\bzUseFull}{FALSE}
	\renewcommand{\bzUseShort}{TRUE}
	\renewcommand{\bzUseGrid}{TRUE}
	\renewcommand{\bzUseDraft}{draft}
}

% short - compile all the frames in preview mode (one slide per frame),
%		do not show grid on any frame
\DeclareOption{short}{
	\renewcommand{\bzUseMode}{SHORT}
  	\renewcommand{\bzUseFull}{FALSE}
	\renewcommand{\bzUseShort}{TRUE}
	\renewcommand{\bzUseGrid}{FALSE}
	\renewcommand{\bzUseDraft}{}
}

% brief - compile only [show] frames (in full step-by-step manner),
%		others are replaced by a [HIDDEN] slide (one slide per frame),
%		show grid on all frames
%       show slide counter on [show] frames
\DeclareOption{brief}{
	\renewcommand{\bzUseMode}{INTERIM}
	\renewcommand{\bzUseFull}{FALSE}
	\renewcommand{\bzUseShort}{FALSE}
	\renewcommand{\bzUseGrid}{TRUE}
	\renewcommand{\bzUseDraft}{}
}

% small - make the font have smaller size
\DeclareOption{small}{
	\renewcommand{\bzUseFont}{14pt}
	\renewcommand{\bzUseScale}{14}
	\renewcommand{\bzUseWidth}{1.0pt}
}

% basic - make the font have normal size
\DeclareOption{basic}{
	\renewcommand{\bzUseFont}{17pt}
	\renewcommand{\bzUseScale}{17}
	\renewcommand{\bzUseWidth}{1.2pt}
}

% large - make the font bigger than usually
\DeclareOption{large}{
	\renewcommand{\bzUseFont}{20pt}
	\renewcommand{\bzUseScale}{20}
	\renewcommand{\bzUseWidth}{1.4pt}
}

% plain - do not show Powered by BeamerikZ on the first plain frame
\DeclareOption{plain}{
	\renewcommand{\bzUseThanks}{FALSE}
}

\ProcessOptions*\relax

% PACKAGES, GEOMETRY ==========================================================

\LoadClass[usenames, dvipsnames, t, \bzUseFont, \bzUseDraft]{beamer}

\RequirePackage{environ}
\RequirePackage{tikz}
\RequirePackage{xspace}
\RequirePackage[yyyymmdd,hhmmss]{datetime}
\RequirePackage{parskip}

\geometry{papersize={21.1cm,16.41cm}}

\setlength{\lineskip}{0cm}
\setlength{\parindent}{0cm}
\setlength{\leftskip}{0cm}
\setlength{\parskip}{0cm}
\hangafter=0

\tikzset{every picture/.style={line width=\bzUseWidth}}

\fontsize{\bzUseFont}{1cm}%
\selectfont

% DOCUMENT SETUP ==============================================================

% stores the title of a given presentation (visible in the footline)
\newcommand{\bzTitle}{}

% stores the list of authors of a given presentation (visible in the footline)
% do not use \and here!
\newcommand{\bzAuthor}{}

% sets the title / author of a given presentation
% you may use Latex code inside, like \sBzTitle{\bf Something}
\newcommand{\sBzTitle} [1]{\renewcommand{\bzTitle} {#1}}
\newcommand{\sBzAuthor}[1]{\renewcommand{\bzAuthor}{#1}}

% COLORS ======================================================================

\definecolor{bzBlack}{RGB}{13,55,70}
\definecolor{bzGreen}{RGB}{13,168,67}
\definecolor{bzBlue}{RGB}{18,76,183}
\definecolor{bzRed}{RGB}{248,51,60}
\definecolor{bzWhite}{RGB}{255,255,255}
\definecolor{bzGray}{RGB}{173,175,178}

\newcommand{\bzCtext}{bzBlack}
\newcommand{\bzCemph}{bzGreen}
\newcommand{\bzChigh}{bzRed}
\newcommand{\bzCname}{bzRed}
\newcommand{\bzCback}{bzWhite}

% BEAMER THEME ================================================================

\setbeamertemplate{navigation symbols}{}

\makeatletter
\define@key{beamerframe}{t}[true]{% top
	\beamer@frametopskip=0pt %
	\beamer@framebottomskip=0pt plus 1fill %
	\def\beamer@initfirstlineunskip{}%
}

% BEAMER COLOURS ==============================================================

\color{\bzCtext}

\setbeamercolor{title in head/foot}{bg=\bzCback}
\setbeamercolor{section in head/foot}{bg=\bzCback}
\setbeamercolor{background canvas}{bg=\bzCback}

% TiKZ LIBRARIES ==============================================================

\usetikzlibrary{calc}
\usetikzlibrary{positioning}
\usetikzlibrary{fit}
\usetikzlibrary{backgrounds}
\usetikzlibrary{decorations.pathmorphing}
\usetikzlibrary{decorations.pathreplacing}
\usetikzlibrary{decorations.markings}
\usetikzlibrary{decorations}
\usetikzlibrary{arrows}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{patterns}
\usetikzlibrary{shapes}

% BRACES ======================================================================

\tikzstyle{bzBrace} = [draw]

% upper brace
\tikzstyle{bzBraceU} = [bzBrace,
	decoration={brace, mirror, raise=0.0cm, amplitude=3mm},
	decorate,
	every node/.style={anchor=north, yshift=-0.2cm}]

% right brace
\tikzstyle{bzBraceR} = [bzBrace,
	decoration={brace, mirror, raise=0.0cm, amplitude=3mm},
	decorate,
	every node/.style={anchor=west, xshift= 0.2cm}]

% over brace
\tikzstyle{bzBraceO} = [bzBrace,
	decoration={brace, raise=0.0cm, amplitude=3mm},
	decorate,
	every node/.style={anchor=south, yshift= 0.2cm}]

% left brace
\tikzstyle{bzBraceL} = [bzBrace,
	decoration={brace, raise=0.0cm, amplitude=3mm},
	decorate,
	every node/.style={anchor=east, xshift=-0.2cm}]

% ARITHMETIC ==================================================================

% These commands perform immidetely the arithmetical computetion given in
% the second argument % and store the result in the first argument, like:
% \bzEval{\x}{(1+\x)*\y+12.1}

% This is the general one, that works on floating point numbers
\newcommand{\bzEval}[2]{%
	\pgfmathparse{#2}%
	{\global\edef#1{\pgfmathresult}}%
}

% This one returns the number rounded as an integer
\newcommand{\bzEvalInt}[2]{%
	\pgfmathparse{int(#2)}%
	{\global\edef#1{\pgfmathresult}}%
}

% COUNTERS ====================================================================

% slide number counter
\newcommand{\bzS}{1}
\newcommand{\sBzS}[1]{\bzEvalInt{\bzS}{#1}}
\newcommand{\zBzS}{\bzEvalInt{\bzS}{1}}
\newcommand{\dBzS}[1][1]{\bzEvalInt{\bzS}{\bzS-(#1)}}
\newcommand{\iBzS}[1][1]{\bzEvalInt{\bzS}{\bzS+(#1)}}

% height - vertical align counter
\newcommand{\bzH}{0}
\newcommand{\sBzH}[1]{\bzEval{\bzH}{#1}}
\newcommand{\zBzH}{\bzEval{\bzH}{0}}
\newcommand{\iBzH}[1][1.0]{\bzEval{\bzH}{\bzH-(#1)}}
\newcommand{\dBzH}[1][1.0]{\bzEval{\bzH}{\bzH+(#1)}}

% indent - horizontal align counter
\newcommand{\bzI}{-10}
\newcommand{\sBzI}[1]{\bzEval{\bzI}{#1}}
\newcommand{\zBzI}{\bzEval{\bzI}{-10}}
\newcommand{\dBzI}[1][1.0]{\bzEval{\bzI}{\bzI-(#1)}}
\newcommand{\iBzI}[1][1.0]{\bzEval{\bzI}{\bzI+(#1)}}

% list numbering counter
\newcommand{\bzL}{0}
\newcommand{\zBzL}{\bzEvalInt{\bzL}{0}}
\newcommand{\iBzL}[1][1]{\bzEvalInt{\bzL}{\bzL+(#1)}}

% node numbering counter
\newcommand{\bzN}{0}
\newcommand{\zBzN}{\bzEvalInt{\bzN}{0}}
\newcommand{\iBzN}{\bzEvalInt{\bzN}{\bzN+1}}

% gives the label of a node of a given number
\newcommand{\bzLabel}[1]{beamerikzNode#1}

% APPEARING AND DISAPPEARING OF THE CONTENT ===================================

% Shows the given content on slides in-between the given two numbers
% When an argument is skipped, taken as the first / last slide
\newcommand{\bzIn}[3]{%
   	\bzEvalInt{\bzShow}{#1}%
   	\bzEvalInt{\bzHide}{#2}%
   	\ifthenelse{\equal{\bzShow}{0}}{\renewcommand{\bzShow}{}}{}%
   	\ifthenelse{\equal{\bzHide}{0}}{\renewcommand{\bzHide}{}}{}%
   	\ifthenelse{\equal{\bzShowAll}{1}}{%
	   	\onslide<\bzShow-\bzHide>{#3}%
	}{%
		\ifthenelse{\equal{\bzHide}{}}{%
			#3%
		}{%
			\begin{scope}[opacity=0.2]#3\end{scope}%
		}%
	}%
}

% shows the given content from that moment on and increases \bzS
\newcommand{\bzOn}[1]{\bzIn{\bzS}{}{#1}\iBzS}

% shows the given content for one step and increases \bzS
\newcommand{\bzOne}[1]{\bzIn{\bzS}{\bzS}{#1}\iBzS}

% shows the given content for two steps and increases \bzS
\newcommand{\bzTwo}[1]{\bzIn{\bzS}{\bzS+1}{#1}\iBzS}

% shows the given content for one steps and waits for it to vanish -
% increases \bzS by two
\newcommand{\bzOnly}[1]{\bzIn{\bzS}{\bzS}{#1}\iBzS\iBzS}

% FRAME ELEMENTS ==============================================================

% shows the stylized logo of the package
\newcommand{\beamerikz}{{\normalfont \texttt{Beamer}i\textit{k}Z}\xspace}

% Should show all the intermediate slides
\newcommand{\bzShowAll}{1}

% is this the first plain frame in the presentation (counter)
\newcommand{\bzNumFF}{0}

% reset counters for a new frame
\newcommand{\bzResetFrame}{
\color{\bzCtext}%
\zBzS%
\zBzH%
\zBzI%
\zBzL%
\zBzN%
}

% Shows the background coordinate system of a frame
\newcommand{\bzCoords}{
	\bzUnder{
		\path[draw, step=1.0, dashed, bzGray!40, thin] (-10,-14.5) grid (10,1);

		\path[draw, ultra thick, bzGray!60] (0,-14.5) -- (0,1.0);
		\foreach \x in {-10, -5, 0, 5, 10} {
			\path[draw, thin, bzGray!40] (\x,-14.5) -- (\x,1.0);
		}

		\path[draw, ultra thick, bzGray!60] (-10, 0) -- (10,0);
		\foreach \y in {0, -5, -10} {
			\path[draw, thin, bzGray!40] (-10,\y) -- (10,\y);
		}
	}
}

% shows the body of the frame, including coordinates if needed
\newcommand{\bzBody}{
	\ifthenelse{\equal{\bzUseGrid}{TRUE}}{
		\bzCoords
	}{}
	\BODY
}

% show the actual content of the frame (without footline, etc)
\newcommand{\bzContent}[1]{
\begin{scope}
	\clip(-10.5,1.1) rectangle (10.5,-14.5);

	\ifthenelse{\equal{#1}{show}}{
		\ifthenelse{\equal{\bzUseMode}{SHORT}}{
			\renewcommand{\bzShowAll}{0}%
			\bzBody
			\renewcommand{\bzShowAll}{1}%
		}{
			\bzBody
		}
	}{
		\ifthenelse{\equal{\bzUseFull}{TRUE}}{
			\bzBody
		}{}

		\ifthenelse{\equal{\bzUseShort}{TRUE}}{
			\renewcommand{\bzShowAll}{0}%
			\bzBody
			\renewcommand{\bzShowAll}{1}%
		}{}

		\ifthenelse{\equal{\bzUseMode}{INTERIM}}{
			\node[bzC] at (0,-5) {\sc [ {\small HIDDEN} ]};
		}{}
	}
\end{scope}
}

% Shows the compile information
\newcommand{\bzCompileInfo}{
	\ifthenelse{\equal{\bzUseMode}{READY} \AND \equal{\bzNumFF}{0}}{
		\bzOn{
			\node[scale=10/\bzUseScale, bzC] at (0, -15) {%
				\texttt{$\big[$\today\ %
				\currenttime\ %
				(\inserttotalframenumber)}$\big]$%
			};
		}
	}{}
}

% show footline of a slide - author, title, and frame number
\newcommand{\bzFootline}{
	\node[scale=10/\bzUseScale, bzR] at (-0.5, -15.0) {\bzAuthor};
	\node[scale=10/\bzUseScale, bzL] at (+0.5, -15.0) {\bzTitle};
	\node[scale=10/\bzUseScale, bzR] at (10.0, -15.0)
		{\insertframenumber\, / \ \inserttotalframenumber};
}

% show slide counter if the mode requires that (if grid is visible)
\newcommand{\bzSlideCount}[1]{
	\ifthenelse{\equal{#1}{show} \AND \equal{\bzUseGrid}{TRUE}}{
		\node[scale=10/\bzUseScale, bzL, text=gray] at (-10, -15)
			{(\the\beamer@slideinframe)};
	}{}
}

% shows the powered by info
\newcommand{\bzPowered}{
	\ifthenelse{\equal{\bzUseThanks}{TRUE} \AND \equal{\bzNumFF}{0}}{
		\node[bzR, scale=9/\bzUseScale] at (10.3, -15)
			{
			\href{https://www.mimuw.edu.pl/~mskrzypczak/projects/beamerikz/}%
			{\textbf{Powered by} \beamerikz}
			};
	}{}
}

% FRAMES ======================================================================

% Shows a normal frame
% Optional argument [show] makes the frame visibile in all compile modes
\NewEnviron{bzFrame}[1][]{%
\begin{frame}[t, plain]%
\bzResetFrame%
\makebox[\textwidth][c]{%
\begin{tikzpicture}%
\bzContent{#1}
\bzFootline
\bzSlideCount{#1}
\end{tikzpicture}%
}%
\end{frame}%
}

% Shows a plain frame (no bottom line)
% Optional argument [show] makes the frame visibile in all compile modes
% in ready compile mode the first plain frame gets compile information
\NewEnviron{bzPlainFrame}[1][]{%
\begin{frame}[t,plain,noframenumbering]%
\bzResetFrame%
\makebox[\textwidth][c]{%
\begin{tikzpicture}%
\bzContent{#1}
\bzCompileInfo
\bzSlideCount{#1}
\bzPowered
\end{tikzpicture}%
}%
\end{frame}%
\bzEvalInt{\bzNumFF}{\bzNumFF+1}%
}

% NODE STYLES =================================================================

\tikzstyle{bzFlow} = [execute at begin node=\setlength{\baselineskip}{1cm},%
				inner sep=0cm, node distance=0cm and 0cm, outer sep=0cm]

% text node extending to right (alignet left)
\tikzstyle{bzL} = [bzFlow, anchor=mid west, align=left]

% text node aligned centrally
\tikzstyle{bzC} = [bzFlow, anchor=mid     , align=center,
				bzM/.default={0 cm - \bzI cm - \bzI}]

% text node extending to left (aligned right)
\tikzstyle{bzR} = [bzFlow, anchor=mid east, align=right]

\tikzset{bzM/.style args = {#1}{text width=#1 cm}}

\tikzset{bzM/.default={10 cm - \bzI}}

% graphical node anchored at the center of the picture
\tikzstyle{bzG} = [bzFlow, anchor=center, align=center]

% DISPLAY STYLES ==============================================================

% only boldfaced text
\newcommand{\bo}[1]{\textbf{#1}}

% highlighted text
\newcommand{\hl}[1]{\textcolor{\bzChigh}{#1}}

% emphasized text
\newcommand{\el}[1]{\textcolor{\bzCemph}{#1}}

% highlighted and boldfaced
\newcommand{\hb}[1]{\hl{\bo{#1}}}

% emphasized and boldfaced
\newcommand{\eb}[1]{\el{\bo{#1}}}

% displays the given argument as names of authors (in brackets). If
% the argument is empty, displays nothing (not even the brackets).
\newcommand{\bzNames}[1]{%
	\ifthenelse{\equal{#1}{}}{%
	}{%
		\textcolor{\bzCname}{(#1)}}%
	}

% NODE STYLES =================================================================

% Styles of TikZ nodes corresponding to the above commands \hl etc

% Boldfaced node (does not affect mathematics)
\tikzstyle{bzBO} = [font = \bfseries]

% Highlighted node
\tikzstyle{bzHL} = [text = \bzChigh]

% Emphasised node
\tikzstyle{bzEL} = [text = \bzCemph]

% Boldfaced and highlighted
\tikzstyle{bzHB} = [bzBO, bzHL]

% Boldfaced and emphasised
\tikzstyle{bzEB} = [bzBO, bzEL]

% FRAME NODES =================================================================

% All the following commands go with variants BO, HL, HB, EL, and EB,
% that use the respective highlighting commands for the content.

% just a node, with no modification to the coordinates (but with a label)
\newcommand{\bzNode}[2][]{
	\iBzN
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
}

% text aligned immidately to left
\newcommand{\bzLeft}[2][]{
	\iBzN
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
	\iBzH
}

% text aligned to left, with an ident
\newcommand{\bzText}[2][]{
	\iBzN
	\iBzI
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
	\dBzI
	\iBzH
}

% the shape of the item dot
\newcommand{\bzItemDot}{$\bullet$}

% reset the dot to the standard shape
\newcommand{\zBzItemDot}{\renewcommand{\bzItemDot}{$\bullet$}}

% item of an itemized list, aligned to left, with an ident
\newcommand{\bzItem}[2][]{
	\iBzN
	\iBzI
	\node[bzC] at (\bzI-0.4, \bzH) {\bzItemDot};
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
	\dBzI
	\iBzH
}

% item of an enumerated list, aligned to left, with an ident
\newcommand{\bzList}[2][]{
	\iBzN
	\iBzL
	\iBzI
	\node[bzR] at (\bzI-0.15, \bzH) {\bf \bzL.};
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
	\dBzI
	\iBzH
}

% text aligned immidately to right
\newcommand{\bzRight}[2][]{
	\iBzN
	\node[bzR, #1] (\bzLabel{\bzN}) at (-\bzI, \bzH) {#2};
	\iBzH
}

% text aligned to center
\newcommand{\bzCenter}[2][]{
	\iBzN
	\node[bzC, #1] (\bzLabel{\bzN}) at (0, \bzH) {#2};
	\iBzH
}

% Continue last node to the right.
% You can also provide a number (retriven by \bzN) of a node as
% the first optional argument.
% \bzH is not incremented
\newcommand{\bzNext}[3][]{
	\bzEvalInt{\bzLNumber}{#2}
	\iBzN
	\node[bzL, base right = of \bzLabel{\bzLNumber}, #1] (\bzLabel{\bzN}) {#3};
}

% Continue last node to the left.
% You can also provide a number (retriven by \bzN) of a node as the first
% optinal argument.
% \bzH is not incremented
\newcommand{\bzPrev}[3][]{
	\bzEvalInt{\bzLNumber}{#2}
	\node[bzR, base left = of \bzLabel{\bzLNumber}, #1] {#3};
}

% FRAME COMPONENTS ============================================================

% shows the given content on the background layer, behind the normal content
\newcommand{\bzUnder}[1]{
	\begin{scope}[on background layer]
	#1
	\end{scope}
}

% centered mathematical content
\newcommand{\bzMath}[2][]{
	\bzCenter[#1]{\begin{minipage}{20cm}{#2}\end{minipage}};
}

% multi-line content with automatical line-breaking
\newcommand{\bzBox}[2][]{
	\node[bzL, bzM, #1] at (\bzI, \bzH) {#2};
	\iBzH
}

% displays the abstract theorem
\newcommand{\bzThm}[4][]{
	\bzLeft{\hb{#2} \bzNames{#3}}
	\bzText[bzM, #1]{#4}
}

\newcommand{\bzTheorem}[3][]    {\bzThm[#1]{Theorem}{#2}{#3}}
\newcommand{\bzLemma}[3][]      {\bzThm[#1]{Lemma}{#2}{#3}}
\newcommand{\bzFact}[3][]       {\bzThm[#1]{Fact}{#2}{#3}}
\newcommand{\bzConjecture}[3][] {\bzThm[#1]{Conjecture}{#2}{#3}}
\newcommand{\bzDefinition}[3][] {\bzThm[#1]{Definition}{#2}{#3}}
\newcommand{\bzQuestion}[3][]   {\bzThm[#1]{Question}{#2}{#3}}
\newcommand{\bzProblem}[3][]    {\bzThm[#1]{Problem}{#2}{#3}}
\newcommand{\bzProposition}[3][]{\bzThm[#1]{Proposition}{#2}{#3}}
\newcommand{\bzCorollary}[3][]  {\bzThm[#1]{Corollary}{#2}{#3}}
\newcommand{\bzExercise}[3][]   {\bzThm[#1]{Exercise}{#2}{#3}}
\newcommand{\bzExample}[3][]    {\bzThm[#1]{Example}{#2}{#3}}

% displays proof of a theorem
\newcommand{\bzProof}[2][]{
	\bzLeft[bzBO]{Proof}
	\bzText[bzM, #1]{#2}
}

\renewcommand{\qedsymbol}{\ensuremath{\blacksquare}}

% displays QED symbol
\newcommand{\bzQed}[1][]{
	\bzRight[#1]{\qed}
}

% displays horizontal line
\newcommand{\bzLine}[1][]{
	\draw[line cap=round, #1] (-10, \bzH + 0.5) -- ++(20,0);
}

% END =========================================================================

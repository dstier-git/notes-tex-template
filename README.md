# notes-tex-template

Lecture-notes starter using the `mathnotes` class. Clone (or use as a GitHub template) once per course, set the course name, and start writing.

## Quick start

1. Open this folder in VS Code / Cursor. Install the recommended **LaTeX Workshop** extension if prompted.
2. Edit `notes_format/course.tex` and replace `Course Name` with your course title.
3. Duplicate `lectures/lecture.tex` for each lecture (e.g. `lectures/929.tex`), then fill in `\notetitle` and the body.
4. Compile with **XeLaTeX**. The workspace recipe is already set.

From a terminal:

```bash
TEXINPUTS="$(pwd)/notes_format:" xelatex path/to/notes.tex
```

`example.tex` at the repo root shows definitions, theorems, and a code block.

## Document skeleton

```latex
\documentclass{mathnotes}
\input{course}
\notedate{\today}

\begin{document}
\notetitle{1}{Lecture title}

% your notes here

\end{document}
```

Workspace settings put `notes_format/` on `TEXINPUTS`, so `\documentclass{mathnotes}` and `\input{course}` work from any folder under the repo.

## Code boxes

```latex
\begin{python}
print(1)
\end{python}

\begin{sql}
SELECT * FROM t;
\end{sql}
```

`\begin{lstlisting}` is still Python.

## Fonts

Source Serif 4 and JetBrains Mono ship under `notes_format/fonts/` (OFL). The class loads them from that directory, so a fresh clone compiles without a system font install.

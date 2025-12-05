#!/bin/bash

# Output directory
OUT_DIR="./docs"
mkdir -p "$OUT_DIR"

# Output file names inside docs/
OUT_TEX="${OUT_DIR}/gameplay_II_combined.tex"
OUT_PDF="${OUT_DIR}/gameplay_II_combined.pdf"

# Files in the exact order you specified
FILES=(
  "./docs/walkthroughs/gameplay_II_walkthrough.md"
  "./sql/game_play_analysis_II.sql"
  "./pandas/game_play_analysis_II.py"
  "./docs/theory/game_analysis_II_flowchart.tex"
  "./docs/theory/game_play_analysis_II.tex"
)

echo "Combining files into ${OUT_TEX}..."

# Start fresh
echo "% Auto-generated combined LaTeX" > "$OUT_TEX"

for f in "${FILES[@]}"; do
    # Add header with correct newlines
    printf "\n\n%% ===== File: %s =====\n" "$f" >> "$OUT_TEX"

    EXT="${f##*.}"

    case "$EXT" in
        md)
            pandoc "$f" -t latex >> "$OUT_TEX"
            ;;
        py|sql)
            printf "\\begin{verbatim}\n" >> "$OUT_TEX"
            cat "$f" >> "$OUT_TEX"
            printf "\n\\end{verbatim}\n" >> "$OUT_TEX"
            ;;
        tex)
            cat "$f" >> "$OUT_TEX"
            ;;
    esac
done

echo "LaTeX file created: ${OUT_TEX}"

# Compile PDF inside docs/
cd "$OUT_DIR"
pdflatex "gameplay_II_combined.tex"
cd -

echo "Done! Output PDF: ${OUT_PDF}"

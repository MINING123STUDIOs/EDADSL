# EDADSL

A DSL for electronic design automation. Circuits are written as code:
parts, nets, connections, physical constraints, solver setup. The spec
defines the language precisely enough that ten independent developers
can implement it and end up with functionally identical results.

There is no implementation in this repo. The spec is the product.

## Contents

- `Documentation/Doc.pdf` — the specification, ~514 pages
- `Documentation/*.tex` — LaTeX sources for it
- `examples/` — programs written in EDADSL (`.ec` files)

## Building the PDF

Needs pdflatex (texlive, with amsmath/tikz etc.):

```
cd Documentation
pdflatex -interaction=nonstopmode Doc.tex
pdflatex -interaction=nonstopmode Doc.tex   # run twice, second pass fills the TOC
```

## Examples

- `ssr.ec` — 80A / 1kV solid state relay module
- `ltc3780_buck_boost*.ec` — LTC3780 buck-boost converter, three variants
- `Amp.ec`, `Test.ec`, `Test II.ec` — smaller test programs

## Status

Work in progress. The spec changes constantly.

## License

MIT, see [LICENSE](LICENSE).

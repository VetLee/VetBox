# VetBox - layout css library

## Usage

```
<div row="sb cn" wrap cols-flex="3">
<div col="sb cn" wrap rows-flex="5">
<div col="space-around center">
<div align-self="cn">
<div align-content="center">

<div hide>
<div hide="md">
<div hide="xs md lg">

<div order="-1">
<div flex-shrink="2">
<div flex-grow="5">

<div mr="5">
<div margin-bottom="25">

<div vb-ne>
<div nowrap-ell>
```

## Abbreviations:

Abbreviation | Value
------------ | -------------
fs           | flex-start
fe           | flex-end
cn           | center
bl           | baseline
str          | stretch
sb           | space-between
sa           | space-around
------------ | -------------
mt           | margin-top
mr           | margin-right
mb           | margin-bottom
ml           | margin-left
------------ | -------------
vb-ne        | nowrap-ell

## Breakpoint aliases:

Breakpoint | Exapmles                               | MediaQuery (pixel range)
---------- | -------------------------------------- | ------------------------
*without*  | `hide` / `row="fs cn"`                 | **all**
`xs`       | `hide="xs"` / `xs-align-self="center"` | width < 600px
`gt-xs`    | `hide="gt-xs"` / `gt-xs-row`           | width >= 600px
`sm`       | `hide="sm"` / `sm-flex`                | 600px <= width < 960px
`gt-sm`    | `hide="gt-sm"` / `gt-sm-wrap`          | width >= 960px
`md`       | `hide="md"` / `md-cols-flex`           | 960px <= width < 1280px
`gt-md`    | `hide="gt-md"` / `gt-md-rows-flex`     | width >= 1280px
`lg`       | `hide="lg"` / `lg-col`                 | 1280px <= width < 1920px
`xl`       | `hide="xl"` / `xl-flex`                | width >= 1920px

## Build:

- `gulp` - start builder and webserver with livereload (without plugins)
- `gulp build` - only dev build
- `gulp dist` - only distributive build

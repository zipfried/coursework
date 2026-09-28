// Usage: #question("2.2", title: [Optional title])[Question text]
#let question(number, body, title: none) = {
  // Spacing uses the body font size; the larger title is scoped below.
  block(above: 1em, below: 1em, sticky: true)[
    #text(size: 12pt, weight: "bold")[
      #smallcaps[Question] #number#if title != none [ — #title]
    ]
  ]
  body
  parbreak()
}

// Keep long solutions free to flow across page boundaries.
// Usage: #solution[Working and final answer]
#let solution(body, append: none) = {
  block(above: 1em, below: 1em, sticky: true)[
    #text(size: 12pt, weight: "bold", fill: luma(105))[#smallcaps[Solution] #append]
  ]
  body
  parbreak()
}

#let homework(
  body,
  title: "Homework",
  course: "",
  author: "",
  date: datetime.today().display("[month repr:long] [day], [year]"),
) = {
  let ink = luma(0)
  let muted = luma(80)
  let rule = luma(160)

  set document(title: title, author: author)
  set page(
    paper: "a4",
    footer: context align(center, text(size: 9pt, fill: muted)[#counter(page).display("1")]),
  )
  set text(font: ("New Computer Modern", "Noto Serif SC"), size: 12pt, fill: ink, lang: "en")
  show math.equation: set text(font: "New Computer Modern Math")
  set par(justify: true)
  set heading(numbering: "1.1")
  // show heading: it => {
  //   set block(above: 1em, below: 1em)
  //   set text(size: if it.level == 1 { 13pt } else { 11pt }, weight: "bold")
  //   it
  // }
  // set list(indent: 1.2em, body-indent: 0.5em)
  // set enum(indent: 1.2em, body-indent: 0.5em)
  set table(inset: (x: 10pt, y: 7pt), stroke: (rest: none, bottom: 0.5pt + rule))
  show table.cell.where(y: 0): set text(weight: "bold")
  // set figure(gap: 0.6em)
  // show figure.caption: set text(size: 9pt, fill: muted)
  show raw: set text(font: "JuliaMono", size: 9pt)
  show raw.where(block: true): it => block(
    width: 100%,
    inset: 10pt,
    fill: luma(247),
    radius: 3pt,
    it,
  )

  block[
    #text(size: 24pt, weight: "bold", title)
    #if course != "" {
      text(size: 12pt, fill: muted)[
        #grid(columns: (1fr, auto), column-gutter: 1em, [#author #sym.dot.c #course], [#date])
      ]
    } else {
      text(size: 12pt, fill: muted)[
        #grid(columns: (1fr, auto), column-gutter: 1em, [#author], [#date])
      ]
    }
    #line(length: 100%, stroke: 0.8pt + rule)
  ]
  body
}

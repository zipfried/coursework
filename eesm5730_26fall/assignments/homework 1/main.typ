#import "../../../utils/template.typ": homework, question, solution
#import "@preview/equate:0.3.3": equate
#import "@preview/physica:0.9.8": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#show: codly-init.with()

#codly(languages: codly-languages)

#let vbu(c) = math.bold(math.upright(c))
#set math.equation(numbering: (..nums) => numbering("(1)", ..nums), supplement: none)
#set math.mat(delim: "[")

#let vx = $vbu(x)$
#let vA = $vbu(A)$
#let vB = $vbu(B)$
#let vC = $vbu(C)$
#let vD = $vbu(D)$
#let vI = $vbu(I)$
#let vf = $vbu(f)$
#let vg = $vbu(g)$

#show: homework.with(
  title: "Homework 1",
  course: "EESM 5730",
  author: "Han Zifei",
  date: "September 27, 2026",
)

// Outer labels number the whole block; inner labels number individual lines.
#show math.equation.where(block: true): set block(breakable: true)
#show ref: equate
#show math.equation.where(block: true): it => {
  if it.has("label") {
    it
  } else {
    equate(it, number-mode: "label", sub-numbering: false, breakable: true)
  }
}

#question("2.2")[]

#solution(append: "for (1)")[
  Define right as the positive direction, then
  $
    F(t)                                                               & = u(t) - f_("sp")(t) - f_("b")(t) \
    M dot.double(y)(t)                                                 & = u(t) - k (1 + a y^2(t)) y(t) - b dot(y)(t) \
    dot.double(y)(t) + b / M dot(y)(t) + k / M y(t) + (k a) / M y^3(t) & = 1 / M u(t) #<2.2.ode>
  $
]

#solution(append: "for (2)")[
  Omit $(t)$ in equation #ref(<2.2.ode>):
  $
    dot.double(y) + b / M dot(y) + k / M y + (k a) / M y^3 = 1 / M u
  $
  Define that
  $
    x_1 & = y #<2.2.def.1> \
    x_2 & = dot(y) #<2.2.def.2>
  $
  then
  $
    dot(x)_1 & = x_2 #<2.2.state.1> \
    dot(x)_2 & = - k / M x_1 - b / M x_2 - (k a) / M x_1^3 + 1 / M u #<2.2.state.2> \
    y        & = x_1 #<2.2.state.out>
  $
]

#solution(append: "for (3)")[
  This system is nonlinear due to the cubic term $x_1^3$ in equation #ref(<2.2.state.2>).
  To linearize it, define $vx_0 = vbu(0)$ and $u_0 = 0$, then
  $
    vA & = evaluated(pdv(vf, vx))_(vx & = vx_0 \ u & = u_0)
         = evaluated(mat(0, 1; - (k - 3 k a x_1^2) / M, - b / M))_(vx & = vx_0 \ u & = u_0)
      && = mat(0, 1; - k / M, - b / M) #<2.2.state.A> \
    vB & = evaluated(pdv(vf, u))_(vx & = vx_0 \ u & = u_0)
         = evaluated(mat(0; 1 / M))_(vx & = vx_0 \ u & = u_0)
      && = mat(0; 1 / M) #<2.2.state.B> \
    vC & = evaluated(pdv(vg, vx))_(vx & = vx_0 \ u & = u_0)
      && = mat(1, 0) #<2.2.state.C> \
    vD & = evaluated(pdv(vg, u))_(vx & = vx_0 \ u & = u_0)
      && = vbu(0) #<2.2.state.D>
  $
]

#solution(append: "for (4)")[
  $
    G(s) & = vC (s vI - vA)^(-1) vB + vD \
         & = mat(1, 0) (dmat(s, s, delim: "[") - mat(0, 1; - k / M, - b / M))^(-1) mat(0; 1 / M) + vbu(0) \
         & = mat(1, 0) mat(s, -1; k / M, s + b / M)^(-1) mat(0; 1 / M) \
         & = M / (M s^2 + b s + k) mat(1, 0) mat(s + b / M, 1; - k / M, s) mat(0; 1 / M) \
         & = 1 / (M s^2 + b s + k) #<2.2.tf>
  $
]

#question("2.9")[]

#solution[
  Obtain that
  $
    u(t) = r(t) - K y(t) = r(t) - K vC vx(t)
  $
  then
  $
    dot(vx)(t) & = vA vx(t) + vB u(t) \
               & = vA vx(t) + vB (r(t) - K vC vx(t)) \
               & = (vA - K vB vC) vx(t) + vB r(t)
  $
  The model is
  $
    dot(vx)(t) & = (vA - K vB vC) vx(t) + vB r(t) #<2.9.state.x> \
    y(t)       & = vC vx(t)                       #<2.9.state.y>
  $
]

#question("2.10")[]

#solution[
  Omit the $(s)$.
  Define the input of $A$ as $u$, output of $A$ as $x$, output of $B$ as $z$.
  $
    U & = R - E Z \
    X & = A U \
    Z & = B X
  $
  then
  $
    X & = A (R - E Z) \
    X & = A (R - B E X) \
    (1 + A B E) X & = A R \
    X & = A / (1 + A B E) R
  $
  And
  $
    Y = C Z + D X = B C X + D X = (A B C + A D) / (1 + A B E) R
  $
  Thus
  $
    G = Y / R = (A B C + A D) / (1 + A B E)
  $ <2.10.tf>
]

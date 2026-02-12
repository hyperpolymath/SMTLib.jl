;; SPDX-License-Identifier: PMPL-1.0-or-later
;; ECOSYSTEM.scm for SMTLib.jl

(ecosystem
  (version "1.0")
  (name "SMTLib.jl")
  (type "julia-package")
  (purpose "SMT solver interface and SMT-LIB2 generation")

  (position-in-ecosystem
    (domain "formal-methods")
    (role "solver-interface")
    (maturity "alpha")
    (adoption "early-stage"))

  (related-projects
    ((name . "Axiom.jl")
     (relationship . complementary)
     (nature . "Symbolic mathematics system that could use SMT backends"))
    ((name . "Z3.jl")
     (relationship . alternative)
     (nature . "Direct Z3 bindings (more specialized, less portable)"))
    ((name . "JuMP.jl")
     (relationship . complementary)
     (nature . "Mathematical optimization - SMT can handle discrete/logical constraints")))

  (dependencies
    (runtime
      ("Julia" "1.9+")
      ("TOML" "stdlib"))
    (external-tools
      ("z3" "optional - SMT solver")
      ("cvc5" "optional - SMT solver")
      ("yices" "optional - SMT solver"))))

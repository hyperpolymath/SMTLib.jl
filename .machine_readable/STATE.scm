;; SPDX-License-Identifier: PMPL-1.0-or-later
;; STATE.scm for SMTLib.jl

(define state
  '((metadata
     (project . "SMTLib.jl")
     (version . "0.2.0")
     (updated . "2026-02-12")
     (maintainers . ("Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>")))

    (current-position
     (phase . "implementation")
     (overall-completion . 68)
     (working-features
       "Solver discovery (z3, cvc5, yices)"
       "SMT-LIB2 expression generation"
       "Model parsing and result handling"
       "@smt convenience macro"
       "Type mapping (Int, Float64, Bool, BitVector, Array)"
       "RSR infrastructure (.editorconfig, .gitignore, SCM files)"
       "get_model convenience function"
       "from_smtlib basic parsing")
     (partial-features
       "push!/pop! stubbed (need full stack tracking)"
       "Unsat core documented but unimplemented"
       "Named assertions documented but unimplemented"
       "solver_options documented but unimplemented"))

    (blockers-and-issues
     (technical-debt
       "push!/pop! need full stack tracking implementation"
       "ABI/FFI layer placeholders fixed but not functional for Julia"
       "parse_model regex fails on multi-line output"
       "Timeout detection never triggers"
       "from_smtlib only handles basic cases")
     (known-issues
       "Tests pass but require installed solver"
       "prove() function has weak type inference"
       "extract_variables() incomplete operator detection"))

    (critical-next-actions
     (immediate
       "Implement full push!/pop! with stack tracking"
       "Implement unsat core support"
       "Implement solver_options"
       "Fix parse_model for multi-line output")
     (short-term
       "Improve from_smtlib parser"
       "Improve test coverage"
       "Fix prove() type inference"
       "Add incremental.jl example"))

    (session-history
     (sessions
       ((date . "2026-02-12")
        (agent . "Claude Sonnet 4.5")
        (summary . "Completed 9 SONNET-TASKS: RSR infrastructure, template cleanup, workflow fixes, stub implementations")
        (tasks-completed . "2 5 6 7 8 9 14 15 1-partial")
        (completion-delta . +13))))))

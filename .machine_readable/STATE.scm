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
     (overall-completion . 55)
     (working-features
       "Solver discovery (z3, cvc5, yices)"
       "SMT-LIB2 expression generation"
       "Model parsing and result handling"
       "@smt convenience macro"
       "Type mapping (Int, Float64, Bool, BitVector, Array)")
     (partial-features
       "push!/pop! exported but unimplemented"
       "get_model exported but unimplemented"
       "from_smtlib exported but unimplemented"
       "Unsat core documented but unimplemented"
       "Named assertions documented but unimplemented"
       "solver_options documented but unimplemented"))

    (blockers-and-issues
     (technical-debt
       "4 exported functions have no implementation"
       "ABI/FFI layer is unmodified template boilerplate"
       "All RSR files still have {{PLACEHOLDER}} tokens"
       "Examples directory had bogus ReScript/Deno files"
       "CodeQL scans for Rust instead of Julia"
       "Manifest.toml tracked (should be gitignored for libraries)"
       "parse_model regex fails on multi-line output"
       "Timeout detection never triggers")
     (known-issues
       "Tests pass but require installed solver"
       "prove() function has weak type inference"
       "extract_variables() incomplete operator detection"))

    (critical-next-actions
     (immediate
       "Implement push!/pop!/get_model/from_smtlib"
       "Replace all {{PLACEHOLDER}} tokens"
       "Fix workflows (CodeQL, Scorecard, quality.yml)"
       "Remove/fix ABI/FFI boilerplate"
       "Untrack Manifest.toml")
     (short-term
       "Implement unsat core support"
       "Implement solver_options"
       "Fix parse_model for multi-line output"
       "Improve test coverage"
       "Fix prove() type inference"))

    (session-history
     (sessions
       ((date . "2026-02-12")
        (agent . "Claude Sonnet 4.5")
        (summary . "Initial assessment, removed bogus examples, added RSR files")
        (completion-delta . +5))))))

# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# BenchmarkTools benchmarks for SMTLib.jl

using BenchmarkTools
using SMTLib

const SUITE = BenchmarkGroup()

SUITE["generation"] = BenchmarkGroup()

SUITE["generation"]["literal_int"] = @benchmarkable to_smtlib(42)
SUITE["generation"]["literal_bool"] = @benchmarkable to_smtlib(true)

SUITE["generation"]["simple_arith"] = @benchmarkable to_smtlib(:(x + y))
SUITE["generation"]["nested_arith"] = @benchmarkable to_smtlib(:(x + y * z))
SUITE["generation"]["comparison"] = @benchmarkable to_smtlib(:(x > 0))
SUITE["generation"]["logical"] = @benchmarkable to_smtlib(:((x > 0) && (y < 10)))
SUITE["generation"]["deep_nest"] = @benchmarkable to_smtlib(:((x + y * z) > (a - b * c)))

SUITE["context"] = BenchmarkGroup()

SUITE["context"]["create"] = @benchmarkable SMTContext()

SUITE["context"]["declare_assert_script_10"] = @benchmarkable begin
    ctx = SMTContext()
    declare_const(ctx, :x, :Int)
    for i in 1:10
        assert!(ctx, :(x > 0))
    end
    to_smtlib_script(ctx)
end

SUITE["context"]["declare_10_consts"] = @benchmarkable begin
    ctx = SMTContext()
    for i in 1:10
        declare_const(ctx, Symbol("v$i"), :Int)
    end
end

SUITE["discovery"] = BenchmarkGroup()

SUITE["discovery"]["available_solvers"] = @benchmarkable available_solvers()
SUITE["discovery"]["find_solver"] = @benchmarkable find_solver()

if abspath(PROGRAM_FILE) == @__FILE__
    tune!(SUITE)
    results = run(SUITE, verbose=true)
    BenchmarkTools.save("benchmarks_results.json", results)
end

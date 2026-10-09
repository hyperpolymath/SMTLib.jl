# SPDX-License-Identifier: MPL-2.0
# (MPL-2.0 preferred; MPL-2.0 required for Julia ecosystem)
# E2E pipeline tests for SMTLib.jl

using Test
using SMTLib

@testset "E2E Pipeline Tests" begin

    # These tests only build SMT-LIB text, which never runs the solver, so they
    # use a solver record that is never executed. `SMTContext()` would look for
    # z3 or cvc5 on PATH and fail on a machine that has neither, such as CI.
    script_only = SMTSolver(:z3, "/nonexistent/z3", "never run")

    @testset "Full SMT-LIB generation pipeline" begin
        # Nested arithmetic and logical expression round-trip through to_smtlib
        exprs = [
            (:(x + y * z),          "(+ x (* y z))"),
            (:((x > 0) && (y < 10)), "(and (> x 0) (< y 10))"),
            (:(!(x == y)),           "(not (= x y))"),
            (:(x >= 0),              "(>= x 0)"),
        ]
        for (expr, expected) in exprs
            @test to_smtlib(expr) == expected
        end
    end

    @testset "SMTContext declare → assert → check_sat pipeline (no solver)" begin
        # These operations must not error even without a solver installed
        ctx = SMTContext(solver=script_only)
        @test ctx isa SMTContext

        declare(ctx, :x, Int)
        declare(ctx, :y, Int)
        assert!(ctx, :(x > 0))
        assert!(ctx, :(y < 10))
        assert!(ctx, :(x + y == 5))

        # Script should contain all three assertions
        script = SMTLib.build_script(ctx, false)
        @test script isa String
        @test occursin("declare-const", script)
        @test occursin("assert", script)
        @test length(collect(eachmatch(r"\(assert", script))) == 3
    end

    @testset "build_script includes check-sat and get-model" begin
        ctx = SMTContext(solver=script_only)
        declare(ctx, :a, Int)
        assert!(ctx, :(a > 100))
        script = SMTLib.build_script(ctx, true)
        @test occursin("check-sat", script)
        @test occursin("get-model", script)
    end

    @testset "Error handling: unknown sort raises an error" begin
        # A Julia type with no SMT-LIB sort mapping has no `smt_type` method
        ctx = SMTContext(solver=script_only)
        @test_throws MethodError declare(ctx, :z, Vector{Int})
        @test isempty(ctx.declarations)
    end

end
